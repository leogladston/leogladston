provider "aws" {
	region = "us-east-2"
	access_key = AWS_ACCESS_KEY
	secret_key = AWS_SECRET_KEY
}


resource "aws_instance" "web" {
  ami           = "ami-08962a4068733a2b6"
  instance_type = "t2.micro"
  tags = {
    Name = "LEO_INSTANCE1"
  }
}

resource "aws_dynamodb_table" "machine_details" {
  name           = "MachineDetails"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "MachineId"
  attribute {
    name = "MachineId"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "my_instance_db" {
  table_name = aws_dynamodb_table.machine_details.name
  hash_key   = aws_dynamodb_table.machine_details.hash_key

  item = <<ITEM
{
  "MachineId": {"S": "${aws_instance.web.id}"},
  "AvailabilityZone": {"S": "${aws_instance.web.availability_zone}"},
  "InstanceType": {"S": "${aws_instance.web.instance_type}"}
}
ITEM
}
