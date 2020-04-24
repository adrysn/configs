resource "aws_key_pair" "jpark_personal" {
  key_name = "jpark_personal"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "jpark_personal" {
  name = "jpark_allow_ssh_web_from_all"
  description = "Allow SSH and web service ports from all"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_security_group" "default" {
  # name = "default"
  # vpc_id = "vpc-395e9750"  # personal
  name = "cld190727-bai"  # lablup
  vpc_id = "vpc-253edd4c"  # lablup
}

resource "aws_instance" "jpark_personal" {
  ami = "ami-00379ec40a3e30f87"  # Ubuntu Server 18.04 LTX (HVM), SSD Volume Type
  instance_type = "t2.micro"
  key_name = aws_key_pair.jpark_personal.key_name
  user_data = file("./aws_personal_userdata.sh")
  # user_data = data.template_file.userdata_lin.rendered
  vpc_security_group_ids = [
    aws_security_group.jpark_personal.id,
    data.aws_security_group.default.id
  ]
  tags = {
    Name = "jpark-personal"
    Terraform = "true"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    host = aws_instance.jpark_personal.public_ip
    private_key = file("~/.ssh/id_rsa")
  }

  provisioner "file" {
    source = "aws_personal_bootstrap.sh"
    destination = "/home/ubuntu/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/bootstrap.sh",
      "/home/ubuntu/bootstrap.sh"
    ]
  }

  provisioner "local-exec" {
    command = "echo Public IP: ${aws_instance.jpark_personal.public_ip}"
  }
}

# resource "aws_db_instance" "jpark_test_191129" {
#   allocated_storage = 8
#   engine = "mysql"
#   engine_version = "5.6.35"
#   instance_class = "db.t2.micro"
#   username = "admin"
#   password = "test1234"
#   skip_final_snapshot = true
# }
