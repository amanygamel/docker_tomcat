# Use the official Microsoft Windows Server Core base image
FROM mcr.microsoft.com/windows/servercore:ltsc2019 

# Set up PowerShell for further commands
SHELL ["powershell", "-Command"]

# Install Chocolatey
RUN iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Python 3 using Chocolatey
RUN choco install -y python3

# Set the default command to python3
CMD ["python", "--version"]
