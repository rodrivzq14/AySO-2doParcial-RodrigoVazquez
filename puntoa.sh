sudo fdisk /dev/sdc
n
p
enter
enter
1+G

hacemos 3 veces lo de arriba

n
e
enter
+3G

n
enter
+1G

hacemos 2 veces lo de arriba

w

sudo fdisk /dev/sdc
t
1
L
82
w

sudo mkswap /dev/sdc1
sudo swapon /dev/sdc1
free -h

sudo fdisk /dev/sdc
t
2
8e
t
3
8e
t
5
8e
t
6
8e
w

sudo pvcreate /dev/sdc2 /dev/sdc3 /dev/sdc5 /dev/sdc6
sudo vgcreate vgAdmin /dev/sdc2 /dev/sdc3
sudo vgcreate vgDevelopers /dev/sdc5 /dev/sdc6
sudo pvs

sudo lvcreate -L 1G vgDevelopers -n lvDevelopers
sudo lvcreate -L 1G vgDevelopers -n lvTesters
sudo lvcreate -L .8G vgDevelopers -n lvDevops
sudo lvcreate -L 1.9G vgAdmin -n lvAdmin

sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvDevelopers
sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvTesters
sudo mkfs.ext4 /dev/mapper/vgDevelopers-lvDevops
sudo mkfs.ext4 /dev/mapper/vgAdmin-lvAdmin
sudo lsblk -f

sudo mount /dev/mapper/vgDevelopers-lvTesters /mnt/lvTesters
sudo mount /dev/mapper/vgDevelopers-Devops /mnt/lvDevops
sudo mount /dev/mapper/vgDevelopers-lvDevops /mnt/lvDevops
sudo mount /dev/mapper/vgAdmin-lvAdmin /mnt/lvAdmin
