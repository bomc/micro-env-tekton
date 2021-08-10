#!/bin/bash

# HMAC generated from payload + GH secret

curl -i \
  -H 'X-GitHub-Event: push' \
  -H 'X-Hub-Signature: sha1=<...>' \
  -H 'Content-Type: application/json' \
  -d '{"ref":"refs/heads/main","head_commit":{"id":"04911b76f9541d0088f65fab39813fe0ee130998"},"environment":"prod"}' \
  http://localhost:8080