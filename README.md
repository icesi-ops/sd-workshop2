# Ansible Implementation - Load Balancer
In this workshop we had to deploy 2 web servers with a load balancer and a database. 


#### These 5 Ansible Facts are intended to check the correct functioning of load balancing.
		
		{{ansible_distribution}}
		
		{{print_hostname.stdout}}

		{{ansible_interfaces}}
 		
		{{ansible_kernel}}
		
		{{ansible_processor}}

