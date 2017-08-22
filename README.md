## Evalúa tu trámite Puebla

[Licencia](/LICENSE)

### Deploy
En nuestro `Makefile` tenemos especificado un target `deploy`, que
nos ayuda a _automatizar_ el proceso de deployment:

```bash
# Makefile targets

build          # Build the Docker image inisde the HOST
clean          # Remove images that are not being used by any container
deploy         # Run the deploy strategy (provide, build, update, clean)
provide        # Provide the HOST with whole repository
update         # Update the containers and run migrations
```

Para correr el target, es necesario tener un
`docker-compose.production.yml` que describe los servicios que
se usarán en producción, también es necesario un `.env`
que contiene las variables de ambiente.

```bash
HOST=user@hostname \
APP_DIR=/var/www/app \
make deploy
```

#### Dependencias
- Bash
- SSH
- Tar
- Make
- [Docker >= 17.01.0-ce](https://docs.docker.com/engine/installation/linux/ubuntu/)
- [docker-compose >= 1.11.2](https://docs.docker.com/compose/install/)

### ¿Dudas?

Escríbenos a <equipo@codeandomexico.org>.

### Equipo

El proyecto ha sido iniciado por [Codeando México](https://github.com/CodeandoMexico?tab=members).
El core team:
- [Eddie Ruvalcaba](https://github.com/eddie-ruva)
- [Juan Pablo Escobar](https://github.com/juanpabloe)
- [Abraham Kuri](https://github.com/kurenn)
- [Noé Domínguez](https://github.com/poguez)
- [Abi Sosa](https://github.com/abisosa)
- [Miguel Morán](https://github.com/mikesaurio)

### Licencia

Creado por [Codeando México](https://github.com/CodeandoMexico?tab=members), 2013 - 2015.
Disponible bajo la licencia GNU Affero General Public License (AGPL) v3.0. Ver el documento [LICENSE](/LICENSE) para más información.
