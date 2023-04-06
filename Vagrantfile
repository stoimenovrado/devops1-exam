
  Vagrant.configure("2") do |config|

    config.vm.define "monitoring" do |monitoring|
        monitoring.vm.box="shekeriev/debian-11"
        monitoring.vm.hostname = "monitoring.do1.exam"
        monitoring.vm.network "private_network", ip: "192.168.69.201"
        monitoring.vm.network "forwarded_port", guest: 3000, host: 8082, auto_correct: true
        monitoring.vm.provision "shell", path: "add-hosts.sh"
        monitoring.vm.provision "shell", path: "monitoring/docker-setup.sh"
        monitoring.vm.provision "shell", path: "monitoring/monitoring-up.sh"
        monitoring.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--memory", "3072"]
        end
    end
	
    config.vm.define "containers" do |containers|
        containers.vm.box="shekeriev/debian-11"
        containers.vm.hostname = "containers.do1.exam"
        containers.vm.network "private_network", ip: "192.168.69.202"
        containers.vm.network "forwarded_port", guest: 8080, host: 8081, auto_correct: true
        containers.vm.provision "shell", path: "add-hosts.sh"
        containers.vm.provision "shell", path: "docker/install-docker.sh"
        containers.vm.provision "shell", path: "docker/docker-expose.sh"
        containers.vm.provision "shell", path: "gitea/setup-gitea.sh"
        containers.vm.provision "shell", path: "node-exporter.sh"
        containers.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--memory", "3072"]
        end
    end
	
    config.vm.define "pipelines" do |pipelines|
        pipelines.vm.box="shekeriev/debian-11"
        pipelines.vm.hostname = "pipelines.do1.exam"
        pipelines.vm.network "private_network", ip: "192.168.69.203"
        pipelines.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true
        pipelines.vm.provision "shell", path: "add-hosts.sh"
        pipelines.vm.provision "shell", path: "jenkins/install-jenkins.sh"
        pipelines.vm.provision "shell", path: "jenkins/setup-jenkins.sh"
        pipelines.vm.provision "shell", path: "node-exporter.sh"
        pipelines.vm.provider :virtualbox do |vb|
            vb.customize ["modifyvm", :id, "--memory", "3072"]
        end
    end
  
  end
  