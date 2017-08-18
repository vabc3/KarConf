export PATH="$HOME/git.kube/k8r/run:$PATH"

hash -d k8r=~/git.kube/k8r
hash -d spec=~/git.kube/spec
hash -d k8s="$GOPATH/src/k8s.io/kubernetes"
hash -d k8s.devutil="$GOPATH/src/karatal.visualstudio.com/k8s.test/_git/k8s.devutil"
hash -d AcsEngine="$GOPATH/src/github.com/Azure/acs-engine"

func _kubectl() {
	NS=${K_NS:-default}
	CMD="kubectl --namespace=$NS $@"
	echo $CMD
	eval $CMD
}

func _kubectl_exec_sh() { _kubectl exec -ti $1 sh }
func _docker_run_sh()	{ docker run 	-ti $1 sh }
func _docker_exec_sh()	{ docker exec 	-ti $1 sh }

alias k='_kubectl'
alias kc='k config'
alias kcc='kc current-context'
alias kcu='kc use-context'
alias ko='k -o wide'
alias kg='ko get'
alias kp='kg pods'
alias ks='kg svc'
alias kexe='k exec -ti'
alias kd='k describe'
alias ke='k delete'
alias kv='k version'
alias kcf='k create -f'
alias kaf='k apply -f'
alias kep='ke pods'
alias kdp='kd pods'
alias kex='_kubectl_exec_sh'
alias dr='_docker_run_sh'
alias de='_docker_exec_sh'

alias kpl='k8r profile'
alias kpu='k8r profile -cuse='
alias kel='k8r profileE2E'

#source <(~/sh/kubectl completion zsh)

#DEFAULT_E2EPROFILE=~/workspace/_artifacts.k8r/last/e2e.env\
DEFAULT_E2EPROFILE=~/.k8r_profile_e2e
if [ -e $DEFAULT_E2EPROFILE ]; then
	source $DEFAULT_E2EPROFILE
fi
