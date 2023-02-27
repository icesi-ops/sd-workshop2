# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  (1..3).each do |i|
   config.vm.define "node#{i}" do |lb|
     lb.vm.box = "centos/7"
     
     disk_dir = "./disk#{i}.vdi"
     node_ip = "192.168.33.1#{i}"
     node_name = "node#{i}"

     if i == 3 then
      node_ip = "192.168.33.200"
      node_name = "master"
     end  #end if

     lb.vm.hostname = node_name
     lb.vm.network "private_network", ip: node_ip
     lb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", node_name]
      unless File.exist?(disk_dir)
       vb.customize ['createhd', '--filename', disk_dir, '--variant', 'Fixed', '--size', 1 * 1024]
      end #end unless
     vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk_dir]
     end #end vb
     lb.vm.provision "shell", path: "scripts/glusterfs.sh"
     lb.vm.provision "shell", path: "scripts/configuration.sh"

     if (i == 3) then
      lb.vm.provision "shell", path: "scripts/master_gluster.sh"
     end  #end if

   end #end lb
  end #end loop

  # Add trigger to run script on all VMs after they have been started
  config.trigger.after :up do |trigger|
    trigger.info = "Running script on all VMs"
    trigger.run = { path: "scripts/nodes_gluster.sh" }
  end

end #end config


