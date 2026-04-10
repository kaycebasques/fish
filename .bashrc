# switch to fish in interactive sessions
if [[ $- == *i* ]]; then
    exec fish
fi
