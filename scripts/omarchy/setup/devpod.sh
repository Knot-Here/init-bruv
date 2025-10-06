# 1) (optional) you already removed the AUR package; good.
# If not removed: sudo pacman -Rns devpod-bin

# 2) Grab the upstream CLI binary (x86-64 / amd64)
VER=v0.6.15
curl -L "https://github.com/loft-sh/devpod/releases/download/$VER/devpod-linux-amd64" -o devpod

# 3) Install it as 'devpod' in PATH
chmod +x devpod
sudo mv devpod /usr/local/bin/devpod

# 4) Sanity check
which devpod
devpod version

