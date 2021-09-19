Vagrant.configure("2") do |config|

  config.vm.define "lb" do |lb|
    lb.vm.box = "centos/7"
    lb.vm.hostname = "lb"
    lb.vm.network "private_network", ip: "192.168.33.200"
    lb.vm.provider "virtualbox" do |vb|
     vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", "lb"]
    end
    lb.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbooks/haproxy/loadbalancer.yml"
      ansible.extra_vars = {
         "web_servers" => [
          {"name": "web-1","ip":"192.168.33.11"},
          {"name": "web-2","ip":"192.168.33.12"}
         ] 
      }
    end
  end
  config.ssh.insert_key = false
  (1..2).each do |i|
   config.vm.define "prueba-#{i}" do |prueba|
     prueba.vm.box = "centos/7"
     prueba.vm.hostname = "prueba-#{i}"
     prueba.vm.network "private_network", ip: "192.168.33.1#{i}"
     prueba.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", "prueba-#{i}"]
     end
     prueba.vm.provision "ansible" do |ansible|
      ansible.playbook = "playbooks/nginx/webserver.yml"
      ansible.groups = {
         "webservers" => ["web-#{i}"]
        }
     end
   end
  end
  config.vm.define "db" do |db|
   db.vm.box = "centos/7"
   db.vm.hostname = "db"
   db.vm.network "private_network", ip: "192.168.33.100"
   db.vm.provision "shell", inline: "echo DB server"
  end
  
end
