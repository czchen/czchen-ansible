.PHONY: setup
setup: ansible asdf krew golang pipx snap yarn
	echo "setup completed"

################################################################################
# ansible
################################################################################

.PHONY: prepare-ansible
prepare-ansible:
	sudo apt install -y ansible
	sudo dpkg --add-architecture i386

.PHONY: ansible
ansible:
	ansible-playbook --ask-become-pass --extra-vars="hosts=localhost" site.yml

################################################################################
# asdf
################################################################################

define install-asdf
	asdf plugin-add $(1) || true
	asdf plugin-update $(1)
	asdf install $(1) $(2)
	asdf global $(1) $(2)
endef
.PHONY: asdf
asdf:
	$(call install-asdf,helm,3.1.2)
	$(call install-asdf,k9s,0.19.2)
	$(call install-asdf,nodejs,10.20.1)
	$(call install-asdf,sbt,1.3.10)
	$(call install-asdf,terraform,0.12.24)
	$(call install-asdf,yarn,1.22.4)

################################################################################
# krew
################################################################################

.PHONY: prepare-krew
prepare-krew:
	# https://krew.sigs.k8s.io/docs/user-guide/setup/install/
	set -x; cd "$(mktemp -d)" && curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.{tar.gz,yaml}" && tar zxvf krew.tar.gz && KREW=./krew-"$(shell uname | tr '[:upper:]' '[:lower:]')_amd64" && "$$KREW" install --manifest=krew.yaml --archive=krew.tar.gz && "$$KREW" update

.PHONY: krew
krew:
	kubectl krew install ctx
	kubectl krew install debug
	kubectl krew install grep
	kubectl krew install iexec
	kubectl krew install ns
	kubectl krew install tail
	kubectl krew install tree

################################################################################
# golang
################################################################################

define install-golang
	go get -u $(1)
endef
.PHONY: golang
golang:
	$(call install-golang,github.com/bronze1man/yaml2json)
	$(call install-golang,github.com/cswank/kcli)
	$(call install-golang,github.com/prometheus/prometheus/cmd/...)
	$(call install-golang,github.com/senorprogrammer/wtf)
	$(call install-golang,github.com/ueokande/logbook)
	$(call install-golang,github.com/wercker/stern)
	$(call install-golang,github.com/xo/usql)

################################################################################
# pipx
################################################################################

define install-pipx
	pipx install $(1) || pipx upgrade $(1)
endef
.PHONY: pipx
pipx:
	$(call install-pipx,autopep8)
	$(call install-pipx,bump2version)
	$(call install-pipx,httpie)
	$(call install-pipx,j2cli)
	$(call install-pipx,linode-cli)
	$(call install-pipx,mycli)
	$(call install-pipx,parquet-cli)
	$(call install-pipx,pipenv)
	$(call install-pipx,python-language-server)
	$(call install-pipx,tldr)
	$(call install-pipx,yaml-resume)

################################################################################
# snap
################################################################################

define install-snap
	sudo snap install $(1) $(2)
	sudo snap refresh $(1)
endef
.PHONY: snap
snap:
	$(call install-snap,intellij-idea-community,--classic)
	$(call install-snap,kontena-lens,--classic)
	$(call install-snap,kubectl,--classic)
	$(call install-snap,minecraft-launcher-ot)
	$(call install-snap,postman)
	$(call install-snap,vault)
	$(call install-snap,yq)

################################################################################
# yarn
################################################################################

define install-yarn
	yarn add global $(1)
endef
.PHONY: yarn
yarn:
	$(call install-yarn,kubelive)
