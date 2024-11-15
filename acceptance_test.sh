#!/bin/bash

# Wait for the application to be fully up and accessible on port 8882
echo "Waiting for the application to be ready..."
until curl -s localhost:8882/sum?a=2&b=2 | grep -q "4"; do
  echo "Waiting for app to be ready..."
  sleep 5
done

# Perform the test
response=$(curl -s localhost:8882/sum?a=2&b=2)

echo "Response: $response"  # Debug output

if [[ "$response" -eq 4 ]]; then
  echo "Test passed!"
else
  echo "Test failed or unexpected response: $response"
  exit 1
fi

