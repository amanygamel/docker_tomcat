# Use the official Microsoft Windows Server Core base image
FROM mcr.microsoft.com/windows/servercore:ltsc2022 AS builder

# Set up PowerShell for further commands
SHELL ["powershell", "-Command"]

# Install Chocolatey
RUN iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Python 3 using Chocolatey
RUN choco install -y python3

# Stage 2: Final image
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Copy Python installation from builder stage
COPY --from=builder /ProgramData/chocolatey /ProgramData/chocolatey

# Set the PATH environment variable to include Python
RUN setx /M PATH "%PATH%;C:\ProgramData\chocolatey\bin"

# Set the default command to python3
CMD ["python", "--version"]
