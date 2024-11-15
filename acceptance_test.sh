#!/bin/bash
test $(curl localhost:8765/sum?a=471\&b=2780) -eq 3251

