# **INCEPTION**

*This project has been created as part of the 42 curriculum by pbret.*

## **PROJECT DESCRIPTION**

Inception is about building a small web infrastructure made of three services,
each running in its own Docker container, orchestrated by Docker Compose.
Each container is built on the Debian operating system (without its kernel).

    1. NGINX     -> the web server
    2. WORDPRESS -> the CMS (Content Management System), run via PHP-FPM (FastCGI Process Manager)
    3. MARIADB   -> the database

## **CONCEPTS**

### **Virtual machine VS Docker container**

**Virtual machine**  
A virtual machine emulates a complete computer. Through a hypervisor (VBox,
UTM), it runs its own full operating system with its own kernel. Each VM
therefore embeds an entire OS.

**Docker container**  
A Docker container is a way to isolate an application (service) and everything
it needs to run (dependencies), without having to embed a complete operating
system.  
When building a container, the system files are indeed installed: the programs,
the commands (apt, bash...), the libraries. But the kernel is not installed.
The container directly uses the kernel of the host machine, which it shares
with all the other containers and with the host itself.

| Criterion | Virtual machine | Docker container |
|---|---|---|
| Kernel | its own (full OS) | shared with the host |
| Weight | heavy (several GB) | light (a few MB) |
| Startup | slow | almost instant |
| Allocated resources | high | low |
| Isolation | very strong | weaker |
| OS choice | any | same kernel as the host |
| Portability | heavy to move | light image, easy to share |

### **Managing the .env file**  
The .env file gathers the project's environment variables, in particular
sensitive data. It is located at the root of the project and added to
.gitignore for security. Docker Compose, through the `env_file` directive,
injects them into the containers.

### **Docker networks**  

Docker offers two network modes:

- *Host network*: the container shares its ports directly with the host's.
  No isolation.
- *Docker network (bridge)*: Docker creates a private virtual network in which
  the containers are isolated. They communicate with each other by their
  service name, while remaining invisible from the outside.  
  
![Docker network diagram](schema.jpg)

### **Docker volumes**  

A container is ephemeral. Everything it contains disappears when it is removed.
For a database like MariaDB, this would be a major problem: every rebuild of
the container would erase all the data.  
Volumes solve this by storing the data **outside** the container, directly on
the host machine. This way, the data survives the stop, the removal and the
rebuild of the container.  
This is called **persistence**.

**Data persistence**  
There are two ways to handle data persistence:  

- **Docker volume**: Docker manages the storage itself, in its own directory
  on the host.  

- **Bind mount**: you link a specific directory of the host to a specific
  directory in the container. A bit like a symbolic link, although it is not
  exactly the same thing.  

| | Docker volume | Bind mount |
|---|---|---|
| **Location** | managed by Docker | chosen by the user |
| **Advantage** | simple, automatic, portable | direct access to the data, control over the location |
| **Drawback** | data less accessible | depends on the host path, the directory must exist |

Volumes are defined in the `docker-compose.yml` file.

### **PHP-FPM**

NGINX cannot execute PHP itself: it delegates this task to **PHP-FPM** (PHP
FastCGI Process Manager).  
PHP-FPM is a service that permanently maintains a pool of PHP processes ready
to work. When NGINX receives a PHP request, it forwards it to PHP-FPM through
the FastCGI protocol (on port 9000). PHP-FPM then executes the code, queries
MariaDB if needed, and returns the generated HTML to NGINX, which passes it on
to the browser.

## INSTRUCTIONS

### Prerequisites

- Docker and Docker Compose
- Add the domain to the `/etc/hosts` file of the host machine: `127.0.0.1   pbret.42.fr`
- The following folders must exist on the host (they hold the volumes and the
  `.env` file):  
*/home/pbret/data/mariadb*  
*/home/pbret/data/wordpress*  
*/home/pbret/data/.env*  


The `.env` file (database credentials, WordPress accounts, domain) is stored in
`/home/pbret/data/` and excluded from the repository via `.gitignore`.  
The Makefile automatically copies it into `srcs/` at startup.

### Installation and launch

- git clone <repository_url>
- cd inception
- make

The `make` command copies the `.env` into `srcs/`, builds the images and starts
the three containers.

### Available Makefile commands

| Command      | Action                                                     |
|--------------|------------------------------------------------------------|
| `make`       | Copies the `.env`, builds the images and starts containers |
| `make down`  | Stops and removes the containers and the network           |
| `make stop`  | Stops the containers without removing them                 |
| `make start` | Restarts stopped containers                                |
| `make re`    | Rebuilds everything (`down` then `up`)                     |
| `make clean` | Stops everything, prunes Docker and removes volumes/data   |

### Access

Once the containers are running, open a browser and go to: https://pbret.42.fr

The WordPress administration dashboard is available at: https://pbret.42.fr/wp-admin

A security warning appears because the SSL certificate is self-signed.  
This is normal -> you have to accept it to access the site.

## RESOURCES

- Inception tutorial — https://tuto.grademe.fr/inception/
- YouTube playlist on Inception — https://www.youtube.com/watch?v=EfIed-cFms4&list=PLpLG--nxBMd-wO_MAWh3gzqCcFh4qNMvP
- Explanatory YouTube video — https://www.youtube.com/watch?v=mspEJzb8LC4
- Official Docker documentation — https://docs.docker.com/
- AI was used as a learning and support tool throughout the project, in particular to:  
    *Understand the concepts*  
    *Review and explain the configuration files*  
    *Debug errors*  
    *Review the Dockerfiles, the docker-compose and the Makefile*  
- The help of my friend **Paul `phautena`**: he guided me throughout my project. A true gem of a guy. https://profile.intra.42.fr/users/phautena
