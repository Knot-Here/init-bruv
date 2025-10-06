# 1) Create plugins dir (if missing)
mkdir -p ~/.tmux/plugins

# 2) Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# 3) Reload your config
tmux source-file ~/.tmux.conf

