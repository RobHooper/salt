set-new-minion-role:
  salt.function:
    - name: grains.append
    - tgt: {{ pillar['target-minion'] }}
    - arg:
      - roles
      - [webserver,rhnet]

apply-states-on-new-minion:
  salt.state:
    - tgt: {{ pillar['target-minion'] }}
    - highstate: True
    - require:
       - salt: set-new-minion-role

refresh-pillar-on-new-minion:
  salt.function:
    - name: saltutil.refresh_pillar
    - tgt: {{ pillar['target-minion'] }}
    - require:
       - salt: apply-states-on-new-minion

update-mine-data-from-new-minion:
  salt.function:
    - name: mine.update
    - tgt: {{ pillar['target-minion'] }}
    - require:
      - salt: refresh-pillar-on-new-minion

# Not sure why this isn't erroring what is the load-balance.sls file?
run-state-apply-on-webservers:
  salt.state:
    - tgt: roles:webserver
    - tgt_type: grain
    - sls: load-balance
    - require:
      - salt: update-mine-data-from-new-minion
  
