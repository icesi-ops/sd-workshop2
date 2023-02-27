#!/bin/bash

if [ $(vagrant status | grep "not created" | wc -l) -ge 1 ]
then
  echo "[!] Aún no están corriendo ni han sido provisionadas todas la maquinas"
else
  echo -e "[+] Todas las maquinas han sido provisionadas y están corriendo\n\nEjecutando configuraciones extras para el Sistema de Archivos Distribuido..."
  # Extraer las llaves privadas para realizar la conexión SSH
  master_private_key=$(vagrant ssh-config master | grep "IdentityFile" | sed 's/IdentityFile//' | xargs)
  node1_private_key=$(echo $master_private_key | sed "s/master/node1/")
  node2_private_key=$(echo $master_private_key | sed "s/master/node2/")
  # Ejecutar los scripts de post-provisioning en cada máquina a través de SSH
  ssh -i "$master_private_key" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -y vagrant@192.168.56.11 "sudo gluster peer probe node1; sudo gluster peer probe node2; sudo gluster pool list; sudo gluster volume create gv0 replica 3 master:/gluster/data/gv0 node1:/gluster/data/gv0 node2:/gluster/data/gv0; sudo gluster volume start gv0; sudo gluster volume status; sudo mount.glusterfs master:/gv0 /mnt"
  ssh -i "$node1_private_key" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -y vagrant@192.168.56.12 "sudo mount.glusterfs localhost:/gv0 /mnt"
  ssh -i "$node2_private_key" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -y vagrant@192.168.56.13 "sudo mount.glusterfs localhost:/gv0 /mnt"
  echo -e "[+] Script de post-provisionamiento ejecutado correctamente :)\n\nEl punto de montaje es /mnt"
fi
