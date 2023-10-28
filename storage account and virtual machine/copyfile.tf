resource "null_resource" "addfiles" {
  count = var.number_of_machine
  provisioner "remote-exec" {
    inline = ["sudo apt-get update", "sudo apt-get -y install nginx"]
  }
  provisioner "file" {
    source      = "default.html"
    destination = "/var/www/html/default.html"

    connection {
      type        = "ssh"
      user        = "adminiaplinux"
      private_key = file("${local_file.linuxpemkey.filename}")
      host        = azurerm_public_ip.abcip[count.index].ip_address
    }
  }
  depends_on = [tls_private_key.linuxkey, azurerm_linux_virtual_machine.abclinuxvm]
}
