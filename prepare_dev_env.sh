NEUMANN=0
BACKENDAI=0
CONSOLE=0
MANAGERHUB=0

for i in "$@" ; do
    if [[ $i == "all" ]] ; then
        NEUMANN=1
        BACKENDAI=1
        CONSOLE=1
        MANAGERHUB=1
        break
    elif [[ $i == "neumann" ]] ; then
        NEUMANN=1
    elif [[ $i == "backend.ai" || $i == "backendai" ]] ; then
        BACKENDAI=1
    elif [[ $i == "console" ]] ; then
        CONSOLE=1
    elif [[ $i == "managerhub" || $i == "manager-hub" || $i == "hub" ]] ; then
        MANAGERHUB=1
    fi
done


# neumann
if [[ $NEUMANN == 1 ]] ; then
    tmux new-session -d -s neumann -n docker-compose -c ~/Develop/neumann
        tmux send-keys -t 'neumann:0' 'docker-compose -f docker-compose.dev.yml up' Enter
        # tmux new-window -d -n file-watcher -c ~/Develop/neumann
        #     tmux send-keys -t 'neumann:1' 'cd . ; python watch_and_touch.py' Enter
        tmux new-window -d -n log-uwsgi -c ~/Develop/neumann
            tmux send-keys -t 'neumann:2' 'tail -f logs/uwsgi.log' Enter
        tmux new-window -d -n log-ingen -c ~/Develop/neumann
            tmux send-keys -t 'neumann:3' 'docker exec -it neumann-web supervisorctl tail -f ingen stderr' Enter
        tmux new-window -d -n log-celery-worker -c ~/Develop/neumann
            tmux send-keys -t 'neumann:4' 'docker exec -it neumann-web tail -f /var/log/celery/neumann-worker-stderr.log' Enter
fi

# backend.ai
if [[ $BACKENDAI == 1 ]] ; then
    tmux new-session -d -s backendai -n docker-compose -c ~/Develop/backend.ai
        tmux send-keys -t 'backendai:0' 'docker-compose -f docker-compose.halfstack.yml up' Enter
        tmux new-window -d -n manager -c ~/Develop/backend.ai/backend.ai-dev/manager
            tmux send-keys -t 'backendai:1' 'cd .' Enter
            tmux send-keys -t 'backendai:1' 'python -m ai.backend.gateway.server'
        tmux new-window -d -n agent -c ~/Develop/backend.ai/backend.ai-dev/agent
            tmux send-keys -t 'backendai:2' 'cd .' Enter
            tmux send-keys -t 'backendai:2' 'python -m ai.backend.agent.server'
        tmux new-window -d -n client-superadmin -c ~/Develop/backend.ai/backend.ai-dev/client-py
            tmux send-keys -t 'backendai:3' 'cd .' Enter
            tmux send-keys -t 'backendai:3' 'source set_config.sh superadmin'
        tmux new-window -d -n client-admin -c ~/Develop/backend.ai/backend.ai-dev/client-py
            tmux send-keys -t 'backendai:4' 'cd .' Enter
            tmux send-keys -t 'backendai:4' 'source set_config.sh admin'
        tmux new-window -d -n client-user -c ~/Develop/backend.ai/backend.ai-dev/client-py
            tmux send-keys -t 'backendai:5' 'cd .' Enter
            tmux send-keys -t 'backendai:5' 'source set_config.sh user'
        tmux new-window -d -n dbshell -c ~/Develop/backend.ai/backend.ai-dev/manager
            tmux send-keys -t 'backendai:6' 'cd .' Enter
            tmux send-keys -t 'backendai:6' 'python -m ai.backend.manager.cli dbshell' Enter
            tmux send-keys -t 'backendai:6' '\c backend' Enter
fi

# console
if [[ $CONSOLE == 1 ]] ; then
    tmux new-session -d -s console -n app -c ~/Develop/backend.ai/backend.ai-dev/console
        tmux send-keys -t 'console:0' 'nvm use 10.15.3 ; make test_web' Enter
        tmux new-window -d -n proxy -c ~/Develop/backend.ai/backend.ai-dev/console
            tmux send-keys -t 'console:1' 'nvm use 10.15.3 ; make proxy' Enter
fi

# manager-hub
if [[ $MANAGERHUB == 1 ]] ; then
    tmux new-session -d -s managerhub -n docker-compose -c ~/Develop/backend.ai/backend.ai-dev/manager-hub
        tmux send-keys -t 'managerhub:0' 'make up' Enter
fi
