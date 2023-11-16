#!/usr/bin/env bash
kubectl get applications.argoproj.io -n argocd -o custom-columns=":.metadata.name, :.metadata.labels.deleteAfter"

