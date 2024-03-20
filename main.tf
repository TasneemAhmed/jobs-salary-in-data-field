/*
- terraform init: which will initialize the provider from terraform to access google cloud
- terraform plan: review changes and show resources are about created or applied
- terraform apply: to apply/deploy the resources which are:
    - google_storage_bucket
    - google_bigquery_dataset
    - google_dataproc_cluster
*/
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.21.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)
  project     = var.project_id
  region      = var.region
}

resource "google_storage_bucket" "project-bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true
  storage_class = var.gcs_storage_class


  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_bigquery_dataset" "terraform-dataset" {
  dataset_id  = var.bq_dataset_name
  description = "This dataset is tested and created by terraform"
}

resource "google_dataproc_cluster" "pysparkcluster" {
  name   = var.dataproc_cluster_name
  region = var.region


  cluster_config {
    staging_bucket = var.gcs_bucket_name

    master_config {
      num_instances = 1
      machine_type  = var.machine_type
      disk_config {
        boot_disk_type    = "pd-ssd"
        boot_disk_size_gb = 30
      }
    }

    worker_config {
      num_instances    = 2
      machine_type     = var.machine_type
      min_cpu_platform = "Intel Skylake"
      disk_config {
        boot_disk_size_gb = 30
        num_local_ssds    = 1
      }
    }

    preemptible_worker_config {
      num_instances = 0
    }


    gce_cluster_config {
      tags = ["foo", "bar"]
      # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
      service_account = var.service_account_email
      service_account_scopes = [
        "cloud-platform"
      ]
    }
  }
=======
/*
- terraform init: which will initialize the provider from terraform to access google cloud
- terraform plan: review changes and show resources are about created or applied
- terraform apply: to apply/deploy the resources which are:
    - google_storage_bucket
    - google_bigquery_dataset
    - google_dataproc_cluster
*/
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.21.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)
  project     = var.project_id
  region      = var.region
}

resource "google_storage_bucket" "project-bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true
  storage_class = var.gcs_storage_class


  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_bigquery_dataset" "terraform-dataset" {
  dataset_id  = var.bq_dataset_name
  description = "This dataset is tested and created by terraform"
}

resource "google_dataproc_cluster" "pysparkcluster" {
  name   = var.dataproc_cluster_name
  region = var.region


  cluster_config {
    staging_bucket = var.gcs_bucket_name

    master_config {
      num_instances = 1
      machine_type  = var.machine_type
      disk_config {
        boot_disk_type    = "pd-ssd"
        boot_disk_size_gb = 30
      }
    }

    worker_config {
      num_instances    = 2
      machine_type     = var.machine_type
      min_cpu_platform = "Intel Skylake"
      disk_config {
        boot_disk_size_gb = 30
        num_local_ssds    = 1
      }
    }

    preemptible_worker_config {
      num_instances = 0
    }


    gce_cluster_config {
      tags = ["foo", "bar"]
      # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
      service_account = var.service_account_email
      service_account_scopes = [
        "cloud-platform"
      ]
    }
  }
}