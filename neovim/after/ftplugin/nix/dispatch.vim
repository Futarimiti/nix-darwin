let dirname = expand('%:p:h')

if dirname->stridx(expand('~/.config/nix-darwin')) is 0
  " will ask for passwd; recommend set up touch ID
  let b:dispatch =
        \ 'darwin-rebuild switch --flake ~/.config/nix-darwin --show-trace'
endif
