provider "oci" {
  config_file         = "/var/lib/jenkins/.oci/config"
  config_file_profile = "DEFAULT"
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaasiigfpcj7o4xn6o5r725u5zofb5tfmfb57vzqqsirlnkhg6lpiva"
}

output "availability_domains" {
  value = data.oci_identity_availability_domains.ads.availability_domains[*].name
}
