#test/tf
provider "aws" {
  region     = "us-east-1"
  # 觸發 Secrets (機密寫死)
  access_key = "AKIAIOSFODNN7EXAMPLE" 
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
}

# 觸發 IaC Misconfigurations (S3 沒加密、沒開版本控制、沒擋 Public Access)
resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "my-vulnerable-cortex-bucket-123"
}

# 觸發 IaC Misconfigurations (Security Group 對全世界開放 22 port)
resource "aws_security_group" "allow_all" {
  name        = "allow_all_traffic"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
