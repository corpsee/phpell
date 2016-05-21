VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box      = "ubuntu/trusty64"
    config.vm.hostname = "phpell-ubuntu-1404"

    config.vm.network :private_network, ip: "192.168.56.10"

    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    config.vm.provision "shell" do |s|
        s.path = "scripts/server-install.sh"
        s.args = "/vagrant"
    end

    config.vm.synced_folder "./", "/vagrant"
end
