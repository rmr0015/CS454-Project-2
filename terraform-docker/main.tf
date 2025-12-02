terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "demo" {
  name = "demo-net"
}

resource "docker_container" "nginx" {
  name  = "demo-nginx"
  image = "nginx:latest"

  networks_advanced {
    name = docker_network.demo.name
  }

  ports {
    internal = 80
    external = 8080
  }

  volumes {
    host_path = "/home/ubuntu/CS454-Project-2/terraform-docker/forward-to-backend.conf"
    container_path = "/etc/nginx/conf.d/default.conf"
  }
}

resource "docker_container" "postgres" {
  image = "postgres:17"
  name = "postgres"

  networks_advanced {
    name = docker_network.demo.name
  }

  env = ["POSTGRES_USER=${var.USER}", "POSTGRES_PASSWORD=${var.PASS}"]

  volumes {
    container_path = "/var/lib/postgresql/data"
  }
}

resource "docker_image" "backend-image" {
  name = "backend-image"
  build {
    context = "./"
    dockerfile = "./Dockerfile"
  }
}

resource "docker_container" "python-backend" {
  name = "python-backend"
  image = docker_image.backend-image.name

  networks_advanced {
    name = docker_network.demo.name
  }

  ports {
    internal = 5000
    external = 5000
  }
 
  env = ["DBUSER=${var.USER}", "DBPASS=${var.PASS}", "DBNAME=${var.USER}"]
}

variable "USER" { type = string }
variable "PASS" { type = string }
variable "BACKPORT" { type = number }
variable "FRONTPORT" { type = number }
