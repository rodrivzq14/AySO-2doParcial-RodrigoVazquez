cd ansible/       
git clone https://github.com/upszot/UTN-FRA_SO_Ansible.git
cd UTN-FRA_SO_Ansible/
cd ejemplo_01
ip address show
ssh-keygen
cat ~/.ssh/id_rsa.pub

--pasos del host--
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCidikLPzg4sGQaSydL29/3njnvz8TUCZd4boF983uBSCjC20sw/MZSsPSOAFg3IABewDP1LyAysCA7KKLYIepFOQ+wpV8MXavGNR+++va6THgq2r7Pm5SThw86Vw3KC6CPjwgVhndW6uxNCTBgRF9IjbwEphdNt/1P3hloTd3S1e8Qrnb3CLU2pbq03+o63wwijFlmjx3xL5HaUw9cpmTwEMSqvHEQ5vshMynAsQeYoAjQRw9LKcCTrGuzaEDENGt9nhQi3OgoCygdBuK9zCXhS6VI8B877+fyXkeqV5t9EGrdrlvTLN1zPKgI8q3GDkoIeHbl+QVUhCToxssqNj5hU6RAkkU2SjXeNSU1xQHqhkp1DeMbKMxJBxpwhA/YleKytwCkESh7zoyrUfdCgm6MGEzTmG6+e/kdw3J27C0PVaOOK+IhDHWyiqh5VNQLyPIxPQP+AG9X/4U2oIEegiF2LtSiuOtT3bocAbo9qx9C6QWtllcYFWzrtXyaBEURljgWjW7O6ytY0YRayV+U8vpzvP1Tkug767YnFM6lMikOr/RQDdvCgqeJzdtADzwHYQCDn7AAknpNgxgcb7u2uldzQGoHmjJAS7NgInxOLCFOM5sQr7FrGGsMAKOrTGHCux/bYJmaa1nfIKdv68EMG0vROC1U3NaUC3+KR3TAHeqewQ== rodrigovazquez443@gmail.com" >> .ssh/authorized_keys

--fin pasos host--


cd ejemplo_02
vim inventory
	[testing]


	desarrollo]
	192.168.56.2

	[produccion]

vim playbook.yml
	---
- hosts:
    - all
  tasks:
    - name: "Set WEB_SERVICE dependiendo de la distro"
      set_fact:
        WEB_SERVICE: "{% if   ansible_facts['os_family']  == 'Debian' %}apache2
                      {% elif ansible_facts['os_family'] == 'RedHat'  %}httpd
                      {% endif %}"

    - name: "Muestro nombre del servicio:"
      debug:
        msg: "nombre: {{ WEB_SERVICE }}"

    - name: "Run the equivalent of 'apt update' as a separate step"
      become: yes
      ansible.builtin.apt:
        update_cache: yes
      when: ansible_facts['os_family'] == "Debian"

    - name: "Instalando apache "
      become: yes
      package:
        name: "{{ item }}"
        state: present
      with_items:
        - "{{ WEB_SERVICE }}"


ansible-playbook -i inventory playbook.yml
ssh vagrant@192.168.56.2
sudo apt list --installed |grep apache
