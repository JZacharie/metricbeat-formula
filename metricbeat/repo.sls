{% if salt['grains.get']('os_family') == 'Debian' %}

ensure apt can handle https transport for metricbeat:
  pkg.installed:
    - name: apt-transport-https

setup metricbeat repo:
  pkgrepo.managed:
    - name: deb https://artifacts.elastic.co/packages/5.x/apt stable main
    - file: /etc/apt/sources.list.d/elasticsearch.list
    - key_url: https://artifacts.elastic.co/GPG-KEY-elasticsearch

{% elif salt['grains.get']('os_family') == 'RedHat' %}

metricbeat_repo:
  pkgrepo.managed:
    - name: elk_beats
    - humanname: Elasticsearch repository for 2.x packages
    - baseurl: https://packages.elastic.co/beats/yum/el/x86_64
    - gpgcheck: 1
    - gpgkey: https://packages.elastic.co/GPG-KEY-elasticsearch

{% endif %}
