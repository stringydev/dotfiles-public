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

        echo $HOME/.dotfiles
        # dotfiles (including symlinks and hidden directories)
        fd . -t d -H --max-depth 2 --follow $HOME/.dotfiles/

        # dev files (including symlinks)
        fd . -t d -H --max-depth 2 --follow $HOME/Developer/

        # personal files (including symlinks)
        fd . -t d --max-depth 2 --follow $HOME/Personal/
        
        # git clones (including symlinks, removing .git folders)
        fd . -t d --max-depth 4 --follow $(ghq root) | sed 's/\/\.git//'
        
        # current directory (exclude symlinked default folders)
        if test (count $PWD/*/) -gt 0
          ls -d $PWD/*/ | grep -v -E '\.git|Music|Documents|Movies|Pictures'
        end
    end | sed -e 's/\/$//' | awk '!a[$0]++' | _fzf_change_directory $argv
end

