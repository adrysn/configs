NEUMANN=0
BACKENDAI=0
CONSOLE=0
MANAGERHUB=0
LDCCAI=0
KMU=0
CLOUD=0

for i in "$@" ; do
    if [[ $i == "all" ]] ; then
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
    elif [[ $i == "ldcc" || $i == "lddcai" ]] ; then
        LDCCAI=1
    elif [[ $i == "kmu" || $i == "kmu-bigdata" ]] ; then
        KMU=1
    elif [[ $i == "cloud" ]] ; then
        CLOUD=1
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
            tmux send-keys -t 'backendai:3' 'source set_config.sh superadmin' Enter
        tmux new-window -d -n client-admin -c ~/Develop/backend.ai/backend.ai-dev/client-py
            tmux send-keys -t 'backendai:4' 'cd .' Enter
            tmux send-keys -t 'backendai:4' 'source set_config.sh admin' Enter
        tmux new-window -d -n client-user -c ~/Develop/backend.ai/backend.ai-dev/client-py
            tmux send-keys -t 'backendai:5' 'cd .' Enter
            tmux send-keys -t 'backendai:5' 'source set_config.sh user' Enter
        tmux new-window -d -n dbshell -c ~/Develop/backend.ai/backend.ai-dev/manager
            tmux send-keys -t 'backendai:6' 'cd .' Enter
            tmux send-keys -t 'backendai:6' 'python -m ai.backend.manager.cli dbshell'
fi

# console
if [[ $CONSOLE == 1 ]] ; then
    tmux new-session -d -s console -n app -c ~/Develop/backend.ai/backend.ai-dev/console
        tmux send-keys -t 'console:app' 'nvm use 12.17 ; npm run server:d' Enter
        tmux new-window -d -n tscompile -c ~/Develop/backend.ai/backend.ai-dev/console
            tmux send-keys -t 'console:tscompile' 'nvm use 12.17 ; npm run build:d' Enter
        tmux new-window -d -n proxy -c ~/Develop/backend.ai/backend.ai-dev/console
            tmux send-keys -t 'console:proxy' 'nvm use 12.17 ; make proxy' Enter
        tmux new-window -d -n console-server -c ~/Develop/backend.ai/backend.ai-dev/console-server
            tmux send-keys -t 'console:console-server' 'cd .' Enter
            tmux send-keys -t 'console:console-server' 'python -m ai.backend.console.server' Enter
fi

# manager-hub
if [[ $MANAGERHUB == 1 ]] ; then
    tmux new-session -d -s managerhub -n docker-compose -c ~/Develop/backend.ai/backend.ai-dev/manager-hub
        tmux send-keys -t 'managerhub:docker-compose' 'make up' Enter
        tmux new-window -d -n vim
fi

# ldccai
if [[ $LDCCAI == 1 ]] ; then
    tmux new-session -d -s ldccai -n manager
        tmux send-keys -t 'ldccai:manager' 'ssh ldccai@10.231.238.212' Enter
        tmux new-window -d -n console-server
            tmux send-keys -t 'ldccai:console-server' 'ssh ldccai@10.231.238.211' Enter
        tmux new-window -d -n halfstack
            tmux send-keys -t 'ldccai:halfstack' 'ssh ldccai@10.231.238.213' Enter
        tmux new-window -d -n wsproxy
            tmux send-keys -t 'ldccai:wsproxy' 'ssh ldccai@10.231.238.214' Enter
        tmux new-window -d -n nginx
            tmux send-keys -t 'ldccai:nginx' 'ssh ldccai@210.93.145.6' Enter
        tmux new-window -d -n ai1-v100
            tmux send-keys -t 'ldccai:ai1-v100' 'ssh ldccai@10.231.238.31' Enter
        tmux new-window -d -n ai2-v100
            tmux send-keys -t 'ldccai:ai2-v100' 'ssh ldccai@10.231.238.32' Enter
        tmux new-window -d -n ai3-v100
            tmux send-keys -t 'ldccai:ai3-v100' 'ssh ldccai@10.231.238.33' Enter
        tmux new-window -d -n ai4-v100
            tmux send-keys -t 'ldccai:ai4-v100' 'ssh ldccai@10.231.238.34' Enter
        tmux new-window -d -n ai5-1080ti
            tmux send-keys -t 'ldccai:ai5-1080ti' 'ssh ldccai@10.231.238.41' Enter
        tmux new-window -d -n ai6-1080ti
            tmux send-keys -t 'ldccai:ai6-1080ti' 'ssh ldccai@10.231.238.42' Enter
        tmux new-window -d -n ai7-1080ti
            tmux send-keys -t 'ldccai:ai7-1080tij' 'ssh ldccai@10.231.238.43' Enter
fi

# kmu-bigdata
if [[ $KMU == 1 ]] ; then
    tmux new-session -d -s kmubigdata -n kmu01
        tmux send-keys -t 'kmubigdata:kmu01' 'ssh -p 2222 kookmin@node01.kmu-bigdata.onpremise.backend.ai' Enter
        tmux new-window -d -n kmu02
            tmux send-keys -t 'kmubigdata:kmu02' 'ssh -p 2222 kookmin@node02.kmu-bigdata.onpremise.backend.ai' Enter
        tmux new-window -d -n kmu03
            tmux send-keys -t 'kmubigdata:kmu03' 'ssh -p 2222 kookmin@node03.kmu-bigdata.onpremise.backend.ai' Enter
        tmux new-window -d -n kmu04
            tmux send-keys -t 'kmubigdata:kmu04' 'ssh -p 2222 kookmin@node04.kmu-bigdata.onpremise.backend.ai' Enter
fi

# cloud
if [[ $CLOUD == 1 ]] ; then
    tmux new-session -d -s cloud -n manager
        tmux send-keys -t 'cloud:manager' \
	    'bai-cloud ssh-instance cloud-190727-bai-manager' Enter \
	    'ubuntu.sh' Enter \
	    'cd' Enter
        tmux new-window -d -n console-server
            tmux send-keys -t 'cloud:console-server' \
		'bai-cloud ssh-instance cloud-190727-bai-console-server' Enter \
		'devops.sh' Enter \
		'cd' Enter
        tmux new-window -d -n baryonyx
            tmux send-keys -t 'cloud:baryonyx' \
		'bai-cloud ssh-instance baryonyx' Enter \
		'devops.sh' Enter \
		'cd' Enter
        tmux new-window -d -n tarbo
            tmux send-keys -t 'cloud:tarbo' \
		'bai-cloud ssh-instance tarbo' Enter \
		'devops.sh' Enter \
		'cd' Enter
        tmux new-window -d -n hydra01
            tmux send-keys -t 'cloud:hydra01' \
		'bai-cloud ssh-instance hydra01' Enter \
		'devops.sh' Enter \
		'cd' Enter
        tmux new-window -d -n hydra02
            tmux send-keys -t 'cloud:hydra02' \
		'bai-cloud ssh-instance hydra02' Enter \
		'devops.sh' Enter \
		'cd' Enter
fi
