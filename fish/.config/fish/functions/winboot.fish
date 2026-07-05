function winboot --description 'Reboot into Windows (one-time, bypasses GRUB to keep TPM chain intact)'
    sudo efibootmgr --bootnext 0004
    and sudo reboot
end
