provider "aws"{
    region ="us-east-1"
  }

resource "aws_instanace" "centos"{
    ami=""
    instance_type="t2.micro"
  }
