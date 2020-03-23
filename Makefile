.PHONY: setup
setup: ansible snap
	echo "setup completed"

.PHONY: ansible
ansible:
	ansible-playbook --ask-become-pass --extra-vars="hosts=localhost" site.yml

.PHONY: snap
snap:
	sudo sh -c 'snap install intellij-idea-community || snap refresh intellij-idea-community'
	sudo snap install kubectl
	sudo snap install vault
	sudo snap install yq
