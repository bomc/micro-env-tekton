#!/bin/bash
echo "--- Create tekton secret yaml"

# Create private and public key without passphrase.
ssh-keygen -t rsa -b 4096 -C "tekton@tekton.dev" -f tekton-ssh-key -N ""

echo "--- Extract private code base64 encoded."
export ENV_PRIV_KEY="$(cat tekton-ssh-key | base64 -w 0)"
echo $ENV_PRIV_KEY

echo "--- Create secret as kubernetes resource."
cat > 010-tekton-git-ssh-secret << EOM
apiVersion: v1
kind: Secret
metadata:
  name: git-ssh
  namespace: tekton-pipelines
  annotations:
    tekton.dev/git-0: github.com
type: kubernetes.io/ssh-auth
data:
  ssh-privatekey: ${ENV_PRIV_KEY}
---
EOM

unset ENV_PRIV_KEY
