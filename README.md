
# easykubeai

kubeai 헬름차트를 참고하여 작성한 헬름차트 입니다.
* https://www.kubeai.org
* https://github.com/substratusai/kubeai



## Installation

### Edit values file.
Edit easykubeai Value. Refer to `values_easykubeai.yaml`.
You can find another model catalogs in the `values.yaml`. 

### Install `easykubeai` Helm Chart
Install helm chart.
```sh
helm upgrade -i easy easykubeai -f values_easykubeai.yaml -n easy
```

## Test with embeded `streamlit` UI
If `ui.enabled` is true, you can see default streamlit ui.
### Edit `hosts` and browse
Add domain and IP `/etc/hosts` or `C:\Windows\System32\drivers\etc\hosts` File.
```
xxx.xxx.xxx.xxx easykubeai.local
```

## (Optional) Test with `open-webui`
* https://github.com/open-webui/open-webui
* https://github.com/open-webui/helm-charts 

### Install `open-webui` Helm Chart 
Edit open-webui Value and Helm Install. Refer to `values_open-webui.yaml`
```sh
helm repo add open-webui https://helm.openwebui.com/
helm pull open-webui/open-webui --version 7.2.0
helm upgrade -i open-webui open-webui-7.2.0.tgz -f values_open-webui.yaml -n easy
```

### Edit `hosts` and browse
Add domain and IP `/etc/hosts` or `C:\Windows\System32\drivers\etc\hosts` File.
```
xxx.xxx.xxx.xxx open-webui.local
```