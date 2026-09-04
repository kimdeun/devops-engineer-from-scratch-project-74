# Упаковка в Docker Compose

[![hexlet-check](https://github.com/kimdeun/devops-engineer-from-scratch-project-74/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/kimdeun/devops-engineer-from-scratch-project-74/actions)
[![push](https://github.com/kimdeun/devops-engineer-from-scratch-project-74/actions/workflows/push.yml/badge.svg)](https://github.com/kimdeun/devops-engineer-from-scratch-project-74/actions/workflows/push.yml)

Docker Compose-окружение для Fastify-блога с PostgreSQL, Caddy и автоматической
публикацией production-образа через GitHub Actions.

Учебный проект Хекслета: https://ru.hexlet.io/programs/devops-engineer-from-scratch
Как это должно работать: https://asciinema.org/a/zVrFYtslVReMsTyqEEetdWUY5

## Требования

- Docker
- Docker Compose 1.27.0 или новее
- GNU Make
- Свободные локальные порты 80, 443 и 8080

## Установка

```bash
git clone https://github.com/kimdeun/devops-engineer-from-scratch-project-74.git
cd devops-engineer-from-scratch-project-74
make setup
```

Команда `make setup` создаёт локальный `.env` из `.env.example`. В нём приложение
настроено на PostgreSQL-сервис `db`; файл с локальными переменными не попадает в Git.

## Использование

Запустите приложение в режиме разработки:

```bash
make dev
```

После запуска приложение напрямую доступно по адресу <http://localhost:8080>.
Caddy перенаправляет <http://localhost> на <https://localhost> и проксирует HTTPS-запросы
в приложение. Браузер может предупредить о локальном самоподписном сертификате.

`Makefile` передаёт Docker Compose идентификаторы текущего пользователя, поэтому
созданные контейнером файлы не будут принадлежать `root`.

Основная Compose-конфигурация запускает тесты без подключения override-файла:

```bash
make test
```

В CI используется аналогичная команда:

```bash
make ci
```

Сборка production-образа и его публикация в Docker Hub:

```bash
make build
docker login
make push
```

Образ на Docker Hub: `kimdeun/devops-engineer-from-scratch-project-74:latest`.

Для публикации из GitHub Actions добавьте в настройках репозитория секреты
`DOCKERHUB_USERNAME` и `DOCKERHUB_TOKEN`. Токен создаётся в настройках
безопасности Docker Hub.

Проверить уже собранный production-образ можно командой:

```bash
make run-production
```

Для остановки нажмите `Ctrl+C`, затем выполните:

```bash
make down
```

---

<details>
<summary>Автоматические тесты Хекслета</summary>

Тесты запускаются на каждый коммит. За запуск отвечает файл `.github/workflows/hexlet-check.yml` — не удаляйте и не переименовывайте ни его, ни репозиторий.

</details>

## О Хекслете

[Хекслет](https://ru.hexlet.io/) — школа программирования: авторские программы обучения с практикой, поддержкой наставников и реальными проектами, которые остаются в резюме. Этот репозиторий — один из таких проектов.
