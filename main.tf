# demo 用的 Terraform，讓 Cortex CLI 抓 misconfiguration 用
# 不需要真的執行 terraform apply

resource "aws_s3_bucket" "bad_bucket" {
  bucket = "mark-terraform-lab-demo-bucket"
  acl    = "public-read"  # 公開讀取，等一下掃描會被判定為高風險
}
