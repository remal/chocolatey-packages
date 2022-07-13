gpgconf --kill gpg-agent

del /Q /F "%APPDATA%\gnupg\*.lock"

gpg-connect-agent reloadagent /bye
