# RustDesk Deployment

We needed a self-hosted remote access solution for 100+ club workstations. Commercial tools were either too expensive at scale or didn't support unattended access the way we needed. RustDesk gave us a self-hosted alternative with full control over the relay server.

## What This Script Does

`Deploy-RustDesk.ps1` silently configures RustDesk on a workstation to connect to your self-hosted relay server. It installs the service, writes the config file with your server details and access permissions, sets the unattended password, and restarts the service. Returns the RustDesk ID for inventory tracking.

## Usage

```powershell
.\Deploy-RustDesk.ps1 -ServerHost "rustdesk.yourdomain.com" -ServerKey "your-server-public-key" -Password "your-unattended-password"
```

Designed to be pushed via RMM or GPO to workstations that already have the RustDesk client installed.

## What It Configures

- Points the client at your self-hosted relay server
- Sets permanent unattended password
- Enables: keyboard, clipboard, file transfer, terminal, remote printer, audio, tunnel, remote restart, session recording, input blocking, remote config modification

## Requirements

- RustDesk client already installed on the target workstation
- PowerShell 5.1+
- Run as administrator
- Your self-hosted RustDesk server hostname and public key

## Blog Post

[Self-Hosted Remote Access at Scale: Deploying RustDesk to 100+ Locations](https://blog.soarsystems.cc/rustdesk-deployment)
