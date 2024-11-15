#!/bin/bash
test $(curl localhost:8882/sum?a=2&b=2)-eq 4

