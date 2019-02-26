export AWS_HOSTED_ZONE="$(aws route53 list-hosted-zones | jq '.HostedZones[0] .Name' | tr -d '"' | sed 's/\.$//' )"
echo "Hosted Zone:" $AWS_HOSTED_ZONE
echo "CREATING S3 BUCKET"
echo "=================="
aws s3 mb s3://k8s3.$AWS_HOSTED_ZONE
export KOPS_STATE_STORE=s3://k8s3.$AWS_HOSTED_ZONE
export KOPS_CLUSTER_NAME=k8s.$AWS_HOSTED_ZONE
echo "CREATING RSA KEY"
echo "================="
ssh-keygen -q -f ./.ssh/id_rsa -N ''
echo "CREATING CLUSTER"
echo "================="
kops create cluster --master-size=t2.medium --zones=us-east-1c --name=$KOPS_CLUSTER_NAME
