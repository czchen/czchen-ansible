# czchen-ansible

czchen environment setup script. Use the following command to setup environment
in `localhost`.

```
ansible-playbook --ask-become-pass --extra-vars="hosts=localhost" playbooks/czchen.yml
```
