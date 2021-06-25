#---------------------------------------------------------------
# Run Ansible Server
#---------------------------------------------------------------
resource "aws_instance" "ansible_srv" {
  instance_type          = "${var.instance_type}"
  ami                    = "${lookup(var.amis, var.aws_region)}"
  key_name               = "${aws_key_pair.amz_key.key_name}"
  subnet_id              = "${aws_subnet.main-public-srv.id}"
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  private_ip             = "10.0.1.7"

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

# Connect to Server
  connection {
    type        = "ssh"
    host        = "${self.public_ip}"
    user        = "${var.instance_username}"
    private_key = "${file("${var.private_key}")}"
  }
}

#---------------------------------------------------------------
# Run Jenkins Server
#---------------------------------------------------------------
resource "aws_instance" "jenkins_srv" {
  instance_type          = "${var.instance_type}"
  ami                    = "${lookup(var.amis, var.aws_region)}"
  key_name               = "${aws_key_pair.ans_ins_key.key_name}"
  subnet_id              = "${aws_subnet.main-public-srv.id}"
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  private_ip             = "10.0.1.5"
}
#---------------------------------------------------------------
# Run Docker Server
#---------------------------------------------------------------
resource "aws_instance" "docker_srv" {
  instance_type          = "${var.instance_type}"
  ami                    = "${lookup(var.amis, var.aws_region)}"
  key_name               = "${aws_key_pair.ans_ins_key.key_name}"
  subnet_id              = "${aws_subnet.main-public-srv.id}"
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  private_ip             = "10.0.1.6"
  
# Send to Server docker script 
  provisioner "file" {
    source      = "../srv_docker_data"
    destination = "/tmp/srv_docker_data"
  }
  
# Connect to Server
  connection {
    type        = "ssh"
    host        = "${self.public_ip}"
    user        = "${var.instance_username}"
    private_key = "${file("${var.private_key_ans_ins}")}"
  }
}
