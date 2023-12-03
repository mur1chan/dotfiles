alias rmi="nixupdate"
function nixupdate
    sudo sudo nix-channel --update
end

alias rmi="nixrebuild"
function nixrebuild
    sudo nixos-rebuild switch
end

alias rmi="nixgarbage"
function nixgarbage
    sudo nix-collect-garbage --delete-older-than 3d
end

alias rmi="pyvenv"
function pyvenv
   python3 -m venv .venv 
   source .venv/bin/activate.fish
end

alias rmi="pyac"
function pyac
    source .venv/bin/activate.fish
end
