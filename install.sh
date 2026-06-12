#!/bin/bash

config_nvim() {
  if ! [[ $(which nvim) ]]; then
    echo "--- nvim not found - ommiting ---"
    return
  fi
  NVIM_DIR="/home/${USER}/.config/nvim"
  if [ -L "${NVIM_DIR}" ]; then
    echo "found symlink ${NVIM_DIR} pointing to $(readlink -f ${NVIM_DIR}) - unlinking"
    unlink ${NVIM_DIR}
  elif [ -d "${NVIM_DIR}" ]; then
    echo "found directory ${NVIM_DIR} - renaming to ${NVIM_DIR}_old"
    mv ${NVIM_DIR} ${NVIM_DIR}_old
  fi
  echo "creating symlink to $(pwd)/nvim"
  ln -s "$(pwd)/nvim" /home/${USER}/.config/
}

install_fonts() {
  mkdir -p /home/${USER}/.fonts
  echo "copying DejaVuSansMono to /home/${USER}/.fonts"
  scp -r $(pwd)/fonts/DejaVuSansMono /home/${USER}/.fonts/
}

config_tmux() {
  if ! [[ $(which tmux) ]]; then
    echo "--- tmux not found - ommiting ---"
    return
  fi
  TMUX_DIR="/home/${USER}/.tmux.conf"
  if [ -L "${TMUX_DIR}" ]; then
    echo "found symlink ${TMUX_DIR} pointing to $(readlink -f ${TMUX_DIR}) - unlinking"
    unlink ${TMUX_DIR}
  elif [ -d "${TMUX_DIR}" ]; then
    echo "found directory ${TMUX_DIR} - renaming to ${TMUX_DIR}_old"
    mv ${TMUX_DIR} ${TMUX_DIR}_old
  fi
  echo "creating symlink to $(pwd)/tmux/.tmux.conf"
  ln -s "$(pwd)/tmux/.tmux.conf" /home/${USER}/.tmux.conf
}

# catppuccin color scheme may be put to ~/.local/share/konsole/ for Konsole

#config_nvim
echo "--- Updating dotfiles ---"
config_nvim
config_tmux
install_fonts
echo "--- Update done ---"
