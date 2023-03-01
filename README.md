# Workshop-2
se definen tres máquinas virtuales: "master", "node1" y "node2". Cada máquina virtual se le configura del almacenamiento y la asignación de discos duros virtuales. Se definen tres discos duros virtuales diferentes y se asigna uno a cada máquina virtual. Se utilizan archivos de disco duro virtual (.vdi) para cada uno de los discos duros.

Se automatiza el proceso de configuración de gluster, que incluye el unir los nodos, crear los volumenes y montar los volumenes. 

## Explicación

Para realizar la configuración de gluster se requería esperar el levantamiento de las máquinas virtuales y mediante "vagrant ssh vm" hacer la configuración por cada una de estas máquinas. Los comandos necesarios para este proceso eran los siguientes

![Comandos configuración gluster](https://github.com/dannasofiagarcia/sd-workshop2/blob/master/img/configuraciongluster.png)

Esto se automatiza en el Vagrantfile mediante un Bash Script en el que se requieren dos cosas

### Verificar que las máquinas virtuales están todas en estado "running"

![Vagrant status](https://github.com/dannasofiagarcia/sd-workshop2/blob/master/img/vagrantstatus.png)


### SSH máquinas virtuales sin hacer "vagrant up" y sin contar con la opción "vagrant ssh vm"

Para poder hacer SSH a las máquinas virtuales se requiere de la dirección de la Private Key y de la opción StrictHostKeyChecking=no donde SSH no pedirá confirmación al conectarse a un host remoto por primera vez. Adicionalmente los comandos necesarios por cada máquina van entre paréntesis y separados por ";".

![SSH máquinas sin "vagrant ssh"](https://github.com/dannasofiagarcia/sd-workshop2/blob/master/img/sshprocess.png)


## Evidencia funcionamiento

En cuanto se termina el provisionamiento de master, node1 y node2, se verifica que el estado de las tres máquinas sean "running" y como podemos evidenciar en la siguiente imagen, empieza la configuración automatizada del gluster

![Trigger](https://github.com/dannasofiagarcia/sd-workshop2/blob/master/img/trigger.png)

Para comprobar que la configuración fue correcta, ejecutamos en master el siguiente comando

"for i in `seq -w 1 100`; do sudo cp -rp /var/log/messages /mnt/copy-test-$i; done"

Que creará 100 copias del archivo en la ruta especificada, de estar funcionando correctamente toda la configuración, estas copias deberían estar igualmente en node1 y node2. 

![Prueba funcionamiento](https://github.com/dannasofiagarcia/sd-workshop2/blob/master/img/lsmnt.png)

Comprobamos que la configuración automatizada del gluster funciona correctamente. Adicionalmente, este problema podría abordarse de manera más sencilla por medio de Ansible.


      

