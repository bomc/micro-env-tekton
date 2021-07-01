#!/bin/bash
set -euo pipefail
cd ${0%/*}

#kubectl delete pipelineruns.tekton.dev -n bomc-tekton-pipelines pipelinerun --ignore-not-found
kubectl create -f consumer-pipeline-run.yml -n bomc-tekton-pipelines

sleep 1
tkn pipelinerun logs -f -n tekton-pipelines