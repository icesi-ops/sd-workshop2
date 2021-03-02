# sd-workshop2

In this workshop we had to deploy 2 web servers with a load balancer and a database.
Also, we have to use some variables of Ansible in templates.

The variables used in the templates can be found in three ways:

- As a Ansible extra vars. (In the [Vagrantfile](https://github.com/juanchovelezpro/sd-workshop2/blob/master/Vagrantfile "Vagrantfile"))

For web server # 1
```ruby
ansible.extra_vars = {
          serverName: "Juancho",
          serverAdmin: "JuanchoVelez",
          adminEmail: "velezolaya2012@hotmail.com",
          adminNumber: "3216310225",
          adminHobby: "Sing"
        }
```
For web server # 2

```ruby
        ansible.extra_vars = {
          serverName: "Juancho",
          serverAdmin: "JuanchoPro",
          adminEmail: "juanchovelez98@gmail.com",
          adminNumber: "3206952107",
          adminHobby: "Play COD"
        }
```


 -  As registered variable (In the  playbook declared in [webserver.yml](https://github.com/juanchovelezpro/sd-workshop2/blob/master/playbooks/httpd/webserver.yml "webserver.yml") and used in [index.j2](https://github.com/juanchovelezpro/sd-workshop2/blob/master/playbooks/httpd/templates/index.j2 "index.j2"))

```yaml
          - name: "Know Hostname"
            shell: "echo $HOSTNAME"
            register: print_hostname
          - name: "Free RAM"
            shell: "free -m | awk '{print $4}' | sed -n 2p"
            register: free_ram
          - name: "Date"
            shell: "date"
            register: print_date
```

-  As a ansible facts (in [index.j2](https://github.com/juanchovelezpro/sd-workshop2/blob/master/playbooks/httpd/templates/index.j2 "index.j2"))

```html
	<h6 class="project-subtitle">Machine Hostname: {{ansible_hostname}}</h3>
	<h6 class="project-subtitle">Machine IP Address: {{ansible_eth1.ipv4.address}}</h3>
	<h6 class="project-subtitle">Machine MAC Address: {{ansible_eth1.macaddress}}</h3>
	<h6 class="project-subtitle">Machine Architecture: {{ansible_architecture}}</h3>
	<h6 class="project-subtitle">Machine Distribution: {{ansible_distribution}}</h3>
	<h6 class="project-subtitle">Machine Dist. Version: {{ansible_distribution_version}}</h3>
```
-  As a vars file (declared in [main.yml](http://https://github.com/juanchovelezpro/sd-workshop2/blob/master/playbooks/httpd/vars/main.yml "main.yml") and used in [webserver.yml](https://github.com/juanchovelezpro/sd-workshop2/blob/master/playbooks/httpd/webserver.yml "webserver.yml"))

`
path_page: /var/www/html`
