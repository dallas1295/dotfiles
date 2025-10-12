#!/bin/bash
cd ~/dotfiles/terminal
sed -i '' 's/vesper.omp.json/gruvvy.omp.json/' .zshrc
echo "Theme updated to Gruvbox! Restart your terminal or run 'source ~/.zshrc' to see changes."