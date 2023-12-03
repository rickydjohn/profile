
#!/usr/bin/env bash

set -x


for i in $(kubectl get applications.argoproj.io -n argocd -l expiry,environment=dev -o custom-columns=":.metadata.name"); do
  expiry=$(kubectl get applications.argoproj.io -n argocd $i -o jsonpath='{.metadata.labels.deleteAfter}')
  if [[ $(date +%s) -ge $expiry ]]; then
    echo "deleting argocd application $i with expiry at $expiry"
    kubectl delete applications.argoproj.io -n argocd $i
  fi
done
