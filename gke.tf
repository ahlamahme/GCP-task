resource "google_service_account" "default" {
  account_id   = "service-kuber-account"
  project     = "ahlamg012d"
}
#GKE on private subnet-2 (managment)

resource "google_container_cluster" "primary" {
  name               = "marcellus-wallace"
  location           = "us-west2-a"
  network                  = google_compute_network.vpc.self_link
  subnetwork               = google_compute_subnetwork.private-2.self_link
  initial_node_count = 2
  node_config {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    labels = {
      foo = "bar"
    }
    tags = ["foo", "bar"]
  }
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
  ip_allocation_policy {
    
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}