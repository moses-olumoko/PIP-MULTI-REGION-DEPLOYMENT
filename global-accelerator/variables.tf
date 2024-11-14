variable "region" {
  description = "AWS region"
  type        = string
}

variable "access_key" {
    type = string
    sensitive = true
    default = "" 
}

variable "secret_key" {
    type = string
    sensitive = true
    default = ""
}

variable "primary_service_endpoint" {
    type = string
    default = ""
}

variable "secondary_service_endpoint" {
    type = string
    default = ""
}

