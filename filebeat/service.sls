include:
  - filebeat.install

filebeat.service:
  service.running:
    - name: filebeat
    - enable: True
    - watch:
      - pkg: filebeat
    - require:
      - pkg: filebeat
