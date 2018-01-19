Vagrant.configure(2) do |config|
  config.vm.define "docker" do |d|
    d.vm.box = "centos-7.4-x86_64-minimal"
    d.vm.hostname = "docker"
    d.vm.network :private_network, type: "dhcp"
    d.ssh.insert_key = false
    d.vm.provider :virtualbox do |v|
      v.customize [
		"modifyvm", :id,
		"--natdnshostresolver1", "on",
		"--memory", 2048,
		"--name", "docker"
	  ]
    end
    #d.vm.provision 'shell', inline: <<-EOF
    #EOF
    #d.vm.provision "shell", path: "java_setup.sh"
	#d.vm.provision "shell", path: "docker_setup.sh"
    #jnk.vm.provision "shell", path: "nginx_setup.sh"
    #jnk.vm.provision "shell", path: "jenkins_setup.sh" 
  end
end
