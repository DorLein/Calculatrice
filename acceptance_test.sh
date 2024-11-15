#!/bin/bash

# Retry mechanism to check if the service is up
for i in {1..10}; do
  response=$(curl -s localhost:8882/sum?a=2&b=2)
  if [ -n "$response" ]; then
    echo "Service is up, running the test."
    break
  fi
  echo "Waiting for service to start... retrying ($i/10)"
  sleep 5
done

# Check if we got a valid response
if [ -z "$response" ]; then
  echo "Error: No response from server."
  exit 1
fi

# Perform the test only if response is not empty
if [ "$response" -eq 4 ]; then
  echo "Test passed!"
else
  echo "Test failed: unexpected response: $response"
  exit 1
fi

