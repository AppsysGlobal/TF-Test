pipeline {
  agent any
  environment {
    TF_VAR_user_ocid        = "ocid1.user.oc1..aaaaaaaakmvqxdblzf2z7xnmau7guxlcbs6iuloyy3nq2ob2x2aa5i7gn6tq"
    TF_VAR_tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaasiigfpcj7o4xn6o5r725u5zofb5tfmfb57vzqqsirlnkhg6lpiva"
    TF_VAR_fingerprint      = "bd:3b:62:6d:b3:a9:f6:16:b8:97:2c:8b:4e:ab:d0:01"
    TF_VAR_private_key_path =  "/var/lib/jenkins/.oci/Optimuskey_pkcs1.pem"
    TF_VAR_region           = "us-ashburn-1"
  }

  stages {
    stage('Init') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Apply') {
      steps {
        sh 'terraform apply -auto-approve'
      }
    }
  }
}
