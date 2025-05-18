# Using MDT to configure a Google Coral Dev Board

## Install tool on workstation

If you don't have pip (using distro with Python 3.9?):

```bash
curl -sS https://bootstrap.pypa.io/get-pip.py | sudo python3
```

Install the mendel-development-tool using pip:

```bash
sudo pip install mendel-development-tool
```

## Configure Device

List devices:

```bash
$ mdt devices
silly-dog               (192.168.100.2)
```

Start a Shell:

```bash
mdt shell
```

### Commands in the MDT shell

Setup Internet using the TUI:

```bash
nmtui
```

From the command line:

```bash
nmcli dev wifi connect <NETWORK_NAME> password "<PASSWORD>" ifname wlan0
```
