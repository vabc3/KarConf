func _docker_run_sh()	{ docker run 	-ti $1 -- sh }
func _docker_exec_sh()	{ docker exec 	-ti $1 -- sh }

alias k='kubectl -n $K_NS'
alias ko='k -o wide'
alias kg='ko get'
alias kp='kg pods'
alias ks='kg svc'
alias kexe='k exec -ti'
alias kd='k describe'
alias ke='k edit'
alias kde='k delete'
alias kv='k version'
alias kcf='k create -f'
alias kaf='k apply -f'
alias kep='kde pods'
alias kdp='kd pods'
alias kex='_kubectl_exec_sh'
alias dr='_docker_run_sh'
alias de='_docker_exec_sh'

func _kubectl_exec_sh() { k exec -ti $1 -- sh }

export K_NS=default
source <(kubectl completion zsh)
