FROM quay.io/operator-framework/ansible-operator:v1.24.0

RUN curl -LO https://github.com/concourse/concourse/releases/download/v7.8.1/fly-7.8.1-linux-amd64.tgz
RUN tar xvzf fly-7.8.1-linux-amd64.tgz

RUN mv fly /tmp/fly

COPY requirements.yml ${HOME}/requirements.yml
RUN ansible-galaxy collection install -r ${HOME}/requirements.yml \
 && chmod -R ug+rwx ${HOME}/.ansible

COPY watches.yaml ${HOME}/watches.yaml
COPY roles/ ${HOME}/roles/
COPY playbooks/ ${HOME}/playbooks/
