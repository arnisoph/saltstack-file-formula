#!jinja|yaml

{% from "file/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('file:lookup')) %}

{% set symlinks = salt['pillar.get']('file:symlinks', {}) %}
{% for k, v in symlinks|dictsort %}
symlink_{{ k }}:
  file:
    - symlink
    - name: {{ v.path }}
    - target: {{ v.target }}
{% endfor %}
