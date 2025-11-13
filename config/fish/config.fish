# Disable the default Fish greeting
set -g fish_greeting

# Only run fastfetch in interactive sessions
if status is-interactive
    fastfetch
end

starship init fish | source
