chmod +x ./*.sh &>> ./setup-step1.out
./turn_off_selinux.sh &>> ./setup-step1.out
./turn_off_swap.sh &>> ./setup-step1.out
./fstab.sh &>> ./setup-step1.out
./set_up_bridging.sh &>> ./setup-step1.out
cp ./kubernetes.repo /etc/yum.repos.d/kubernetes.repo &>> ./setup-step1.out
reboot
