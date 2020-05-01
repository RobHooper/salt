install_rkhunter:
  salt.state:
    - tgt: {{ pillar['target-minion'] }}
    - sls: sysadmin-tools.rkhunter


