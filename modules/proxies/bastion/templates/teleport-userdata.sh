#!/bin/bash
yum update -y
yum install -y curl

curl https://goteleport.com/static/install.sh | bash -s 14.3.3

# Configuração do Teleport
tee /etc/teleport.yaml <<EOF
teleport:
  nodename: bastion-host
  data_dir: /var/lib/teleport
  log:
    output: stderr
    severity: INFO
    format:
      output: text
  ca_pin: ""
  diag_addr: ""

auth_service:
  enabled: "yes"
  listen_addr: 0.0.0.0:3025
  proxy_listener_mode: multiplex
  cluster_name: ${CLUSTER__NAME}

proxy_service:
  enabled: "yes"
  web_listen_addr: 0.0.0.0:443
  public_addr: ${DNS_NAME}:443
  acme:
    enabled: "yes"
    email: ${EMAIL}

ssh_service:
  enabled: "yes"
  labels:
    - role=bastion
EOF

# Iniciar o serviço Teleport
systemctl enable teleport
systemctl start teleport

# Instalar e habilitar o pacote de atualizações automáticas
yum install -y yum-cron
systemctl start yum-cron
systemctl enable yum-cron
