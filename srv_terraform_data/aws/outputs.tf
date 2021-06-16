output "private_ip_ansible" {
  description = "Private IP address of Ansible server"
  value       = "${aws_instance.ansible_srv.private_ip}"
}
output "public_ip_ansible" {
  description = "Public IP address of Ansible server"
  value       = "${aws_instance.ansible_srv.public_ip}"
}
output "private_ip_jenkins" {
  description = "Private IP address of Jenkins server"
  value       = "${aws_instance.jenkins_srv.private_ip}"
}
output "public_ip_jenkins" {
  description = "Public IP address of Jenkins server"
  value       = "${aws_instance.jenkins_srv.public_ip}"
}
output "private_ip_docker" {
  description = "Private IP address of Docker server"
  value       = "${aws_instance.docker_srv.private_ip}"
}
output "public_ip_docker" {
  description = "Public IP address of Docker server"
  value       = "${aws_instance.docker_srv.public_ip}"
}

