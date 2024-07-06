# Use the official Microsoft Windows Server Core base image
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Set up PowerShell for further commands
SHELL ["powershell", "-Command"]

# Install Chocolatey package manager
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; `
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install OpenJDK 11 using Chocolatey
RUN choco install -y openjdk11

# Set JAVA_HOME environment variable
ENV JAVA_HOME C:\Program Files\OpenJDK\openjdk-11.0.2

# Download and install Apache Tomcat
RUN $tomcatVersion = '9.
