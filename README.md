# sd-workshop2 2022-1
sd workshop2

En este workshop, se automatiza la configuracion de un servidor master y dos nodos de Gluster. Para esto, se utiliza la herramienta de Ansible para configurar las maquinas virtuales. 

## 01-master-conf.yml
En primer lugar, se inicia el servicio de glusterd. Despues, secrea el archivo de configuracion del servidor master. En este archivo se establece la conexion con los nodos (1 y 2) usando un codigo en shell que realiza la instruccion de "gluster peer probe". 

Una vez establecida la conexion con los nodos, se crea un volumen llamado "gv0" el cual se va a replicar en los 3 nodos (master, node1 y node2). Es decir, que la carpeta data va a tener los datos compartidos del almacenamiento distribuido. 

Finalmente, se inicializa el volumen. 

## 02-node-conf.yml
Para la configuracion de los nodos, se monta el volumen gv0 creado en el master en la carpeta mnt. Despues, se configura que para cada nodo se cree un archivo de texto. 

Para probar si esta funcionando el gluster, simplemente se accede a la carpeta de data y ahi se pueden encontrar ambos archivos. :)

##¿Cómo probar?
Para probar la configuracion realizada en Ansible, simplemente se realiza:

$ vagrant up
$ ansible-playbook ./playbooks/01-master-conf.yml
$ ansible-playbook ./playbooks/02-node-conf.yml
$ vagrant ssh node1
$ cd /data/ | ls 

Con esto podemos ver que se crearon ambos archivos y estos se replicaron en el directorio de /data

