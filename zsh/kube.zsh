alias de='_docker_exec_sh'
alias dr='_docker_run_sh'
alias k='kubectl -n $K_NS'
alias kk='echo $KUBECONFIG - $K_NS'
alias kaf='k apply -f'
alias kcf='k create -f'
alias kci='k cluster-info'
alias kd='k describe'
alias kde='k delete'
alias kdp='kd pods'
alias ke='k edit'
alias kep='kde pods'
alias kex='_kubectl_exec_sh'
alias kg='k get'
alias kgn='kg nodes'
alias kl='k logs'
alias kns='kn kube-system'
alias kp='kg pods'
alias ks='kg svc'
alias kv='k version'
export K_NS="${K_NS-default}"
func _docker_exec_sh()	{ docker exec 	-ti $1 -- bash }
func _docker_run_sh()	{ docker run 	-ti $1 -- sh }
func _kubectl_exec_sh() { k exec -ti $1 -- bash }
func kc() { KUBECONFIG=$1 }
func kdnss() { kubectl get ns -o name |grep $1 | xargs kubectl delete --wait=false }
func kn() { K_NS=$1 }
source <(kubectl completion zsh)
