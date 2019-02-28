
resource "aws_key_pair" "ec2key" {
  key_name = "publicKey"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "example" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.TestPublicSubnet1.id}"
  count = "${var.num_instances}"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.sg_22.id}"]
  key_name = "${aws_key_pair.ec2key.key_name}"
  provisioner "local-exec" {
     command = "echo ${aws_instance.example.private_ip} >> private_ips.txt"
  }
provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
 tags {
    "Name"     = "TestTerraform"
    "Role"     = "Terraform"
  }
provisioner "local-exec" {
        command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key /root/.ssh/id_rsa -i '${aws_instance.example.public_ip},' master.yml"
    }
}



output "ip" {
    value = "${aws_instance.example.*.public_ip}"
}

