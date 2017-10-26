# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
   config.vm.box = "ubuntu/xenial64"
  
   config.vm.provider :virtualbox do |v|
     v.name = "zeus-dev"
     v.memory = 2048
     v.cpus = 2
   end
  
   config.vm.provision :ansible do |ansible|
     ansible.verbose = "vvv"
#     ansible.extra_vars = { "ansible_python_interpreter" => "/usr/bin/python2" }
     ansible.playbook = "main.yml"
   end
end
