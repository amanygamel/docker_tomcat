# Use the official Microsoft Windows Server Core base image
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Set up PowerShell for further commands
SHELL ["powershell", "-Command"]

# Install Chocolatey package manager
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install OpenJDK 11 using Chocolatey
RUN choco install -y openjdk11

# Set JAVA_HOME environment variable
ENV JAVA_HOME "C:\\Program Files\\OpenJDK\\openjdk-11.0.2"

# Download and install Apache Tomcat
RUN $tomcatVersion = '9.0.73'; \
    $tomcatZip = 'apache-tomcat-' + $tomcatVersion + '.zip'; \
    $tomcatUrl = 'https://archive.apache.org/dist/tomcat/tomcat-9/v' + $tomcatVersion + '/bin/' + $tomcatZip; \
    $tomcatInstallDir = 'C:\\tomcat'; \
    Invoke-WebRequest -Uri $tomcatUrl -OutFile $tomcatZip; \
    Expand-Archive -Path $tomcatZip -DestinationPath $tomcatInstallDir -Force; \
    Move-Item -Path (Join-Path $tomcatInstallDir ('apache-tomcat-' + $tomcatVersion + '\*')) -Destination $tomcatInstallDir; \
    Remove-Item -Path $tomcatZip; \
    Remove-Item -Path (Join-Path $tomcatInstallDir ('apache-tomcat-' + $tomcatVersion))

# Expose Tomcat port
EXPOSE 8090

# Set the default command to run Tomcat
CMD ["C:\\tomcat\\bin\\catalina.bat", "run"]
