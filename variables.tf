variable "compartment_id" {
  description = "OCID of the compartment where resources will be created"
  type        = string
}

variable "subnet_id" {
  description = "OCID of the subnet where the instance will be launched"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key to access the VM"
  type        = string
}
variable "wallet_password" {
  description = "Password to encrypt the ATP wallet"
  type        = string
}