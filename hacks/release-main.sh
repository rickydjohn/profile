#!/usr/bin/env bash

set -x


COMMIT_ID=$(echo $PULL_PULL_SHA | cut -c 1-7)
NAME=$(echo "$REPO_NAME")-prod

echo "Current working directory: $PWD"
echo "current files:"
ls -l

echo "
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  labels:
    environment: "prod"
  name: $NAME
  namespace: argocd
spec:
  destination:
    server: https://kubernetes.default.svc
  project: default
  source:
    helm:
      valueFiles:
      - values.yaml
      parameters:
      - name: deployment.tag
        value: $COMMIT_ID
    path: chart
    repoURL: git@github.com:rickydjohn/profile.git
    targetRevision: HEAD
  syncPolicy:
    automated: {} 
    syncOptions:
    - CreateNamespace=true
" | kubectl apply -f - 


if [[ $? -ne 0 ]] ; then
  echo "failed to bring up argo app $NAME"
  exit 1
fi
