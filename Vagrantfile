VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	config.vm.box = "debian7-vanilla"

	config.vm.box_url = "https://www.dropbox.com/s/gxouugzbnjlny1k/debian-7.0-amd64-minimal.box"

	config.vm.hostname = "debian-vagrant"

	config.vm.network :private_network, ip: "192.168.56.10"

	config.vm.synced_folder "./", "/vagrant", :nfs => true

	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--memory", "1024"]
	end

	config.vm.provision "shell" do |s|
		s.path = "scripts/postinstall.sh"
		s.args = "192.168.56.10 debian-vagrant production"
	end
end
