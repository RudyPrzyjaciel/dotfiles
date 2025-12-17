#!/bin/bash

echo "--- Updating dotfiles ---"

config_nvim () {
    if  ! [[ $(which nvim) ]]; then
        echo "--- nvim not found - ommiting ---"
        return
    fi
    NVIM_DIR="/home/${USER}/.config/nvim"
    if [ -L "${NVIM_DIR}" ]; then
        echo "found symlink ${NVIM_DIR} pointing to $(readlink -f ${NVIM_DIR}) - unlinking"
        unlink ${NVIM_DIR}
    elif [ -d "${NVIM_DIR}" ]; then
        echo "found directory ${NVIM_DIR} - renaming toc ${NVIM_DIR}_old"
        mv ${NVIM_DIR} ${NVIM_DIR}_old
    fi
    echo "creating symlink to $(pwd)/nvim"
    ln -s "$(pwd)/nvim" /home/${USER}/.config/
}

install_fonts () {
	scp -r $(pwd)/fonts/DejaVuSansMono /usr/share/fonts/
}

# catppuccin color scheme may be put to ~/.local/share/konsole/ for Konsole

#config_nvim
#echo "--- Update done ---"
