.PHONY: setup
setup: ansible snap
	echo "setup completed"

.PHONY: ansible
ansible:
	ansible-playbook --ask-become-pass --extra-vars="hosts=localhost" site.yml

.PHONY: snap
snap:
	snap install
