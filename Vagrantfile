# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure("2") do |config|

  (1..3).each do |i|
  config.vm.define "node#{i}" do |lb|
    lb.vm.box ="centos/7" 
    disk_name = "./disk#{i}.vdi"
    node_ip = "192.168.56.1#{i}"
    node_hostname = "node#{i}"

    if i == 3 then    
     node_ip = "192.168.56.200"
    end

    lb.vm.hostname = node_hostname
    lb.vm.network "private_network", ip: node_ip 
    lb.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", node_hostname]
     unless File.exist?(disk_name)
      vb.customize ['createhd', '--filename', disk_name, '--variant', 'Fixed', '--size', 5 * 1024]
    end
    vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk_name]
    end 
    lb.vm.provision "shell", path: "scripts/glusterfs.sh"
    lb.vm.provision "shell", path: "scripts/configuration.sh"
  end
end

  config.trigger.after :up do |trigger|
    trigger.run = {path: "scripts/glusterconfig.sh"}
  end

end
