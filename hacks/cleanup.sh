
#!/usr/bin/env bash

val="$(kubectl get applications.argoproj.io -n argocd -l expiry,environment=dev -o custom-columns=":.metadata.name,:.metadata.labels.deleteAfter")"


while IFS= read -r line; do
  name=$(echo $line | awk '{print $1}')
  expiry=$(echo $line | awk '{print $2}')
  
  if [[ ${#name} -eq 0 ]]; then
    continue
  fi

  if [[ `date +%s` -ge $expiry ]]; then
    echo "deleting app $name expiring at $expiry"
    kubectl delete -n argocd applications.argoproj.io $name
    if [[ $? -ne 0 ]]; then
      exit 1
    fi
  fi
done <<<  "$val"
