module "atlantis" {
  source  = "terraform-aws-modules/atlantis/aws"
  version = "~> 2.0"

  name = "atlantis"

  # VPC
  cidr            = "10.20.0.0/16"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
  public_subnets  = ["10.20.101.0/24", "10.20.102.0/24", "10.20.103.0/24"]

  # DNS (without trailing dot)
  route53_zone_name = "aws.contrasting.org"

  # ACM (SSL certificate) - Specify ARN of an existing certificate or new one will be created and validated using Route53 DNS
  # certificate_arn = "arn:aws:acm:eu-west-1:135367859851:certificate/70e008e1-c0e1-4c7e-9670-7bb5bd4f5a84"

  policies_arn = ["arn:aws:iam::aws:policy/PowerUserAccess"]
  # Atlantis
  atlantis_github_user        = var.github_user
  atlantis_github_user_token  = var.github_token
  atlantis_allowed_repo_names = ["terraformsyseng"]
  atlantis_repo_whitelist     = ["*"]
  allow_repo_config           = true
}

provider "github" {
  token        = "${var.github_token}"
  organization = "${var.github_organization}"
}

resource "github_repository_webhook" "foo" {
  repository = "terraformsyseng"

  configuration {
    url          = "https://atlantis.aws.contrasting.org/events" # module.atlantis.atlantis_url
    content_type = "application/json"
    insecure_ssl = false
    secret       = module.atlantis.webhook_secret
  }

  active = true 

  events = [
    "issue_comment",
    "pull_request",
    "pull_request_review",
    "pull_request_review_comment",
  ]

}


output "alb_dns_name" {
  value = module.atlantis.alb_dns_name	
}

output "atlantis_url" {
  value = module.atlantis.atlantis_url
}

output "webhook_secret" {
  value = module.atlantis.webhook_secret
}
