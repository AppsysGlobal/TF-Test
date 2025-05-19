variable "tenancy_ocid" {
  type = string
}

variable "user_ocid" {
  type = string
}

variable "fingerprint" {
  type = string
}

variable "private_key_path" {
  type    = string
  default = "/var/lib/jenkins/.oci/Optimuskey_pkcs1.pem"
}

variable "region" {
  type = string
}

