## Install command
#salt-run state.orch sysadmin-tools.install-orch pillar='{"target-minion":"ex1.example.com"}'

install_rkhunter:
  salt.state:
    - tgt: {{ pillar['target-minion'] }}
    - sls: sysadmin-tools.rkhunter


