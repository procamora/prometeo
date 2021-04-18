

# Filebeat

## Pasos comunes para debugear


```bash
# Verificar configuracion
filebeat test config -c filebeat.j2.yml

# Ejecutar 
filebeat -c filebeat.j2.yml

# Borrar registro para posterior ejecucion desde el prinicpio del fichero
rm -rf /var/lib/filebeat/registry
```

## Configuracion para leer fichero y mostrar por pantalla

```yaml
---
filebeat.inputs:
- type: log
  paths:
    - /var/log/audit/audit.log

output.console:
  pretty: true
```


## Configuracion para leer fichero con modulo y mostrar por pantalla

```bash
filebeat modules enable system auditd
cat -p /etc/filebeat/modules.d/auditd.yml
```

```yaml
---
- module: auditd
  log:
    enabled: true
    var.paths: ["/var/log/audit/audit.*"]
```

```yaml
---
filebeat.modules:
- module: auditd
  log.enabled: true
tags: ["linux_audit"]

output.console:
  pretty: true
```

## Configuracion para leer fichero con modulo y enviar a logstash

```yaml
---
filebeat.modules:
- module: auditd
  log.enabled: true
tags: ["linux_audit"]

output.logstash:
  hosts: ["127.0.0.1:5044"]
```



# Logstash


## Ejecutar logstash en modo imprimir por consola

```bash
# Verificar configuracion
/usr/share/logstash/bin/logstash -f /etc/logstash/pipeline_debug.conf --config.test_and_exit

# Ejecutar 
/usr/share/logstash/bin/logstash -f /etc/logstash/pipeline_debug.conf
```

```yaml
input {
    beats {
        port => "5044"
    }
}

output {
    stdout { }
}
```













tshark -i eth0 -Y "ip.src==192.168.1.201 and ip.dst==192.168.1.14 and http"


