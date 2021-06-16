output "ip_public_ansible" {
  value = "${google_compute_instance.ansible_srv.network_interface.0.access_config.0.nat_ip}"
}
output "ip_public_docker" {
  value = "${google_compute_instance.docker_srv.network_interface.0.access_config.0.nat_ip}"
}

output "ip_public_jenkins" {
  value = "${google_compute_instance.jenkins_srv.network_interface.0.access_config.0.nat_ip}"
}
output "ip_privates_docker" {
  value = "${google_compute_instance.docker_srv.network_interface.0.network_ip}"
}
output "ip_private_ansible" {
  value = "${google_compute_instance.ansible_srv.network_interface.0.network_ip}"
}
output "ip_private_jenkins" {
  value = "${google_compute_instance.jenkins_srv.network_interface.0.network_ip}"
}


