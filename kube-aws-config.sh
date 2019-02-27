aws ec2 create-key-pair --key-name ks-lab-key --query 'KeyMaterial' --output text > ks-lab-key.pem
chmod 400 ks-lab-key.pem
export AWS_KMS_KEY=$(aws kms create-key | grep Arn | awk '{print $2}' | sed 's/,*$//g' | sed 's/\"//g')
echo "AWS Key:" $AWS_KMS_KEY
export AWS_HOSTED_ZONE="$(aws route53 list-hosted-zones | jq '.HostedZones[0] .Name' | tr -d '"' | sed 's/\.$//' )"
echo "Hosted Zone:" $AWS_HOSTED_ZONE
export AWS_HOSTED_ZONE_ID="$(aws route53 list-hosted-zones | jq '.HostedZones[0] .Id' | tr -d '"' | sed 's/\.$//' )"
echo "Hosted Zone ID:" $AWS_HOSTED_ZONE_ID
aws s3 mb s3://k8s3.$AWS_HOSTED_ZONE
export AWS_S3_BUCKET=s3://k8s3.$AWS_HOSTED_ZONE
echo "kube-aws init \"
echo "  --cluster-name=k8s-ks-lab \"
echo "  --region=us-east-1 \"
echo "  --availability-zone=us-east-1c \"
echo "  --hosted-zone-id=$AWS_HOSTED_ZONE_ID \"
echo "  --external-dns-name=k8s.$AWS_HOSTED_ZONE \"
echo "  --key-name=ks-lab-key \"
echo "  --kms-key-arn=$AWS_KMS_KEY \"
echo "  --s3-uri=$AWS_S3_BUCKET\n"
kube-aws init \
  --cluster-name=k8s-ks-lab \
  --region=us-east-1 \
  --availability-zone=us-east-1c \
  --hosted-zone-id=$AWS_HOSTED_ZONE_ID \
  --external-dns-name=k8s.$AWS_HOSTED_ZONE \
  --key-name=ks-lab-key \
  --kms-key-arn=$AWS_KMS_KEY \
  --s3-uri=$AWS_S3_BUCKET
