# ❌ 測試用：明顯存在多個 Cloud Security Misconfigurations
# ✔ S3 Public
# ✔ S3 未加密
# ✔ Security Group 全開
# ✔ EC2 未加密
# ✔ IAM Policy 過度授權
# ✔ RDS 未強制加密
# Cortex 一定會掃出問題，適合作為 Demo 檔案

# 1. S3 bucket：未加密、開 public
resource "aws_s3_bucket" "bad_bucket" {
  bucket = "terribly-insecure-demo-bucket"
  acl    = "public-read"   # ❌ Public
}

# 2. Security Group：全公開 0.0.0.0/0
resource "aws_security_group" "open_sg" {
  name        = "open-security-group"
  description = "This security group is intentionally bad"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # ❌ SSH Public
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]   # ❌ 全網可出
  }
}

# 3. EBS Volume 未加密
resource "aws_ebs_volume" "unencrypted_volume" {
  availability_zone = "us-east-1a"
  size              = 10
  encrypted         = false    # ❌ 未加密
}

# 4. IAM Policy 過度授權：*
resource "aws_iam_policy" "bad_policy" {
  name = "overly-permissive-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"       # ❌ 全部權限
        Resource = "*"       # ❌ 全部資源
      }
    ]
  })
}

# 5. RDS 未強制加密
resource "aws_db_instance" "bad_rds" {
  identifier              = "insecure-db"
  instance_class          = "db.t3.micro"
  engine                  = "mysql"
  allocated_storage       = 20
  username                = "admin"
  password                = "Password123!"
  publicly_accessible     = true        # ❌ 對外公開
  storage_encrypted       = false       # ❌ 未加密
  skip_final_snapshot     = true
}
