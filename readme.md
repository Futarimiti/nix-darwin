```sh
rm -rf ~/.config/nix-darwin/
git clone --recurse-submodules -b main git@github.com:Futarimiti/nix-darwin.git ~/.config/nix-darwin/
darwin-rebuild switch --flake ~/.config/nix-darwin
```
