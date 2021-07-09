#!/bin/bash
echo "--- Create github trigger secret yaml"

cat > github-trigger-secret.yaml << EOM
apiVersion: v1
kind: Secret
metadata:
  name: github-trigger-secret
  namespace: bomc-tekton-pipelines
type: Opaque
stringData:
  secretToken: "bomc"
---
EOM

kubectl apply -f github-trigger-secret.yaml -n bomc-tekton-pipelines