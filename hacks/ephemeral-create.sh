#!/usr/bin/env bash

set -x


COMMIT_ID=$(echo $PULL_PULL_SHA | cut -f 1-7)
PRPREFIX=$(echo "$REPO_NAME-$PULL_NUMBER")
DELETEAT=$(($(date +%s) + 3600 ))

echo "
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  annotations:
    deleteAfter: $DELETEAT
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
        value: $COMMIT_ID
    path: chart
    repoURL: git@github.com:rickydjohn/profile.git
    targetRevision: $PULL_HEAD_REF
  syncPolicy:
    automated: {} 
    syncOptions:
    - CreateNamespace=true
" | kubectl apply -f - 
