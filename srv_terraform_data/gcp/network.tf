resource "google_compute_network" "net" {
  name = "my-network"
}
resource "google_compute_subnetwork" "private_subnet" {
  name          =  "private-subnet"
  ip_cidr_range = "10.0.1.0/24"
  network      = "${google_compute_network.vpc.name}"
  region        = "us-central1"
}

resource "google_compute_router" "router" {
  name    = "my-router"
  region  = google_compute_subnetwork.private_subnet.region
  network = google_compute_network.vpc.id
}

resource "google_compute_router_nat" "nat_manual" {
  name   = "my-router-nat"
  router = google_compute_router.router.name
  region = google_compute_router.router.region

 

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.private_subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}



resource "google_compute_address" "jenkins_address" {
  name         = "jenkins-address"
  subnetwork   = google_compute_subnetwork.private_subnet.self_link
  address_type = "INTERNAL"
  address      = "10.0.1.5"
  region       = "us-central1"
}

resource "google_compute_address" "docker_address" {
  name         = "docker-address"
  subnetwork   = google_compute_subnetwork.private_subnet.self_link
  address_type = "INTERNAL"
  address      = "10.0.1.6"
  region       = "us-central1"
}

resource "google_compute_address" "ansible_address" {
  name         = "ansible-address"
  subnetwork   = google_compute_subnetwork.private_subnet.self_link
  address_type = "INTERNAL"
  address      = "10.0.1.7"
  region       = "us-central1"
}
