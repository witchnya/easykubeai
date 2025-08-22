{{/*
Expand the name of the chart.
*/}}
{{- define "easykubeai.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "easykubeai.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "easykubeai.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "easykubeai.labels" -}}
helm.sh/chart: {{ include "easykubeai.chart" . }}
{{ include "easykubeai.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "easykubeai.selectorLabels" -}}
app.kubernetes.io/name: {{ include "easykubeai.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "easykubeai.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "easykubeai.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use for model pods
*/}}
{{- define "models.serviceAccountName" -}}
{{- if .Values.modelServiceAccount.create }}
{{- default (printf "%s-models" (include "easykubeai.fullname" .)) .Values.modelServiceAccount.name }}
{{- else }}
{{- default "default" .Values.modelServiceAccount.name }}
{{- end }}
{{- end }}


{{/* comma list */}}
{{- define "apiBaseList" }}
{{- $list := list }}
{{- range $serveName, $model := .Values.catalog }}
  {{- if not $model }}
  {{- else if $model.enabled }}
    {{- $port := int $.Values.service.port }}
    {{- if eq $model.engine "OLlama" }}
      {{- $list = append $list (printf "http://model-%s.%s:%d/v1" (regexReplaceAll "[^a-zA-Z0-9-]" (lower $serveName) "-") $.Release.Namespace $port) }}
    {{- else if eq $model.engine "VLLM" }}
      {{- $list = append $list (printf "http://model-%s.%s:%d/v1" (regexReplaceAll "[^a-zA-Z0-9-]" (lower $serveName) "-") $.Release.Namespace $port) }}
    {{- end }}
  {{- end }}
{{- end }}
{{- join ", " $list -}}
{{- end -}}


{{/* print list */}}
{{- define "apiBaseListPrint" }}
{{- $list := list }}
{{- range $serveName, $model := .Values.catalog }}
  {{- if not $model }}
  {{- else if $model.enabled }}
    {{- $port := int $.Values.service.port }}
    {{- if eq $model.engine "OLlama" }}
      {{- $list = append $list (printf "http://model-%s.%s:%d/v1" (regexReplaceAll "[^a-zA-Z0-9-]" (lower $serveName) "-") $.Release.Namespace $port) }}
    {{- else if eq $model.engine "VLLM" }}
      {{- $list = append $list (printf "http://model-%s.%s:%d/v1" (regexReplaceAll "[^a-zA-Z0-9-]" (lower $serveName) "-") $.Release.Namespace $port) }}
    {{- end }}
  {{- end }}
{{- end }}
{{- range $item := $list -}}
{{- printf "- %s \n" $item -}}
{{- end -}}
{{- end -}}
