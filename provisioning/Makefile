server:
	ansible-playbook -i server.yml hosts.yml

authorize:
	ansible-playbook -i authorize.yml hosts.yml

generate-agent-key:
	ssh-keygen -q -t rsa -N '' -f files/agent_rsa

authorize-agents:
	ansible-playbook authorize-agents.yml -i hosts.yml

upgrade:
	ansible-playbook -i upgrade.yml hosts.yml

renew-certificates:
	ansible-playbook -i renew-certificates.yml hosts.yml

check-alive-hosts:
	ansible all -m ping -i hosts.yml

show-initial-password:
	ansible -i hosts.yml manager -m shell -a 'cd /home/deploy/jenkins && docker-compose exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword'
