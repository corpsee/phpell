VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	config.vm.box = "puppetlabs/ubuntu-13.10-64-nocm"

	# For vagrant vesion < 1.5
	#config.vm.box_url = "https://vagrantcloud.com/puppetlabs/ubuntu-14.04-64-nocm/version/2/provider/virtualbox.box"
	#config.vm.box_url = "https://vagrantcloud.com/puppetlabs/ubuntu-13.10-64-nocm/version/2/provider/virtualbox.box"

	config.vm.hostname = "vm-ubuntu-13-10"

	#TODO: Moving hostname, ip, timezone and other to config
	config.vm.network :private_network, ip: "192.168.56.10"

	config.vm.synced_folder "./", "/vagrant", :nfs => true

	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--memory", "1024"]
	end

	config.vm.provision "shell" do |s|
		s.path = "scripts/server-install.sh"
		s.args = "192.168.56.10 vm-ubuntu-1310 production Asia/Novosibirsk"
	end
end
