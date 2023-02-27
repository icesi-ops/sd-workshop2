# -*- mode: ruby -*-
# vi: set ft=ruby :

firstDisk = "./firstDirk.vdi"
secondDisk = "./secondDirk.vdi"
thirdDisk = "./thirdDirk.vdi"

Vagrant.configure("2") do |config|

  config.vm.define "node1" do |node1|
    node1.vm.box = "centos/7"
    node1.vm.hostname = "node-1"
    node1.vm.network "private_network", ip: "192.168.56.12"
    node1.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", "node-1"]
      unless File.exist?(secondDisk)
        vb.customize ['createhd', '--filename', secondDisk, '--variant', 'Fixed', '--size', 5 * 1024]
      end
      vb.customize ['storageattach', :id, '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', secondDisk]
    end
    node1.vm.provision "shell", path: "scripts/glusterfs.sh"
    node1.vm.provision "shell", path: "scripts/configuration.sh"
  end

  config.vm.define "node2" do |node2|
    node2.vm.box = "centos/7"
    node2.vm.hostname = "node-2"
    node2.vm.network "private_network", ip: "192.168.56.13"
    node2.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", "node-2"]
      unless File.exist?(thirdDisk)
        vb.customize ['createhd', '--filename', thirdDisk, '--variant', 'Fixed', '--size', 5 * 1024]
      end
      vb.customize ['storageattach', :id, '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', thirdDisk]
    end
    node2.vm.provision "shell", path: "scripts/glusterfs.sh"
    node2.vm.provision "shell", path: "scripts/configuration.sh"
  end

  config.vm.define "master" do |server|
    server.vm.box = "centos/7"
    server.vm.network "private_network", ip: "192.168.56.11"
    server.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", "master-node"]
      unless File.exist?(firstDisk)
        vb.customize ["createhd", "--filename", firstDisk, "--variant", "Fixed", "--size", 5*1024]
      end
      vb.customize ["storageattach", :id, "--storagectl", "IDE", "--port", 1, "--device", 0, "--type", "hdd", '--medium', firstDisk]
    end
    server.vm.provision "shell", path: "scripts/glusterfs.sh"
    server.vm.provision "shell", path: "scripts/configuration.sh"
  end

  # Ejecución de script de post-provisionamiento
  config.trigger.after :up do |trigger|
    trigger.run = {path: "scripts/post-provisioning.sh"}
  end

end
