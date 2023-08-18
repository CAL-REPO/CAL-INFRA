#!/bin/bash

# Check if DEBIAN_FRONTEND is already set in /etc/environment
if ! grep -q '^DEBIAN_FRONTEND=' /etc/environment; then
    # Add DEBIAN_FRONTEND=noninteractive to /etc/environment
    echo 'DEBIAN_FRONTEND=noninteractive' | tee -a /etc/environment > /dev/null
    echo 'DEBIAN_FRONTEND=noninteractive has been added to /etc/environment.'
else
    echo 'DEBIAN_FRONTEND is already set in /etc/environment. No changes made.'
fi