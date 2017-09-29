filebeat-pkgrepo:
  pkgrepo.managed:
    - name: filebeat
    - humanname: Elastic repository for 5.x packages
    - baseurl: https://artifacts.elastic.co/packages/5.x/yum
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: https://artifacts.elastic.co/GPG-KEY-elasticsearch
    - sslverify: 1
    - autorefresh: 1
    - type: rpm-md
