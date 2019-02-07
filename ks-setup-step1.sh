chmod +x ./*.sh
./turn_off_selinux.sh
./turn_off_swap.sh
./fstab.sh
./set_up_bridging.sh
cp ./kubernetes.repo /etc/yum.repos.d/kubernetes.repo
reboot
