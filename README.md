# sd-workshop2 2023-1
sd workshop2

Montar un Sistema de Archivos Distribuido con Glusterfs entre 3 máquinas y automatizar su configuración a través del Vagrantfile, para que quede listo con tan solo hacer vagrat up.

# Entrega Juan Fernando Angulo
El montaje funciona de la siguien manera:
1. En el Vagranfile se definen 3 maquinas, cada una con un disco adjunto, y de las cuales una de ellas (maser) será dónde se cree el volumen compartido con las otras dos maquinas (node1 y node2).
2. Para hacer las configuraciones extras para que funcione el Sistema de Archivos Distribuido, se definieron las instrucciones necesarias a ejecutar en cada máquina dentro de un script de bash externo llamado post-provisioning.sh que se encuentra ubicado en la carpeta de scripts.
3. Puesto que estas configuraciones extras se deben ejecutar una vez que las tres máquinas han sido creadas y esten corriendo, para asegurar esto utilicé un trigger en el Vagrantfile que ejecuta el script post-provisioning.sh después de provisionar cada máquina, y dentro del script a través de un condicional, me aseguro de ejecutar el resto de instrucciones solo cuando las tres máquinas están corriendo.
![Trigger](https://github.com/Juanferas/sd-workshop2/blob/master/screenshots/Script_trigger.PNG "Trigger")
4. Para la ejecucción de las instrucciones, envío los comandos a cada máquina a través de ssh, proporcionando la llave privada de cada máquina para que me deje conectar.
![post-provisioning.sh](https://github.com/Juanferas/sd-workshop2/blob/master/screenshots/post-provisioning_script.png "post-provisioning.sh")
5. Y listo, el Sistema de Archivos Distribuido con Glusterfs ya se encuentra configurado para las trés máquinas y montado en la ruta /mnt.

## Evidencias
A continuación se adjuntan evidencias del funcionamiento durante la ejecución del comando vagrant up y posterior a este:
- Al inicio las máquinas no se han creado y se ejecuta vagrant up.
![Estado inicial](https://github.com/Juanferas/sd-workshop2/blob/master/screenshots/Initial_status.png "Estado incial")
- Al final de la ejecución del vagrant up, justo después de terminar de provisionar la última máquina, se observa que se inicia la ejecución del post-provisioning.sh script y se ve el resultado de cada comando a través de la consola, para al final indicar que el montaje ha terminado exitosamente.
![Montaje exitoso](https://github.com/Juanferas/sd-workshop2/blob/master/screenshots/Glusterfs_mounted.png "Montaje exitoso")
- Para probar que el montaje efectivamente fue exitoso, entramos a la máquina master, revisamos que el punto de montaje se encuentra vacío y creamos unos cuantos archivos de prueba en él, revisamos que se crearon, entramos a las otras dos máquinas y revisamos también.
![Prueba funcionamiento](https://github.com/Juanferas/sd-workshop2/blob/master/screenshots/Working_test.png "Prueba funcionamiento")
Como se comprobó, el montaje se hizo correctamente y el Sistema de Archivos Distribuido funciona.
