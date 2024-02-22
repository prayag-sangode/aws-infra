provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

terraform {
  backend "s3" {
    bucket         = "prayag22-bucket1952"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "tfstate-lock-dynamo"
  }
}

# Create an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0c94855ba95c71c99"  # Replace with your desired AMI ID
  instance_type = "t2.micro"
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-${random_id.bucket_suffix.hex}"
}


output "instance_public_ip" {
  value = aws_instance.example.public_ip
}

