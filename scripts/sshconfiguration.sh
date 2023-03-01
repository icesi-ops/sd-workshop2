# Comando para obtener el estado de todas las máquinas
status_master=$(vagrant status master)
status_node1=$(vagrant status node1)
status_node2=$(vagrant status node2)
echo $status_master
echo $status_node1
echo $status_node2

# Verificar si todas las máquinas están en estado "running"
if [ $(vagrant status | grep "not created" | wc -l) -ge 1 ]
then
 echo "No todas las máquinas están en estado 'running'"
else
   echo "Todas las máquinas están en estado 'running'"
  #ssh a master

  ssh -i .vagrant/machines/master/virtualbox/private_key -o StrictHostKeyChecking=no -y vagrant@192.168.56.11 "sudo gluster peer probe node1; sudo gluster peer probe node2; service glusterd status; sudo gluster pool list; sudo gluster volume create gv1 replica 3 master:/gluster/data/gv1 node1:/gluster/data/gv1 node2:/gluster/data/gv1; sudo gluster volume start gv1; sudo mount.glusterfs master:/gv1 /mnt"
  echo "Master configuration ready"

  #ssh a node1
  ssh -i .vagrant/machines/node1/virtualbox/private_key -o StrictHostKeyChecking=no -y vagrant@192.168.56.12 "sudo mount.glusterfs localhost:/gv1 /mnt"
  echo "Node1 configuration ready"
  
  #ssh a node2
  ssh -i .vagrant/machines/node2/virtualbox/private_key -o StrictHostKeyChecking=no -y vagrant@192.168.56.13 "sudo mount.glusterfs localhost:/gv1 /mnt"
  echo "Node2 configuration ready"

  #ssh a master
  #ssh -i .vagrant/machines/master/virtualbox/private_key -o StrictHostKeyChecking=no -y vagrant@192.168.56.11 "for i in `seq -w 1 100`; do sudo cp -rp /var/log/messages /mnt/copy-test-$i; done"
  echo "Configuración finalizada"

fi