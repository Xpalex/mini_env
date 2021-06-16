resource "aws_key_pair" "amz_key" {
  key_name      = "amz_key"
  public_key    = "${file("${var.public_key}")}"
}
resource "aws_key_pair" "ans_ins_key" {
  key_name      = "ans_ins_key"
  public_key    = "${file("${var.public_key_ans_ins}")}"
}

  

