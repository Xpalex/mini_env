#---------------------------------------------------------------
# Run Jenkins Server
#---------------------------------------------------------------
resource "google_compute_instance" "jenkins_srv" {
  name         = "jenkins"
  machine_type = "f1-micro"
  zone         = "us-central1-b"
  
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  
# Install ssh key
  metadata = {
    sshKeys = "${var.instance_username}:${file(var.public_key_ans_ins)}"
  }
  
# Network
  network_interface {
    network = google_compute_network.vpc.name
    subnetwork   = google_compute_subnetwork.private_subnet.self_link
    network_ip = "${google_compute_address.jenkins_address.self_link}"
    
    access_config {
      
    }
  }
}
#---------------------------------------------------------------
# Run Docker Server
#---------------------------------------------------------------
resource "google_compute_instance" "docker_srv" {
  name         = "docker"
  machine_type = "f1-micro"
  zone         = "us-central1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
 
 metadata = {
    sshKeys = "${var.instance_username}:${file(var.public_key_ans_ins)}"
}

# Send to Server docker script 
  provisioner "file" {
    source      = "../srv_docker_data"
    destination = "/tmp/srv_docker_data"
  }
  
# Connect to Server  
  connection {
    type        = "ssh"
    host        = "${google_compute_instance.docker_srv.network_interface.0.access_config.0.nat_ip}"
    user        = "${var.instance_username}"
    private_key = "${file("${var.private_key_ans_ins}")}"
  }
# Network  
   network_interface {
    network = google_compute_network.vpc.name
    subnetwork   = google_compute_subnetwork.private_subnet.self_link
    network_ip =   google_compute_address.docker_address.self_link

    access_config {
      // Ephemeral IP
    }
  }
}
#---------------------------------------------------------------
# Run Ansible Server
#---------------------------------------------------------------
resource "google_compute_instance" "ansible_srv" {
  name         = "ansible"
  machine_type = "f1-micro"
  zone         = "us-central1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
# Send to Server folder with ansible scripts  for install
  provisioner "file" {
    source      = "../srv_ansible_data"
    destination = "/tmp/srv_ansible_data"
  }
  
# Send to Keys to connect to Docker and Jenkins
  provisioner "file" {
    source      = "${var.private_key_ans_ins}"
    destination = "/home/${var.instance_username}/.ssh/${var.private_key_ans_ins}"
  }
  
# Run commands for install ansible  
  provisioner "remote-exec" {
    inline      = [ "chmod 400 /home/${var.instance_username}/.ssh/${var.private_key_ans_ins}",
                    "chmod +x /tmp/srv_ansible_data/install_ansible.sh",
                    "sudo /tmp/srv_ansible_data/install_ansible.sh"                                  
                  ]
  }

# Install ssh key
  metadata = {
    sshKeys = "${var.instance_username}:${file(var.public_key)}"
  }
  
# Connect to Server  
  connection {
    type        = "ssh"
    host        = "${google_compute_instance.ansible_srv.network_interface.0.access_config.0.nat_ip}"
    user        = "${var.instance_username}"
    private_key = "${file("${var.private_key}")}"
  }
# Network  
  network_interface {
    network = google_compute_network.vpc.name
    subnetwork   = google_compute_subnetwork.private_subnet.self_link
    network_ip =  google_compute_address.ansible_address.self_link
    
    access_config {
      // Ephemeral IP
    }
  }
}
