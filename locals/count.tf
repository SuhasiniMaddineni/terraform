resource "aws_instance" "web" {
  #count = 4 # count.index is a special variable given by terraform
  count = length(var.instance_names)
  ami           = var.ami-id #devops-practice
  instance_type = local.instance_type
  tags = {
    Name = var.instance_names[count.index]
  }
}

resource "aws_route53_record" "www" {
  #count = 4
  count = length(var.instance_names)
  zone_id = var.zone-id
  name    = "${var.instance_names[count.index]}.${var.domain_name}" #interpolation
  type    = "A"
  ttl     = 1
  records = [local.ip]
}