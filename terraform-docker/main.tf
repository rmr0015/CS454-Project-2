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
}

resource "docker_container" "postgres" {
  image = "postgres:17"
  name = "postgres"

  networks_advanced {
    name = docker_network.demo.name
  }

  env = [
    "POSTGRES_USER=ubuntu",
    "POSTGRES_PASSWORD=DEMO1"
  ]

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
}
