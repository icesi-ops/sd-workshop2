# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  (1..3).each do |i|
   config.vm.define "node#{i}" do |lb|

    n_nodes = 3

     lb.vm.box = "centos/7"
     
     disk_dir = "./disk#{i}.vdi"
     node_ip = "192.168.33.1#{i}"
     node_name = "node#{i}"

     if i == n_nodes then
      node_ip = "192.168.33.200"
      node_name = "master"
     end  

     lb.vm.hostname = node_name
     lb.vm.network "private_network", ip: node_ip
     lb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", node_name]
      unless File.exist?(disk_dir)
       vb.customize ['createhd', '--filename', disk_dir, '--variant', 'Fixed', '--size', 1 * 1024]
      end
     vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk_dir]
     end 
     lb.vm.provision "shell", path: "scripts/glusterfs.sh"
     lb.vm.provision "shell", path: "scripts/configuration.sh"

     if i == n_nodes then
      lb.vm.provision "shell", path: "scripts/master_gluster.sh"
     else
   end

   config.vm.provision "shell", inline: "sudo mount.glusterfs localhost:/gv0 /mnt"

  end
end

