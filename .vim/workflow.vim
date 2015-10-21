"Load my config files
function! ShowConfig()
  :edit ~/.vimrc
  :vsp
  :edit ~/.sprint
  :sp
  :edit ~/.bashrc
endfunction

:command Kconf call ShowConfig()
