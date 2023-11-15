{{- define "profile.namespace" }}
{{- if .Values.prprefix }}
{{- printf "ephemeral-%s" .Values.prprefix -}}
{{- else }}
{{- .Values.namespace }}
{{- end }}
{{- end }}



{{- define "profile.hostname" }}
{{- if .Values.prprefix }}
{{- printf "%s.%s" .Values.prprefix .Values.hostname -}}
{{- else }}
{{- .Values.hostname }}
{{- end }}
{{- end }}
