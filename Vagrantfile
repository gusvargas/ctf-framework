# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "web" do |web|
    web.vm.box = "precise32"
    web.vm.box_url = "http://files.vagrantup.com/precise32.box"
    web.vm.network :forwarded_port, guest: 1337, host: 1337

    web.vm.provision :puppet do |puppet|
      puppet.manifests_path = "puppet/manifests"
      puppet.module_path    = "puppet/modules"
      puppet.manifest_file = "web.pp"
    end
  end
end
