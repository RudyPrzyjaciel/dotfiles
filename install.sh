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

config_zsh() {
  if ! [[ $(which zsh) ]]; then
    echo "--- zsh not found - ommiting ---"
    return
  fi

  echo "running 'git submodule update --init --recursive $(pwd)/zsh/.oh-my-zsh'"
  git submodule update --init --recursive $(pwd)/zsh/.oh-my-zsh

  OHMYZSH="/home/${USER}/.oh-my-zsh"
  if [ -L "${OHMYZSH}" ]; then
    echo "found symlink ${OHMYZSH} pointing to $(readlink -f ${OHMYZSH}) - unlinking"
    unlink ${OHMYZSH}
  elif [ -d "${OHMYZSH}" ]; then
    echo "found directory ${OHMYZSH} - renaming to ${OHMYZSH}_old"
    mv ${OHMYZSH} ${OHMYZSH}_old
  fi
  echo "creating symlink to $(pwd)/.oh-my-zsh"
  ln -s "$(pwd)/zsh/.oh-my-zsh" /home/${USER}/.oh-my-zsh

  ZSHRC="/home/${USER}/.zshrc"
  if [ -L "${ZSHRC}" ]; then
    echo "found symlink ${ZSHRC} pointing to $(readlink -f ${ZSHRC}) - unlinking"
    unlink ${ZSHRC}
  elif [ -f "${ZSHRC}" ]; then
    echo "found regular file ${ZSHRC} - renaming to ${ZSHRC}_old"
    mv ${ZSHRC} ${ZSHRC}_old
  fi
  echo "creating symlink to $(pwd)/.zshrc"
  ln -s "$(pwd)/zsh/.zshrc" /home/${USER}/.zshrc

  P10K="/home/${USER}/.p10k.zsh"
  if [ -L "${P10K}" ]; then
    echo "found symlink ${P10K} pointing to $(readlink -f ${P10K}) - unlinking"
    unlink ${P10K}
  elif [ -f "${P10K}" ]; then
    echo "found regular file ${P10K} - renaming to ${P10K}_old"
    mv ${P10K} ${P10K}_old
  fi
  echo "creating symlink to $(pwd)/.p10k.zsh"
  ln -s "$(pwd)/zsh/.p10k.zsh" /home/${USER}/.p10k.zsh
}

install_konsole_theme_catppuccin() {
  echo "copying catppuccin-macchiato.colorscheme to /home/${USER}/.local/share/konsole directory"
  scp $(pwd)/catppuccin-macchiato.colorscheme /home/${USER}/.local/share/konsole/.
}

#config_nvim
echo "--- Updating dotfiles ---"
config_nvim
config_tmux
config_zsh
install_fonts
install_konsole_theme_catppuccin
echo "--- Update done ---"
