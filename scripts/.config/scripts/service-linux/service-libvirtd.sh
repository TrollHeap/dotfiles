sudo systemctl enable --now libvirtd

sudo usermod -aG libvirt $(whoami)
