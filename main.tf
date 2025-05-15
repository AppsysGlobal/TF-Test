provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

resource "oci_core_instance" "vm1" {}
resource "oci_core_instance" "vm2" {}

resource "oci_core_virtual_network" "vcn1" {}

resource "oci_core_subnet" "subnet1" {}
