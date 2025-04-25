# === provider.tf ===
provider "oci" {
  region              = "us-sanjose-1"
  config_file_profile = "DEFAULT"
}

# === data sources ===
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}

data "oci_core_images" "oracle_linux" {
  compartment_id   = var.compartment_id
  operating_system = "Oracle Linux"
  shape            = "VM.Standard.E2.1.Micro" 
  sort_by          = "TIMECREATED"
  sort_order       = "DESC"
  filter {
    name   = "display_name"
    values = ["Oracle-Linux-8.*"]
    regex  = true
  }
}

# === Autonomous DB (Always Free Tier) ===
resource "oci_database_autonomous_database" "atp" {
  compartment_id             = var.compartment_id
  db_name                    = "ATPVMDB"
  admin_password             = var.wallet_password
  cpu_core_count             = 1
  data_storage_size_in_tbs   = 1
  db_workload                = "OLTP"
  is_free_tier               = true
  display_name               = "FreeATP"
}

resource "oci_database_autonomous_database_wallet" "wallet" {
  autonomous_database_id = oci_database_autonomous_database.atp.id
  password               = var.wallet_password
  generate_type          = "SINGLE"
}

# === Compute Instance ===
resource "oci_core_instance" "vm" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_id
  display_name        = "vm-atp-connected"
  shape               = "VM.Standard.E2.1.Micro"

  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = true
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.oracle_linux.images[0].id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    user_data = base64encode(templatefile("cloud-init.tpl", {
      wallet_base64 = base64encode(oci_database_autonomous_database_wallet.wallet.content)
    }))
  }
}

# === Outputs ===
output "vm_public_ip" {
  value = oci_core_instance.vm.public_ip
}

output "atp_db_name" {
  value = oci_database_autonomous_database.atp.db_name
}

output "atp_connection_string" {
  value = oci_database_autonomous_database.atp.connection_strings
}
output "selected_image_ocid" {
  value = data.oci_core_images.oracle_linux.images[0].id
}