function gfr() {
    git fetch --all -p
    git checkout master
    git reset --hard origin/master
}

function gfp() {
    git fetch --all -p
}

function grh() {
    git reset --hard
}

function gcx() {
    git clean -xfd
}

function gacp() {
    git add -A . ; git commit --fixup HEAD; git push
}

function gbn($branch) { git checkout -b $branch }
function gb($branch) { git checkout $branch }
function gbd($branch) { git branch -D $branch }
function gpod($branch) { git push origin :$branch }

Set-PSReadLineKeyHandler -Chord UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord DownArrow -Function HistorySearchForward

