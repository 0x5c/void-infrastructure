job "infradocs" {
  datacenters = ["VOID"]
  namespace = "apps"
  type = "service"

  group "app" {
    count = 1

    network {
      mode = "bridge"
      port "http" {
        to = 8080
      }
    }

    service {
      name = "infradocs"
      port = "http"
      tags = [
        "traefik.enable=true",
        "traefik.http.routers.infradocs.tls=true",
        "traefik.http.routers.infradocs.rule=Host(`infradocs.voidlinux.org`)",
      ]

      check {
        type = "http"
        address_mode = "host"
        path = "/"
        timeout = "30s"
        interval = "15s"
      }
    }

    task "httpd" {
      driver = "docker"

      config {
        image = "ghcr.io/void-linux/infradocs:ff829639fd8c39627abc416a65ab4fdcdcb91484"
        ports = ["http"]
      }
    }
  }
}
