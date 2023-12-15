# git
$git_prefix="$env:username" + "/"

function ga() {git add -A .}
function gacp() {ga;git commit --fixup HEAD;git push}
function gb() {git checkout}
function gcx() {git clean -xfd}
function gd() {git diff}
function gfp() {git fetch -p --all}
function gfr() {gfp;gm1;git reset --hard origin/master}
function gl() {git log --graph --full-history --all --pretty=format:"%h%x09%d%x20%s"}
function gm1() {git checkout master}
function gmm() {git commit --amend --no-edit}
function gmt() {git commit -m "tmp"}
function gr() {git reflog}
function grc() {grh; gcx}
function grh() {git reset --hard}
function gs() {git status}
function gv() {gitk --all}

function gbn($branch) { git checkout -b $git_prefix$branch }
function gb($branch) { git checkout $git_prefix$branch }
function gbd($branch) { git branch -D $git_prefix$branch }
function gpod($branch) { git push origin :$git_prefix$branch }

# history
Set-PSReadLineKeyHandler -Chord UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord DownArrow -Function HistorySearchForward

