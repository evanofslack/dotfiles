Set-Alias -Name "alias" -Value Get-Aliases -Description "Lists aliases."

Set-Alias -Name "~" -Value Set-LocationHome -Description "Goes to user home directory."
Set-Alias -Name "cd-" -Value Set-LocationLast -Description "Goes to last used directory."
Set-Alias -Name ".." -Value Set-LocationUp -Description "Goes up a directory."
if (!(Get-Command "ls" -ErrorAction "Ignore")) {
    Set-Alias -Name "ls" -Value Get-ChildItemSimple -Description "Lists visible files in wide format."
}
Set-Alias clear cls
Set-Alias cl cls

Set-Alias gs git status
Set-Alias gs git commit
Set-Alias ga git add 
Set-Alias gp git pull --rebase

Set-Alias dc docker-compose
Set-Alias d docker

Set-Alias vs code .



