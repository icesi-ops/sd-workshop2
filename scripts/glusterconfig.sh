#!/bin/bash


if [ $(vagrant status | grep "not created" | wc -l) -ge 1 ]; then

echo -e "Todavia faltan maquinas para que esten arriba"

else

# Definir la ruta base de las máquinas de Vagrant
VAGRANT_DIR="./.vagrant/machines/node"

# Iterar por cada máquina de Vagrant
for i in {1..3}; do
    MACHINE="node$i"
    MACHINE_DIR="$VAGRANT_DIR$i/virtualbox"
    MACHINE_MASTER="node3"
    # Verificar si existe el archivo de llave privada
    if [ -f "$MACHINE_DIR/private_key" ]; then
        PRIVATE_KEY="$MACHINE_DIR/private_key"
	
	if [ "$MACHINE_MASTER" = "$MACHINE" ]; then
	 ssh -i "$PRIVATE_KEY" -o StrictHostKeyChecking=no -y vagrant@192.168.56.200 "sudo gluster peer probe node1; sudo gluster peer probe node2; sudo gluster pool list; sudo gluster volume create gv0 replica 3 node3:/gluster/data/gv0 node1:/gluster/data/gv0 node2:/gluster/data/gv0; sudo gluster volume start gv0; sudo gluster volume status; sudo mount.glusterfs node3:/gv0 /mnt"
	else
	
	ssh -i "$PRIVATE_KEY" -o StrictHostKeyChecking=no -y vagrant@"$MACHINE"	"sudo mount.glusterfs localhost:/gv0 /mnt"

	fi
        echo "Máquina: $MACHINE"
        echo "Llave privada: $PRIVATE_KEY"
        echo ""
    else
        echo "No se encontró la llave privada para la máquina $MACHINE"
    fi
done

fi
