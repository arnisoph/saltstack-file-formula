#!jinja|yaml

{% from "file/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('file:lookup')) %}

include: {{ datamap.quota.sls_include|default([]) }}
extend: {{ datamap.quota.sls_extend|default({}) }}

quota:
  pkg:
    - installed
    - pkgs: {{ datamap.quota.pkgs }}

{% for k, v in salt['pillar.get']('file:quota', {})|dictsort %}
  {% set device = v.device|default(salt['mount.fstab']()[v.path].device) %}
  {% if v.quotacheck|default(True) and salt['quota.get_mode'](device)[v.path][v.type] == 'off' %}
quotacheck:
  cmd:
    - run
    - name: quotacheck -vm {% if v.type == 'user' -%}-u{%- else %}-g{%- endif %} {{ v.path }}
  {% endif %}

quota_manage_{{ k }}_{{ v.type }}:
  quota:
    - mode
    - name: {{ v.path }}
    - mode: {{ v.mode|default('on') }}
    - quotatype: {{ v.type }}
{% endfor %}


