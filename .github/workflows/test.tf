resource "aws_s3_bucket" "test" {
  bucket = "my-insecure-bucket"

  # 這是故意的錯誤：未加密、全開 ACL
  acl    = "public-read"
}
