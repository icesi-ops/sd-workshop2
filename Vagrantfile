# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|

  config.ssh.insert_key = false
  (1..3).each do |i|
    config.vm.define "node-#{i}" do |lb|
     lb.vm.box = "centos/7"
     
     disk_var = "./disk#{i}.dvi"
     node_name = "node#{i}"
     
     lb.vm.hostname = node_name
     lb.vm.network "private_network", ip: "192.168.56.1#{i}"
     lb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", node_name]
      unless File.exist?(disk_var)
       vb.customize ['createhd', '--filename', disk_var, '--variant', 'Fixed', '--size', 5 * 1024]
      end
      vb.customize ['storageattach', :id,  '--storagectl', 'IDE', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk_var]
     end 
     lb.vm.provision "shell", path: "scripts/glusterfs.sh"
     lb.vm.provision "shell", path: "scripts/configuration.sh"
    end
  end
end
