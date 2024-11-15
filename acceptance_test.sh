#!/bin/bash
test $(curl localhost:8882/sum?a=471\&b=2780) -eq 3251

