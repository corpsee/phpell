VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	config.vm.box = "astral1/saucy64"

	# For vagrant vesion < 1.5
	#config.vm.box_url = "https://vagrantcloud.com/astral1/saucy64/version/1/provider/virtualbox.box"

	config.vm.hostname = "debian-vagrant"

	config.vm.network :private_network, ip: "192.168.56.10"

	config.vm.synced_folder "./", "/vagrant", :nfs => true

	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--memory", "1024"]
	end

	config.vm.provision "shell" do |s|
		s.path = "scripts/postinstall.sh"
		s.args = "192.168.56.10 debian-vagrant production Asia/Novosibirsk"
	end
end
