sudo gluster peer probe node1
sudo gluster peer probe node2

sudo gluster pool list

sudo gluster volume create gv0 replica 3 master:/gluster/data/gv0/ node1:/gluster/data/gv0 node2:/gluster/data/gv0
sudo gluster volume set gv0 auth.allow 127.0.0.1
sudo gluster volume start gv0

#sudo mount.glusterfs master:/gv0 /mnt
