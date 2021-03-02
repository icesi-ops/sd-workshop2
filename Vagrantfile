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
   config.vm.define "web-#{i}" do |web|
     web.vm.box = "centos/7"
     web.vm.hostname = "web-#{i}"
     web.vm.network "private_network", ip: "192.168.33.1#{i}"
     web.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", "web-#{i}"]
     end
     web.vm.provision "ansible" do |ansible|

      if i == 1
        ansible.extra_vars = {
          serverName: "Juancho",
          serverAdmin: "JuanchoVelez",
          adminEmail: "velezolaya2012@hotmail.com",
          adminNumber: "3216310225",
          adminHobby: "Sing"
        }
      else
        ansible.extra_vars = {
          serverName: "Juancho",
          serverAdmin: "JuanchoPro",
          adminEmail: "juanchovelez98@gmail.com",
          adminNumber: "3206952107",
          adminHobby: "Play COD"
        }
      end

      ansible.playbook = "playbooks/httpd/webserver.yml"
      ansible.groups = {
         "servers" => ["web-#{i}"]
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