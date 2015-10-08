VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box      = "larryli/vivid64"
    #config.vm.hostname = "phpell-ubuntu-1504"

    config.vm.provision :shell, inline: "hostnamectl set-hostname phpell-ubuntu-1504"

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
        s.args = "/home/vagrant/provision"
    end
end
