function _fzf_change_directory
  fzf | perl -pe 's/([ ()])/\\\\$1/g' | read foo
  if [ $foo ]
    builtin cd $foo
    commandline -r ''
    commandline -f repaint
  else
    commandline ''
  end
end

function fzf_change_directory
    begin
        # config files (including symlinks)
        fd . -t d --max-depth 1 --follow $HOME/.config/

        # dev files (including symlinks)
        fd . -t d --max-depth 2 --follow $HOME/Developer/

        # personal files (including symlinks)
        fd . -t d --max-depth 2 --follow $HOME/Personal/
        
        # git clones (including symlinks)
        fd . -t d $(ghq root) --max-depth 4 | sed 's/\/\.git//'
        
        # current directory (exclude symlinked default folders)
        if test (count $PWD/*/) -gt 0
          ls -d $PWD/*/ | grep -v -E '\.git|Music|Documents|Movies|Pictures' # Adjust folder names as necessary
        end
    end | sed -e 's/\/$//' | awk '!a[$0]++' | _fzf_change_directory $argv
end
