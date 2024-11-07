#!/bin/bash

# Update package lists
sudo apt-get update -y

# Install Apache
sudo apt-get install apache2 -y

# Clone the GitHub repository
sudo git clone https://github.com/ChinmayiKundur35/static-website.git
sudo mkdir /var/www/html/staticapp
sudo cp -rf static-website/* /var/www/html/staticapp/.

# Destination directory
DEST_DIR="/var/www/html/staticapp"

# Check if the destination directory exists
if [ ! -d "$DEST_DIR" ]; then
    # If the directory doesn't exist, create it
    sudo mkdir -p "$DEST_DIR"

    # Copy files only if the destination directory was created
    if [ $? -eq 0 ]; then
        sudo cp -rf * "$DEST_DIR/"
        echo "Files copied to $DEST_DIR."
    else
        echo "Failed to create directory $DEST_DIR."
    fi
else
    echo "Directory $DEST_DIR already exists. Skipping copy."
fi

# Update Apache configuration to serve the new site
sudo sed -E -i 's|DocumentRoot[[:space:]]+/var/www/html/[^[:space:]]*|DocumentRoot /var/www/html/staticapp|' /etc/apache2/sites-available/000-default.conf

# Restart Apache to apply changes
sudo systemctl restart apache2

echo "Static website setup completed successfully."
