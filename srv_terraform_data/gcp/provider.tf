#---------------------------------------------------------------
# Credential for connect to google cloud
#---------------------------------------------------------------
provider "google" {
  credentials = "${file("account.json")}" # file for connect, in .json format
  project = "${var.gcp_project}" 
  region  = "${var.gcp_region}"
  zone    = "${var.gcp_zone}"
}