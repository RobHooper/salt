# Orchestration file for a rolling application update

## Set variables
{% set mine_info = salt['saltutil.runner']('mine.get', tgt='hwaas:online', fun='hwaas-webserver-addr', tgt_typ='grain') %}
{% set minion_ids = mine_info.keys() | list %}
{% set group_size = ((minion_ids | length) / 2 ) | int %}
{% set primary_group = ','.join(minions_ids[:group_size]) %}
{% set secondary_group = ','.join(minion_ids[group_size:]) %}

## Alternative approach
#{% set primary_group = minions_ids[:group_size] %}
# Then in the function 
#    - tgt: {{ ','.join(primary_group) }}


## Update primary servers
remove_grain_from_primary:
  salt.function:
    - name: grains.delval
    - tgt: {{ primary_group }}
    - tgt_type: list
    - arg:
      - hwaas
      - True

remove_primary_from_loadbalancing:
  salt.state:
    - sls:load-balance
    - tgt: roles:load-balancing
    - tgt_type: grain
    - require:
      - salt: remove_grain_from_primary

upgrade_primary:
  salt.state:
    - sls: hwaas-service
    - tgt: {{ primary_group }}
    - tgt_type: list
    - require:
      - salt: remove_primary_from_loadbalancing

reset_grain_on_primary:
  salt.function:
    - name: grains.append
    - tgt: {{ primary_group }}
    - tgt_type: list
    - arg:
      - hwaas
      - online
    - require:
      - salt: upgrade_primary


## Sweep two

remove_grain_from_secondary:
  salt.function:
    - name: grains.delval
    - tgt: {{ secondary_group }}
    - tgt_type: list
    - arg:
      - hwaas
      - True
    - require:
      - salt: reset_grain_on_primary


remove_secondary_from_loadbalancing:
  salt.state:
    - sls:load-balance
    - tgt: roles:load-balancing
    - tgt_type: grain
    - require:
      - salt: remove_grain_from_secondary

upgrade_secondary:
  salt.state:
    - sls: hwaas-service
    - tgt: {{ secondary_group }}
    - tgt_type: list
    - require:
      - salt: remove_secondary_from_loadbalancing

reset_grain_on_secondary:
  salt.function:
    - name: grains.append
    - tgt: {{ secondary_group }}
    - tgt_type: list
    - arg:
      - hwaas
      - online
    - require:
      - salt: upgrade_secondary

## Finish

final_load_balancer_update:
  salt.state:
    - sls:load-balance
    - tgt: roles:load-balancing
    - tgt_type: grain
    - require:
      - salt: reset_grain_on_secondary:


