# sd-workshop2 2022-1
sd workshop2

- En el presente repositorio se encuentra la automatización de la creación de un file system con 3  nodos. Y la creación de un volumen con replica en los 3 nodos.

- Para la automatización de la creación de la infraestructura se utiliza un archivo Vagrantfile que levanta 3 VM Centos/7 con su respectivas direcciones IP.

- El aprovisionamiento se divide en 2 partes. Primero se ejecutan scripts directamente enlazados al Vagrantfile para la instalación de los paquetes necesarios de gluster y la configuración de los hosts.

- Luego, se utiliza la herramienta Ansible para automatizar la creación del volumen y la sincronización.

- Guía de ejecución:
	vagrant up
	ansible-playbook main.yml
