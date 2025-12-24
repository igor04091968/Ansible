# Ansible Playbook Registry

Этот файл содержит список и описание всех плейбуков в директории `Ansible`.

---

### 1. `setup_caddy_proxy.yml`

- **Назначение:** Устанавливает Caddy как сервис и настраивает его как реверс-прокси для сервиса Grafana, запущенного в k3s. Автоматически переключает сервис Grafana в режим `NodePort`.
- **Команда для запуска:**
  ```bash
  ANSIBLE_CONFIG=/mnt/usb_hdd1/Projects/Ansible/ansible.cfg ansible-playbook /mnt/usb_hdd1/Projects/Ansible/setup_caddy_proxy.yml
  ```

---

### 2. `deploy_all.yml`

- **Назначение:** Комплексный плейбук, который импортирует другие плейбуки для установки `node_exporter` и `wireguard_exporter` на удаленные хосты, а затем разворачивает/обновляет стек мониторинга (Prometheus, Grafana) и приложение SUI в кластере k3s.
- **Команда для запуска:**
  ```bash
  ANSIBLE_CONFIG=/mnt/usb_hdd1/Projects/Ansible/ansible.cfg ansible-playbook /mnt/usb_hdd1/Projects/Ansible/deploy_all.yml
  ```

---

### 3. `update_system.yml`

- **Назначение:** Обновляет пакеты на всех хостах, указанных в инвентаре (`gw`, `vds`, `site`), и перезагружает их, если это необходимо.
- **Команда для запуска:**
  ```bash
  ansible-playbook update_system.yml
  ```

---

### 4. `acme_certs.yml`

- **Назначение:** Управляет сертификатами ACME (Let's Encrypt) на хостах `vds` и `gw`. Проверяет и обновляет сертификаты, а затем перезагружает сервисы (Nginx, GOST, Caddy), которые их используют.
- **Команда для запуска:**
  ```bash
  ansible-playbook acme_certs.yml
  ```

---

### 5. `install_node_exporter.yml`

- **Назначение:** Устанавливает Prometheus Node Exporter на хосты из группы `monitored_vms` для сбора системных метрик.
- **Команда для запуска:**
  ```bash
  ansible-playbook install_node_exporter.yml
  ```

---

### 6. `install_wireguard_exporter.yml`

- **Назначение:** Устанавливает Prometheus WireGuard Exporter на хосты из группы `monitored_vms` для сбора метрик с WireGuard.
- **Команда для запуска:**
  ```bash
  ansible-playbook install_wireguard_exporter.yml
  ```

---

### 7. `git_sync.yml`

- **Назначение:** Синхронизирует указанный проект с GitHub. Делает `git add`, `commit` и `push`. Требует передачи переменных `project_path` и `commit_message`.
- **Команда для запуска (пример):**
  ```bash
  ansible-playbook git_sync.yml -e "project_path=/path/to/your/project" -e "commit_message='Your commit message'"
  ```

---

### 8. `git_sync_ansible_repo.yml`

- **Назначение:** Специализированная версия `git_sync.yml`, которая синхронизирует саму директорию `Ansible` с GitHub.
- **Команда для запуска:**
  ```bash
  ansible-playbook git_sync_ansible_repo.yml
  ```

---

### 9. `git_pull.yml`

- **Назначение:** Выполняет `git pull` в директории проекта `sing-chisel-tel`, чтобы получить последние изменения из удаленного репозитория.
- **Команда для запуска:**
  ```bash
  ansible-playbook git_pull.yml
  ```

---

### 10. `fix_acme.yml`

- **Назначение:** Исправляет установку `acme.sh` на хосте `vds` путем переустановки из свежего git-клона.
- **Команда для запуска:**
  ```bash
  ansible-playbook fix_acme.yml
  ```

---

### 11. `ping.yml`

- **Назначение:** Простой плейбук для проверки доступности хостов из группы `site` с помощью модуля ping.
- **Команда для запуска:**
  ```bash
  ansible-playbook ping.yml
  ```

---

### 12. `test_k8s_collection.yml`

- **Назначение:** Тестовый плейбук для отладки. Проверяет, может ли Ansible использовать коллекцию `community.kubernetes` для получения информации о сервисах Kubernetes.
- **Команда для запуска:**
  ```bash
  ansible-playbook test_k8s_collection.yml
  ```
