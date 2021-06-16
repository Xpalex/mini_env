#---------------------------------------------------------------
# provider.tf
#---------------------------------------------------------------
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "aws_region" {
  default  = "us-east-2"
}
#---------------------------------------------------------------
# instance.tf
#---------------------------------------------------------------
variable "amis" {
  type     = map(string)
  default  = {
    us-east-2 = "ami-077e31c4939f6a2f3"
    us-west-2 = ""
    eu-west-1 = ""
  }
}
variable "instance_username" {
  default   = "ec2-user"
}
#---------------------------------------------------------------
# Keys
#---------------------------------------------------------------
variable "private_key" {
  default   = "amz_key"
}
variable "public_key" {
  default   = "amz_key.pub"
}
variable "private_key_ans_ins" {
  default   = "ans_ins_key"
}
variable "public_key_ans_ins" {
  default   = "ans_ins_key.pub"
}

