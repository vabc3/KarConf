export PATH="$HOME/git.kube/k8r/run:$PATH"
hash -d kube=~/go1/src/k8s.io/kubernetes
hash -d k8s.devutil=~/go1/src/karatal.visualstudio.com/k8s.test/_git/k8s.devutil

hash -d k8r=~/git.kube/k8r
hash -d spec=~/git.kube/spec

alias k='kubectl'
alias kc='k config'
alias kcc='kc current-context'
alias kcu='kc use-context'
alias ko='k -o wide'
alias kg='ko get'
alias kp='kg pods'
alias ks='kg svc'
alias kexe='kubectl exec -ti'
alias kd='kubectl describe'
alias ke='kubectl delete'
alias kv='kubectl version'
alias kcf='kubectl create -f'
alias kep='ke pods'
alias kdp='kd pods'

alias kpl='k8r profile'
alias kpu='k8r profile -cuse='
