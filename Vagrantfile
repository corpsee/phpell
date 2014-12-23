VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    #TODO: Migrate to larryli/utopic64
    config.vm.box      = "ubuntu/trusty64"
    config.vm.hostname = "phpell-ubuntu1404"

    #TODO: Moving hostname, ip, timezone and other to config
    config.vm.network :private_network, ip: "192.168.56.10"

    config.vm.synced_folder "./", "/home/vagrant/provision", id: "vagrant-root",
        owner: "vagrant",
        group: "vagrant",
        mount_options: ["dmode=755,fmode=755"]

    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    config.vm.provision "shell" do |s|
        s.path = "scripts/server-install.sh"
    end
end
