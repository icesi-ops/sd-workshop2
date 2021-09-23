Vagrant.configure("2") do |config|
config.ssh.insert_key = false
  (1..2).each do |i|
   config.vm.define "machineWeb-#{i}" do |machineWeb|
     machineWeb.vm.box = "centos/7"
     machineWeb.vm.hostname = "machineWeb-#{i}"
     machineWeb.vm.network "private_network", ip: "192.168.33.1#{i}"
    
     machineWeb.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "1", "--name", "machineWeb-#{i}"]
     end
     
     machineWeb.vm.provision "ansible" do |ansible|
     ansible.playbook = "playbooks/nginx/nginx.yml"
     ansible.groups = {
       "servers" => ["machineWeb-#{i}"]
       }
     
   end
  end
end


end
