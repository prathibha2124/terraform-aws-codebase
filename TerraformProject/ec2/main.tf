resource "aws_instance" "my_instance" {
  ami             = "ami-0d191299f2822b1fa" #Amazon Linux 2
  instance_type   = "t2.micro"
  key_name        = var.key_name
  subnet_id       = var.public_subnet_id
  security_groups = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              $(aws ecr get-login --no-include-email --region ${var.aws_region})
              docker pull ${var.ecr_repository_url}
              docker run -d -p 80:80 ${var.ecr_repository_url}
              EOF
}

output "instance_id" {
  value = aws_instance.my_instance.id
}

output "public_ip" {
  value = aws_instance.my_instance.public_ip
}
