resource "google_compute_firewall" "allow-internal" {
  name    = "${var.company}-fw-allow-internal"
  network = "${google_compute_network.vpc.name}"
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  
  source_ranges = [
    "10.0.1.0/24",
    
    "10.0.2.0/24",    
  ]
}

