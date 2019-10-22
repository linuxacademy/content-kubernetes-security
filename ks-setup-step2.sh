chmod +x *.sh &>> ./setup-step2.out 
echo "1...\n" >> ./setup-step2.out
./yum_install_docker_ce.sh &>> ./setup-step2.out
echo "12...\n" >> ./setup-step2.out
./yum_install_kube.sh &>> ./setup-step2.out
echo "123...\n" >> ./setup-step2.out
./enable_start_docker_kube.sh &>> ./setup-step2.out
echo "1234...\n" >> ./setup-step2.out
./set_up_bridging.sh &>> ./setup-step2.out
echo "Complete.\n" >> ./setup-step2.out
