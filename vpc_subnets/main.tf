provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "TerraformVPC" {
    cidr_block   = "${var.vpcCIDRBlock}"
    tags {
        Name = "TestVPC"
    }
}

resource "aws_subnet" "TestPublicSubnet1" {
    vpc_id        = "${aws_vpc.TerraformVPC.id}"
    cidr_block    = "${var.publicsubnet1}"
    availability_zone = "${var.availabilityzone1}"
    tags {
        Name      = "TestPublicSubnet1"    
    }
}

resource "aws_subnet" "TestPublicSubnet2" {
    vpc_id        = "${aws_vpc.TerraformVPC.id}"
    cidr_block    = "${var.publicsubnet2}"
    availability_zone = "${var.availabilityzone2}"
    tags {
        Name      = "TestPublicSubnet2"    
    }
}

resource "aws_subnet" "TestPrivateSubnet1" {
    vpc_id        = "${aws_vpc.TerraformVPC.id}"
    cidr_block    = "${var.privatesubnet1}"
    availability_zone = "${var.availabilityzone1}"
    tags {
        Name      = "TestPrivateSubnet1"
    }
}

resource "aws_subnet" "TestPrivateSubnet2" {
    vpc_id        = "${aws_vpc.TerraformVPC.id}"
    cidr_block    = "${var.privatesubnet2}"
    availability_zone = "${var.availabilityzone2}"
    tags {
        Name      = "TestPrivateSubnet2"
    }
}

resource "aws_internet_gateway" "TerraformIG" {
    vpc_id         = "${aws_vpc.TerraformVPC.id}"
    tags {
        Name       = "TerraformIG"
    }
}

#resource "aws_eip" "NATip" {
#    vpc = true
#    tags {
#        Name       = "NATip"
#    }
#}

#resource "aws_nat_gateway" "TerraformNG" {
#    allocation_id = "${aws_eip.NATip.id}"
#    subnet_id     = "${aws_subnet.TestPublicSubnet1.id}"
#    tags {
#        Name      = "TerraformNG"
#    }
#}


resource "aws_route_table" "PublicRouteTerraform" {
    vpc_id         = "${aws_vpc.TerraformVPC.id}"
    tags {
         Name      = "PublicRouteTable"
    }
    route {
        cidr_block = "${var.destinationCIDRBlock}"
        gateway_id = "${aws_internet_gateway.TerraformIG.id}"
    }
}

resource "aws_route_table" "PrivateRouteTerraform" {
    vpc_id         = "${aws_vpc.TerraformVPC.id}"
    tags {
         Name      = "PrivateRouteTable"
    }
    route {
        cidr_block = "${var.destinationCIDRBlock}"
        gateway_id = "${aws_internet_gateway.TerraformIG.id}"
    }
}

resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.TestPublicSubnet1.id}"
  route_table_id = "${aws_route_table.PublicRouteTerraform.id}"
}

resource "aws_route_table_association" "b" {
  subnet_id      = "${aws_subnet.TestPublicSubnet2.id}"
  route_table_id = "${aws_route_table.PublicRouteTerraform.id}"
}


resource "aws_route_table_association" "c" {
  subnet_id      = "${aws_subnet.TestPrivateSubnet1.id}"
  route_table_id = "${aws_route_table.PrivateRouteTerraform.id}"
}

resource "aws_route_table_association" "d" {
  subnet_id      = "${aws_subnet.TestPrivateSubnet2.id}"
  route_table_id = "${aws_route_table.PrivateRouteTerraform.id}"
}


