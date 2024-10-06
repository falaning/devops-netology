{{/*
Common template helpers for charts
*/}}

{{- define "nginx-chart.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "nginx-chart.name" -}}
{{- printf "%s" .Chart.Name -}}
{{- end -}}
