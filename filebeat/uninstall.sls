{% from "filebeat/map.jinja" import conf with context %}

{% set ssl_cert = salt['pillar.get']('filebeat:logstash:tls:ssl_cert', 'salt://filebeat/files/ca.pem') %}
{% set ssl_cert_path = salt['pillar.get']('filebeat:logstash:tls:ssl_cert_path') %}
{% set managed_cert = salt['pillar.get']('filebeat:logstash:tls:managed_cert', True) %}

filebeat.service_dead:
  service.dead:
    - name: filebeat
    - enable: False

filebeat.uninstall:
  pkg.removed:
    - name: filebeat
    - require:
      - service: filebeat.service_dead
      - file: filebeat.config_uninstall

{% if salt['pillar.get']('filebeat:logstash:tls:enabled', False) and ssl_cert and ssl_cert_path and managed_cert %}
{{ ssl_cert_path }}_uninstall:
  file.absent:
    - name: {{ ssl_cert_path }}
    - require_in:
      - pkg: filebeat.uninstall
{% endif %}

filebeat.config_uninstall:
  file.absent:
    - name: {{ conf.config_path }}
