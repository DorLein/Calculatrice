#!/bin/bash

# Define the URL for the service health check
URL="http://localhost:8882/sum?a=2&b=2"  # Assuming the app exposes an endpoint to check sum

# Retry logic for checking if the service is up
for i in {1..20}; do
    echo "Waiting for service to start... retrying ($i/20)"
    if curl -s $URL > /dev/null; then
        echo "Service is up and running!"
        exit 0
    fi
    sleep 10  # Wait 10 seconds before retrying
done

echo "Error: No response from server after multiple retries."
exit 1

