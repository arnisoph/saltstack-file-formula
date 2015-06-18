#!jinja|yaml

{% from "file/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('file:lookup')) %}

{% set symlinks = salt['pillar.get']('file:symlink', {}) %}
{% for k, v in symlinks.items() %}
symlink_{{ k }}:
  file.symlink:
    - name: {{ v.path }}
    - target: {{ v.target }}
{% endfor %}
