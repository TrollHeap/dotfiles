#!/usr/bin/env bash

sudo systemctl enable --now libvirtd

sudo usermod -aG libvirt $(whoami)
