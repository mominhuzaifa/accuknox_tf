provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"
}

data "aws_ami" "ubuntu_us_east_1" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  provider = aws.us-east-1
}

data "aws_ami" "ubuntu_us_east_2" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  provider = aws.us-east-2
}

module "ec2_instance_us_east_1" {
  source        = "./ec2-instance"
  ami           = data.aws_ami.ubuntu_us_east_1.id
  instance_type = "t2.small"

  providers = {
    aws = aws.us-east-1
  }
}

module "ec2_instance_us_east_2" {
  source        = "./ec2-instance"
  ami           = data.aws_ami.ubuntu_us_east_2.id
  instance_type = "t2.small"

  providers = {
    aws = aws.us-east-2
  }
}
