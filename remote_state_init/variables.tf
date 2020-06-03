variable "region" {
  default = "us-east-1"
}

variable "profile" {
  default = "default"
}

variable "bucket" {
  default = "badams"
}

variable "name" {
  default = "badams"
}

variable "costcenter" {
  default = "foo@example.com"
}

variable "key" {
  description = "tfstate key name"
  default     = "null.tfstate"
}

