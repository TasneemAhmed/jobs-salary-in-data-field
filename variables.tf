variable "credentials" {
  default     = "./keys/jobs-salaries-in-data-f2ceb48884aa.json"
  description = "this for credantials to access google provider"
}

variable "project_id" {
  default     = "jobs-salaries-in-data"
  description = "The is project id"
}

variable "region" {
  default     = "us-central1"
  description = "This is for project region"
}


variable "location" {
  default     = "US"
  description = "The is location"
}

variable "gcs_bucket_name" {
  default     = "jobs-salaries-in-data-bucket"
  description = "The is google cloud storage bucket name"
}

variable "gcs_storage_class" {
  default     = "standard"
  description = "The class of google cloud storage"
}

variable "bq_dataset_name" {
  default     = "jobs_salaries_in_data_dataset"
  description = "The is for Google BigQuery dataset name"
}

variable "dataproc_cluster_name" {
  default     = "dataproc-pyspark-cluster"
  description = "This is for creating Dataproc cluster to able to create a PySpark job inside it"

}

variable "service_account_email" {
  default     = "de-zoomcamp-final-project@jobs-salaries-in-data.iam.gserviceaccount.com"
  description = "This is to user while creating Dataproc Cluster"

}

variable "machine_type" {
  default     = "n1-standard-2"
  description = "Machine type needed while creating Dataproc cluster"

=======
variable "credentials" {
  default     = "./keys/jobs-salaries-in-data-f2ceb48884aa.json"
  description = "this for credantials to access google provider"
}

variable "project_id" {
  default     = "jobs-salaries-in-data"
  description = "The is project id"
}

variable "region" {
  default     = "us-central1"
  description = "This is for project region"
}


variable "location" {
  default     = "US"
  description = "The is location"
}

variable "gcs_bucket_name" {
  default     = "jobs-salaries-in-data-bucket"
  description = "The is google cloud storage bucket name"
}

variable "gcs_storage_class" {
  default     = "standard"
  description = "The class of google cloud storage"
}

variable "bq_dataset_name" {
  default     = "jobs_salaries_in_data_dataset"
  description = "The is for Google BigQuery dataset name"
}

variable "dataproc_cluster_name" {
  default     = "dataproc-pyspark-cluster"
  description = "This is for creating Dataproc cluster to able to create a PySpark job inside it"

}

variable "service_account_email" {
  default     = "de-zoomcamp-final-project@jobs-salaries-in-data.iam.gserviceaccount.com"
  description = "This is to user while creating Dataproc Cluster"

}

variable "machine_type" {
  default     = "n1-standard-2"
  description = "Machine type needed while creating Dataproc cluster"
}