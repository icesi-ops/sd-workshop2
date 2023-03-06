# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.ssh.insert_key = false
  
  va = 0

  (1..3).each do |i|
   config.vm.define "node#{i}" do |lb|
     lb.vm.box = "centos/7"
     va = i
     disk_dir = "./disk#{i}.vdi"
     node_ip = "192.168.56.1#{i}"
     node_name = "node#{i}"

     if i == 3 then
      node_ip = "192.168.56.200"
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
     
     lb.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbook.yaml"
      ansible.inventory_path="ansible_hosts.ini"
     end  # end ansible
   end #end lb
   va += 1
  end #end loop

  config.trigger.after :up do |trigger|
    trigger.name = "Mount localhost disk"
    trigger.run = { path: "scripts/nodes_gluster.sh", args: va }
   end #end trigger

end #end config


