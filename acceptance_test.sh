response=$(curl -s localhost:8882/sum?a=2&b=2)
if [[ "$response" -eq 4 ]]; then
  echo "Test passed!"
else
  echo "Test failed or unexpected response: $response"
  exit 1
fi

