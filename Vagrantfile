# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure("2") do |config|

  #SSH key insertion disable
  config.ssh.insert_key = false

  #Loop for VM creation
  (1..3).each do |i|

    node_name = "node#{i}"

    config.vm.define "node-#{i}" do |lb|
      lb.vm.box = "centos/7"
      lb.vm.hostname = node_name
      lb.vm.network "private_network", ip: "192.168.56.1#{i}"
      lb.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", node_name]
        disk_var = "./disk#{i}.vdi"
        unless File.exist?(disk_var)
          vb.customize ['createhd', '--filename', disk_var, '--variant', 'Fixed', '--size', 5 * 1024]
        end
        vb.customize ['storageattach', :id, '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk_var]
      end
      lb.vm.provision "shell", path: "scripts/glusterfs.sh"
      lb.vm.provision "shell", path: "scripts/configuration.sh"
    end
  end
end
