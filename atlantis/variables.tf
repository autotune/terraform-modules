variable "region" {
  default = "us-east-1"
}

variable "profile" {
  default = "badams"
}

variable "github_token" {
  default = ""
}

variable "github_user" {
  default = "autotune"
}

variable "github_organization" {
  default = "atlantistesting"
}

variable "key_name" {
  default = "badams"
}

variable "bucket" {
  default = "badams-badams"
}

variable "ami_name" {
  default = "amzn-ami-hvm*"
}

variable "ami_owner" {
  default = "amazon"
}

variable "name" {
  default = "badams"
}

variable "costcenter" {
  default = "foo@example.com"
}

variable "environment" {
  default = "dev"
}

variable "key" {
  default = "null.tfstate"
}

variable "asg_size" {
  default = "t2.micro"
}

variable "phone_number" {
  description = "Used for getting auto scale alerts"
  default     = "+15555555555"
}

variable "whitelist" {
  description = "IPs to whitelist for ssh access"
  default     = ["127.0.0.1/32"]
}

