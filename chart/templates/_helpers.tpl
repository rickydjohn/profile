{{- define "profile.namespace" }}
{{- if .Values.prprefix }}
{{- printf "ephemeral-%s" .Values.prprefix -}}
{{- else }}
{{- .Values.namespace }}
{{- end }}
{{- end }}



{{- define "profile.image" }}

{{- end }}
