install-nautilus-scripts:

    @echo "Downloading nautilus-scripts..."
    curl -fsSL https://cfgnunes.github.io/nautilus-scripts/install.sh -o /tmp/nautilus-install.sh
    chmod +x /tmp/nautilus-install.sh

    @echo "Installing..."
    # -n: Non-interactive | -C: Skip dependency check | -s: Add app menu shortcuts
    /tmp/nautilus-install.sh -n -C -s
    rm -f /tmp/nautilus-install.sh

    @echo "Restarting the file manager..."
    nautilus -q || true

    @echo "Done!"

purge-nautilus-scripts:

    @echo "Removing nautilus-scripts..."
    rm -rf ~/.local/share/nautilus/scripts/*

    @echo "Restarting the file manager..."
    nautilus -q || true

    @echo "Done!"