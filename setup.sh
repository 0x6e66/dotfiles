#!/bin/bash


# Notes:
#   - docker:
#       - "Failed to start Docker Application Container Engine"
#           - reboot and re-run
#   - rustup:
#       - openssl-sys crate build fail
#           - install libssl-dev or pkgconf


########################################## pacman programs ##########################################
pacman_programs () {
    pacman_programs_to_install="
        chromium
        cmake
        discord
        docker
        gimp
        keepassxc
        make
        mattermost-desktop
        net-tools
        nextcloud-client
        pdftk
        pkgconf
        qbittorrent
        rustup
        signal-desktop
        steam-native-runtime
        thunderbird
        tree
        typst
        vim
        virtualbox
        wireshark-qt
        yay
    "
    sudo pacman -Syu $pacman_programs_to_install
}
#####################################################################################################


############################################ aur programs ###########################################
aur_programs () {
    aur_programs_to_install="
        etcher-bin
        freetube-bin
        nordvpn-bin
        openrgb-bin
        spotify-launcher
        visual-studio-code-bin
    "
    yay -Syu --noconfirm $aur_programs_to_install
}
#####################################################################################################


########################################## program configs ##########################################
program_configs () {
    #### nordvpn ####
    sudo systemctl enable --now nordvpnd
    sudo usermod -a -G nordvpn $USER

    #### wireshark ####
    sudo usermod -a -G wireshark $USER

    #### docker ####
    sudo systemctl enable --now docker
    sudo usermod -a -G docker $USER

    #### rustup ####
    rustup default stable

    #### vscode ####
    code --install-extension bierner.markdown-preview-github-styles
    code --install-extension bierner.markdown-mermaid
    code --install-extension ms-python.vscode-pylance
    code --install-extension ms-toolsai.jupyter
    code --install-extension mhutchie.git-graph
    code --install-extension nvarner.typst-lsp
    code --install-extension redhat.vscode-xml
    code --install-extension redhat.vscode-yaml
    code --install-extension rust-lang.rust-analyzer
    code --install-extension serayuzgur.crates
    code --install-extension streetsidesoftware.code-spell-checker
    code --install-extension streetsidesoftware.code-spell-checker-german
    code --install-extension tamasfe.even-better-toml
    code --install-extension tomoki1207.pdf

    #### plasma ####
    lookandfeeltool -a org.manjaro.breath-dark.desktop
}
#####################################################################################################


############################################### blesh ###############################################
blesh () {
    git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git /tmp/blesh
    make -C /tmp/blesh install PREFIX=~/.local
}
#####################################################################################################


############################################## dotfiles #############################################
dotfiles () {
    dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    cp $dir/vimrc ~/.vimrc
    cp $dir/bashrc ~/.bashrc
    cp $dir/bash_aliases ~/.bash_aliases
    cp $dir/config/Code/User/snippets/*.json ~/.config/Code/User/snippets/
}
#####################################################################################################

pacman_programs
aur_programs
program_configs
blesh
dotfiles