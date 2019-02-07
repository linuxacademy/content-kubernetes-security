chmod +x *.sh &>> ./setup-step2.out 
./yum_install_docker_ce.sh &>> ./setup-step2.out
./yum_install_kube.sh &>> ./setup-step2.out
./enable_start_docker_kube.sh &>> ./setup-step2.out
./set_cgroup_driver.sh &>> ./setup-step2.out

