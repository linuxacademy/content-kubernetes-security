chmod +x ./*.sh &>> ./setup-step1.out
echo "1...\n" >> ./setup-step1.out
./turn_off_selinux.sh &>> ./setup-step1.out
echo "12...\n" >> ./setup-step1.out
./turn_off_swap.sh &>> ./setup-step1.out
echo "123...\n" >> ./setup-step1.out
./set_up_bridging.sh &>> ./setup-step1.out
echo "1234\n" >> ./setup-step1.out
cp ./kubernetes.repo /etc/yum.repos.d/kubernetes.repo &>> ./setup-step1.out
echo "Rebooting now...\n" >> ./setup-step1.out
reboot
