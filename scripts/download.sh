#!/bin/bash

# The package name to install
PACKAGE_NAME="gym-tea"

# Maximum number of attempts to try
MAX_ATTEMPTS=2

# Wait time between retries (in seconds) to respect rate limits
WAIT_TIME=5

for (( i=1; i<=2000; i++ ))
do
    echo "Checking if $PACKAGE_NAME is already installed (iteration $i of 300)..."
    npm list $PACKAGE_NAME &> /dev/null
    if [ $? -eq 0 ]; then
        echo "$PACKAGE_NAME is installed, uninstalling..."
        npm uninstall $PACKAGE_NAME
    fi

    attempt=1
    while [ $attempt -le $MAX_ATTEMPTS ]; do
        echo "Attempt $attempt to install $PACKAGE_NAME"
        
        # Try to install the package
        npm install $PACKAGE_NAME && break || {
            if [ $attempt -eq $MAX_ATTEMPTS ]; then
                echo "Failed to install $PACKAGE_NAME after $MAX_ATTEMPTS attempts, moving on..."
                break
            fi

            echo "Installation failed, retrying in $WAIT_TIME seconds..."
            attempt=$((attempt+1))
            sleep $WAIT_TIME
        }
    done
done
npm uninstall $PACKAGE_NAME
echo "Script completed."