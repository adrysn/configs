if [ -x "$(command -v mvim)" ]; then
    alias vi="mvim -v"
    alias vim="mvim"
fi
[ -x "$(command -v rg)" ] && alias rg="rg --max-columns 200"
[ -x "$(command -v firefox)" ] && alias fx="firefox --new-instance --profile $(mktemp -d)"
alias bai="backend.ai"

# Git
# Most git aliases are turned off in favor of scm_breeze
[ -x "$(command -v hub)"  ] && alias git=hub
# alias g='git'
# alias ga='git add'
# alias gash='git stash'
# alias gashp='git stash pop'
# alias gb='git branch'
# alias gba='git branch --all'
# alias gbD='git branch --delete'
alias gbgone="git branch -vv | grep gone"
alias gbv="git branch -v"
alias gbvv="git branch -vv"
# alias gc='git commit'
# alias gcm='git commit --amend'
# alias gcl='git clone'
# alias gclr='git clone --recurse-submodules'
# alias gco='git checkout'
# alias gd='git diff'
alias gds='git diff --staged'
# alias gf='git fetch'
# alias gfa='git fetch --all'
# alias gFi='git flow init'
# alias gFf='git flow feature'
# alias gFb='git flow bugfix'
# alias gFr='git flow release'
# alias gFh='git flow hotfix'
# alias gFs='git flow support'
# alias gl='git log --graph --pretty=format:''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'' --abbrev-commit'
# alias gla='git log --graph --pretty=format:''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'' --abbrev-commit --branches --remotes' # alias glg='git log --graph --max-count=5'
# alias globurl='noglob urlglobber '
# alias gls='git log --stat --max-count=5'
# alias gm='git merge'
# alias gpl='git pull'
# alias gplr='git pull --rebase'
# alias gps='git push'
# alias gr='git reset'
# alias grm='git rm'
# alias gs='git status'

# Docker
alias dk='docker'
alias dka='docker attach'
alias dkb='docker build'
# alias dkd='docker diff'
# alias dkdf='docker system df'
alias dke='docker exec'
alias dkE='docker exec -it'
# alias dkh='docker history'
alias dki='docker images'
alias dkin='docker inspect'
# alias dkim='docker import'
alias dkk='docker kill'
alias dkl='docker logs'
# alias dkli='docker login'
# alias dklo='docker logout'
alias dkls='docker ps'
alias dklsa='docker ps -a'
# alias dkp='docker pause'
# alias dkP='docker unpause'
alias dkpl='docker pull'
alias dkph='docker push'
alias dkps='docker ps'
alias dkpsa='docker ps -a'
alias dkr='docker run'
alias dkR='docker run -it --rm'
alias dkRe='docker run -it --rm --entrypoint /bin/bash'
# alias dkRM='docker system prune'
alias dkrm='docker rm'
alias dkrmi='docker rmi'
# alias dkrn='docker rename'
alias dks='docker start'
alias dkS='docker restart'
alias dkss='docker stats'
# alias dksv='docker save'
alias dkt='docker tag'
# alias dktop='docker top'
# alias dkup='docker update'
alias dkV='docker volume'
alias dkv='docker version'
# alias dkw='docker wait'
alias dkx='docker stop'

# ## Container (C)
# alias dkC='docker container'
# alias dkCa='docker container attach'
# alias dkCcp='docker container cp'
# alias dkCd='docker container diff'
# alias dkCe='docker container exec'
# alias dkCin='docker container inspect'
# alias dkCk='docker container kill'
# alias dkCl='docker container logs'
# alias dkCls='docker container ls'
# alias dkCp='docker container pause'
# alias dkCpr='docker container prune'
# alias dkCrn='docker container rename'
# alias dkCS='docker container restart'
# alias dkCrm='docker container rm'
# alias dkCr='docker container run'
# alias dkCR='docker container run -it --rm'
# alias dkCRe='docker container run -it --rm --entrypoint /bin/bash'
# alias dkCs='docker container start'
# alias dkCss='docker container stats'
# alias dkCx='docker container stop'
# alias dkCtop='docker container top'
# alias dkCP='docker container unpause'
# alias dkCup='docker container update'
# alias dkCw='docker container wait'

# ## Image (I)
# alias dkI='docker image'
# alias dkIb='docker image build'
# alias dkIh='docker image history'
# alias dkIim='docker image import'
# alias dkIin='docker image inspect'
# alias dkIls='docker image ls'
# alias dkIpr='docker image prune'
# alias dkIpl='docker image pull'
# alias dkIph='docker image push'
# alias dkIrm='docker image rm'
# alias dkIsv='docker image save'
# alias dkIt='docker image tag'

# ## Volume (V)
# alias dkV='docker volume'
# alias dkVin='docker volume inspect'
# alias dkVls='docker volume ls'
# alias dkVpr='docker volume prune'
# alias dkVrm='docker volume rm'

# ## Network (N)
# alias dkN='docker network'
# alias dkNs='docker network connect'
# alias dkNx='docker network disconnect'
# alias dkNin='docker network inspect'
# alias dkNls='docker network ls'
# alias dkNpr='docker network prune'
# alias dkNrm='docker network rm'

# ## System (Y)
# alias dkY='docker system'
# alias dkYdf='docker system df'
# alias dkYpr='docker system prune'

# ## Stack (K)
# alias dkK='docker stack'
# alias dkKls='docker stack ls'
# alias dkKps='docker stack ps'
# alias dkKrm='docker stack rm'

# ## Swarm (W)
# alias dkW='docker swarm'

# ## CleanUp (rm)
# Clean up exited containers (docker < 1.13)
# alias dkrmC='docker rm $(docker ps -qaf status=exited)'
# Clean up dangling images (docker < 1.13)
# alias dkrmI='docker rmi $(docker images -qf dangling=true)'
# Clean up dangling volumes (docker < 1.13)
# alias dkrmV='docker volume rm $(docker volume ls -qf dangling=true)'

# Docker Compose (c)
# alias dkc='docker-compose'
# alias dkcb='docker-compose build'
# alias dkcB='docker-compose build --no-cache'
# alias dkcd='docker-compose down'
# alias dkce='docker-compose exec'
# alias dkck='docker-compose kill'
# alias dkcl='docker-compose logs'
# alias dkcls='docker-compose ps'
# alias dkcp='docker-compose pause'
# alias dkcP='docker-compose unpause'
# alias dkcpl='docker-compose pull'
# alias dkcph='docker-compose push'
# alias dkcps='docker-compose ps'
# alias dkcr='docker-compose run'
# alias dkcR='docker-compose run --rm'
# alias dkcrm='docker-compose rm'
# alias dkcs='docker-compose start'
# alias dkcsc='docker-compose scale'
# alias dkcS='docker-compose restart'
# alias dkcu='docker-compose up'
# alias dkcU='docker-compose up -d'
# alias dkcv='docker-compose version'
# alias dkcx='docker-compose stop'

# Vagrant
alias vg='vagrant'
alias vgst='vagrant status'
alias vgup='vagrant up'
alias vgdt='vagrant destroy'
alias vgssh='vagrant ssh'

# List useful examples for a unix command
function cheat() {
    curl cht.sh/$1
}
