## Installing Nerd font
1. Run the powershell script `install-fire-code-windows.ps1`
2. Install lsd in powershell
   1. `webi.bat lsd`
   2. `lsd -lahF`

1. Open vscode settings JSON file, search `terminal font family` and update the font family with `FiraCode Nerd Font`

## Installing in Ubuntu WSL
1. Install lsd in Linux
   1. `curl -sS https://webi.sh/lsd | sh`
   2. `lsd -lahF`

2. `chmod +x install-zsh-starship.sh`
3. `./install-zsh-starship.sh`
4. restart terminal

## Installing in local powershell
1.Install scoop
```powershell
> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
> Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```
2. Install starship
`scoop install starship`

3. Get the profile path
`echo $profile`

4. Add below line to powershell profile
`Invoke-Expression (&starship init powershell)`

5. Create a directory at `cd c\users\$user` by name `.config`
   
6. Copy the TOML file at `cd c\users\$user\.config`

7. Restart the powershell terminal

## Installing in cmd
- install scoop via powershell
- install starship via scoop
- install clink via scoop
- go to C:\Users\Lenovo\AppData\Local\clink
- create file - `starship.lua`
- add below to the lua file
```lua
local io = require('io')
local os = require('os')

clink.prompt.register_filter(function ()
    local handle = io.popen("starship prompt")
    local result = handle:read("*a")
    handle:close()
    clink.prompt.value = result
end, 1)
```
- restart cmd
- it will use the same toml config as powershell and at the same location

## Installing in Git Bash
To open or create a .bashrc file for Git Bash on Windows, follow these steps:

1. Install scoop and starship following the instruction given in powershell section
2. Start Git Bash in terminal
3. Navigate to Your Home Directory: `cd ~` and pressing Enter.
4. Check if .bashrc Exists: To check if .bashrc already exists, type `ls -a` and press Enter. This command lists all files in your directory
5. Create or Open .bashrc: If .bashrc does not exist, you can create it by typing `touch .bashrc` and pressing Enter. 
6. To edit `.bashrc` you can use `nano .bashrc` and pressing Enter.
7. Edit .bashrc and add below line `eval "$(starship init bash)"`
8. To apply the changes you made to the .bashrc file, you can either restart Git Bash or type source ~/.bashrc in the Git Bash terminal.

