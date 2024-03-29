#!/usr/bin/env bash

set -x


COMMIT_ID=$(echo $PULL_PULL_SHA | cut -c 1-7)
PRPREFIX=$(echo "$REPO_NAME-$PULL_NUMBER")
DELETEAT=$(($(date +%s) + 360 ))

echo "Current working directory: $PWD"
echo "current files:"
ls -l

echo "
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  finalizers:
  - resources-finalizer.argocd.argoproj.io
  labels:
    deleteAfter: \"$DELETEAT\"
    expiry: \"true\"
    environment: \"dev\"
  name: $PRPREFIX
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
      - name: prprefix
        value: $PRPREFIX
      - name: deployment.tag
        value: \"$COMMIT_ID\"
    path: chart
    repoURL: git@github.com:rickydjohn/profile.git
    targetRevision: $PULL_HEAD_REF
  syncPolicy:
    automated: {} 
    syncOptions:
    - CreateNamespace=true
" | kubectl apply -f - 


if [[ $? -ne 0 ]] ; then
  echo "failed to bring up argo app $PRPREFIX"
  exit 1
fi
