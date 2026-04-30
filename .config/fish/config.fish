fish_add_path ~/.local/bin
fish_add_path ~/.local/share/bob/nvim-bin

if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source
    fzf --fish | source
end
