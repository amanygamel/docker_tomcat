# Use the official Microsoft Windows Server Core base image
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Set up PowerShell for further commands
SHELL ["powershell", "-Command"]

# Update and install Python 3 using Chocolatey package manager
RUN Set-ExecutionPolicy Bypass -Scope Process; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); \
    choco install -y python3

# Set the default command to python3
CMD ["python"]
