#!/bin/sh

# this script creates service resource
# and API route on existing Kong API gateway

# create new service with httpbin backend
curl -v -XPOST localhost:8001/services \
  --data name=mock_service \
  --data url='https://httpbin.konghq.com'

# create new HTTP route for the new service
curl -v -XPOST localhost:8001/services/mock_service/routes \
  --data 'paths[]=/mock' \
  --data name=mock_route
