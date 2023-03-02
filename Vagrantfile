# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

firstDisk = './firstDisk.vdi'
secondDisk = './secondDisk.vdi'
thirdDisk = './thirdDisk.vdi'
fourthDisk = './fourthDisk.vdi'
Vagrant.configure("2") do |config|

  config.ssh.insert_key = false
  config.vm.define "nodemaster" do |lb|
    lb.vm.box = "centos/7"
    lb.vm.hostname = "nodemaster"
    lb.vm.network "private_network", ip: "192.168.69.10"
    lb.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", "nodemaster"]
     unless File.exist?(firstDisk)
      vb.customize ['createhd', '--filename', firstDisk, '--variant', 'Fixed', '--size', 5 * 1024]
    end
    vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', firstDisk]
    end 
    lb.vm.provision "shell", path: "scripts/glusterfs.sh"
    lb.vm.provision "shell", path: "scripts/configuration.sh"
  end

   config.vm.define "node1" do |node1|
     node1.vm.box = "centos/7"
     node1.vm.hostname = "node-1"
     node1.vm.network "private_network", ip: "192.168.69.100"
     node1.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", "node-1"]
     unless File.exist?(secondDisk)
        vb.customize ['createhd', '--filename', secondDisk, '--variant', 'Fixed', '--size', 5 * 1024]
      end
     vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', secondDisk]
     end
     node1.vm.provision "shell", path: "scripts/glusterfs.sh"
     node1.vm.provision "shell", path: "scripts/configuration.sh"
   end

   config.vm.define "node2" do |node2|
     node2.vm.box = "centos/7"
     node2.vm.hostname = "node-2"
     node2.vm.network "private_network", ip: "192.168.69.101"
     node2.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", "node-2"]
     unless File.exist?(thirdDisk)
        vb.customize ['createhd', '--filename', thirdDisk, '--variant', 'Fixed', '--size', 5 * 1024]
      end
     vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', thirdDisk]
     end
     node2.vm.provision "shell", path: "scripts/glusterfs.sh"
     node2.vm.provision "shell", path: "scripts/configuration.sh" 
   end

end

