provider "consul" {
  address    = var.cluster
  datacenter = var.consuldc
  token      = var.token
}

resource "consul_intention" "api-allow" {
  source_name      = "frontend"
  destination_name = "api"
  action           = "allow"
}

resource "consul_intention" "db-allow" {
  source_name      = "api"
  destination_name = "db"
  action           = "allow"
}

resource "consul_config_entry" "frontend" {
  name = "frontend"
  kind = "service-defaults"

  config_json = jsonencode({
    Protocol    = "http"
  })
}
