# Check OS
if [[ "$OSTYPE" == "linux-gnu" ]]; then
        # ...
        echo ""
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        echo ""
elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
        echo ""
elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
        echo ""
elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
        echo ""
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
        echo ""
else
        # Unknown.
        echo ""
fi

# Check command exists
if hash brew 2>/dev/null; then
        echo "Brew exists"
else
    echo "Brew is not installed"
fi