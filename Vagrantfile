# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	config.vm.hostname = "slippery-otter-box"
	config.ssh.forward_agent = true

	# VirtualBox specific configurations
	config.vm.provider :virtualbox do |vb|

		# How much memory to use?
		vb.customize ["modifyvm", :id, "--memory", 2048]

		# How many CPUs to use? Default to 1
		vb.customize ["modifyvm", :id, "--cpus", 1]

		vb.customize ["modifyvm", :id, "--vram", 256]

		# vb.gui = true   # no gui as of 0.4.0
		vb.name = "SOS Box"


	end

	# The most common configuration options are documented and commented below.
	# For a complete reference, please see the online documentation at
	# https://docs.vagrantup.com.

	# Every Vagrant development environment requires a box. You can search for
	# boxes at https://atlas.hashicorp.com/search.

	##############################################################################################
	# Ubuntu 14.04
	config.vm.box = "puppetlabs/ubuntu-14.04-32-puppet"
	config.vm.box_url = "https://vagrantcloud.com/puppetlabs/boxes/ubuntu-14.04-32-puppet/versions/1.0.2/providers/virtualbox.box"

	config.vm.network "private_network", ip: "192.168.20.16"

	# Installation of all required libraries
	preCmd = "echo 'deb http://cz.archive.ubuntu.com/ubuntu precise main universe' | sudo tee -a /etc/apt/sources.list; sudo apt-get -qq install -y gcc; sudo apt-get -qq update"

	packageCmd = "sudo apt-get -qq install -y"
	packageList = [
		"software-properties-common",
		"libtiff4",
		"git",
		"libzmq3-dev",
		"python-dev",
		"postgresql",
		"postgresql-contrib",
		"postgis",
		"libssl-dev",
		"libnetcdf-dev",
		"netcdf-bin",
		"libgeos-dev",
		"libgdal-dev",
		"libproj-dev",
	];

	# Run the initialization only the first time...
	if Dir.glob("#{File.dirname(__FILE__)}/.vagrant/machines/default/*/id").empty?

		inlineScript = ""

		if preCmd != ""
			inlineScript << preCmd << " ; "
		end

		# install packages we need we need
		inlineScript << packageCmd << " " << packageList.join(" ") << " ; "
		config.vm.provision :shell, :inline => inlineScript


	end

	# Install the puppetlabs-postgresql module found here: https://forge.puppetlabs.com/puppetlabs/postgresql
	config.vm.provision "shell", inline: "puppet module install puppetlabs-postgresql"

	# install the roles and database using the Puppet repo.
	config.vm.provision "shell", inline: "/opt/puppetlabs/bin/puppet apply /vagrant/db/postgres.pp; /opt/puppetlabs/bin/puppet apply /vagrant/db/postgres_hba.pp; /etc/init.d/postgresql restart"

	# Add the custome funstions and the postgis library to the postgres installation under the public schema
	config.vm.provision "shell", path: "db/add_public_functions.sh"

	# install Conda and the required python packages for notebooks
	config.vm.provision "shell", path: "miniconda_install.sh"

	# Create a shared folder for data
	config.vm.synced_folder "data", "/home/vagrant/data",
		create:true

	config.vm.provision "shell", inline: "export PATH=/opt/anaconda/bin:$PATH; source /home/vagrant/.bashrc; python ~/data/mircs-geogenealogy/mircsgeo/manage.py runserver 0.0.0.0:8000 &",
		run: "always",
		privileged:false

	# Disable automatic box update checking. If you disable this, then
	# boxes will only be checked for updates when the user runs
	# `vagrant box outdated`. This is not recommended.
	# config.vm.box_check_update = false

	# Create a forwarded port mapping which allows access to a specific port
	# within the machine from a port on the host machine. In the example below,
	# accessing "localhost:8080" will access port 80 on the guest machine.
	# config.vm.network "forwarded_port", guest: 80, host: 8080


	# Create a public network, which generally matched to bridged network.
	# Bridged networks make the machine appear as another physical device on
	# your network.
	# config.vm.network "public_network"

	# Share an additional folder to the guest VM. The first argument is
	# the path on the host to the actual folder. The second argument is
	# the path on the guest to mount the folder. And the optional third
	# argument is a set of non-required options.
	# config.vm.synced_folder "../data", "/vagrant_data"

	# Provider-specific configuration so you can fine-tune various
	# backing providers for Vagrant. These expose provider-specific options.
	# Example for VirtualBox:
	#
	# config.vm.provider "virtualbox" do |vb|
	# 	# Display the VirtualBox GUI when booting the machine
	# 	vb.gui = true
	#
	#   # Customize the amount of memory on the VM:
	#   vb.memory = "1024"
	# end
	#
	# View the documentation for the provider you are using for more
	# information on available options.

	# Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
	# such as FTP and Heroku are also available. See the documentation at
	# https://docs.vagrantup.com/v2/push/atlas.html for more information.
	# config.push.define "atlas" do |push|
	#   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
	# end

	# Enable provisioning with a shell script. Additional provisioners such as
	# Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
	# documentation for more information about their specific syntax and use.
	# config.vm.provision "shell", inline: <<-SHELL
	#   sudo apt-get update
	#   sudo apt-get install -y apache2
	# SHELL
end
