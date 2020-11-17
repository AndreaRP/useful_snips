# Poner esta linea en /etc/fstab

usr-stor.cnic.es:/ifs/data/data  /data3   nfs4    rw,_netdev,noatime,nodiratime,noacl,auto,user,async,exec,intr,tcp    0 0

# Luego ejecutar 
sudo mount -a 

# =============================================
# Montar shiny server

sshfs -o uid=$(id -u) -o gid=$(id -g) arubio@destination_ip:/home/user/ShinyApps /home/user/shiny_server/
