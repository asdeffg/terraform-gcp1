# terraform {
    # required_providers {
      #   google = {
     #        source = "hashicorp/google"
    #         version = "4.51.0"
   #      }
  #   }
 # }

provider "google" {
    credentials = file("multi-cloud-406002-88bcf6b25331.json")

    project = "multi-cloud-406002"
    region  = "us-central1"
    zone    = "us-central1-a"
}


resource "google_compute_instance" "vm_instance" {
    name         = "terraform-instance2"
    machine_type = "f1-micro"
    //ssh-keys = "root:${file("/C:/Users/Admin/Downloads/multi-cloud-406002.pub")}"
    metadata = {
        ssh-keys = "sjk1364:${file("KEY/multi-cloud-406002.pub")}"
    }

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
        }
    }

    network_interface {
        network = "default"
        access_config {
        }
    }
}

// resource "google_compute_firewall" "ssh" {
//   name = "allow-ssh"
//   allow {
//     ports    = ["22"]
//     protocol = "tcp"
//   }
//   direction     = "INGRESS"
//   network       = google_compute_network.vpc_network.id
//   priority      = 1000
//   source_ranges = ["0.0.0.0/0"]
//   target_tags   = ["ssh"]
// }

output "gcp_vm_public_ip" {
  value = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
}



