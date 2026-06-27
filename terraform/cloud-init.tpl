#cloud-config
package_update: true
packages:
  - docker.io
runcmd:
  - systemctl enable docker
  - systemctl start docker
  - docker pull ${container_image}
  - docker run -d --name web --restart always -p 80:80 ${container_image}
