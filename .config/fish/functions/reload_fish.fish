function reload_fish
	source ~/.config/fish/config.fish
	clear
  echo "Fish reloaded!"
  sleep 1.0            # Wait for 1.5 seconds
  clear                  # Clear the terminal
  commandline -f repaint
end

