#!/bin/bash

# Capture the response from curl
response=$(curl -s localhost:8882/sum?a=2&b=2)

# Check if the response is empty
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

