#---------------------------------------------------------------
# provider.tf
#---------------------------------------------------------------
variable "gcp_project" {
default = "primordial-will-305812"
}
variable "gcp_region" {
  default  = "us-central1"
}
variable "gcp_zone" {
  default  = "us-central1-b"
}

#---------------------------------------------------------------
# instance.tf
#---------------------------------------------------------------
variable "instance_username" {
  default   = "onishenko_a"
}
#---------------------------------------------------------------
# Keys
#---------------------------------------------------------------
variable "private_key" {
  default   = "gcp_key"
}
variable "public_key" {
  default   = "gcp_key.pub"
}
variable "private_key_ans_ins" {
  default   = "ans_ins_key"
}
variable "public_key_ans_ins" {
  default   = "ans_ins_key.pub"
}




variable "project" {
        default = "project-name"
    }
variable "env" {
        default = "dev"
    }
variable "company" { 
        default = "company-name"
    }
variable "uc1_private_subnet" {
        default = "10.0.1.0/24"
    }
variable "uc1_public_subnet" {
        default = "10.0.2.0/24"
    }
