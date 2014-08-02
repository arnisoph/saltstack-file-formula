#!jinja|yaml

{% from "file/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('file:lookup')) %}

include: {{ datamap.mounts.sls_include|default([]) }}
extend: {{ datamap.mounts.sls_extend|default({}) }}

{%- macro set_p(paramname, dictvar) -%}
  {%- if paramname in dictvar -%}
- {{ paramname }}: {{ dictvar[paramname] }}
  {%- endif -%}
{%- endmacro -%}

{% set mounts = salt['pillar.get']('file:mounts', []) %}
{% for k, v in mounts.items() %}
mount_{{ k }}:
  mount:
    - {{ v.ensure|default('mounted') }}
    - name: {{ v.path }}
  {% for o in ['device', 'fstype', 'mkmnt', 'opts', 'dump', 'pass_num', 'config', 'persist', 'mount'] %}
    {{ set_p(o, v) }}
  {% endfor %}
{% endfor %}
