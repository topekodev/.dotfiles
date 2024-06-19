import subprocess
import re

DMENU_COMMAND = "fuzzel --dmenu"

def runCommand(command, notify=False, notifyPre="", notifyTimeout=3000):
    if (notifyPre != ""):
        subprocess.run(f"notify-send -t {notifyTimeout} 'Bluetooth' '{notifyPre}'", shell=True)
    result = subprocess.run(command, shell=True, encoding='utf-8', stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if (notify):
        lastLine = result.stdout.splitlines()[-1]
        subprocess.run(f"notify-send -t 3000 'Bluetooth' '{lastLine}'", shell=True)
    return None

def promptDmenu(prompt, items):
    output = subprocess.run(f"echo '{items}' | {DMENU_COMMAND} --prompt='{prompt} '", shell=True, encoding='utf-8', stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if (output.returncode != 0):
        return None
    return output.stdout

def getDevice():
    connectedDevices = re.findall(r'(?s)(?<=Device ).*?(?= )', subprocess.getoutput("bluetoothctl devices Connected"))
    pairedDevices = re.findall(r'(?s)(?<=Device ).*?(?= )', subprocess.getoutput("bluetoothctl devices Paired"))
    trustedDevices = re.findall(r'(?s)(?<=Device ).*?(?= )', subprocess.getoutput("bluetoothctl devices Trusted"))
    output = subprocess.getoutput("bluetoothctl devices")
    devices = re.split(r'\n', output)
    devices = [re.sub(r'^\w+\s', '', device) for device in devices]
    devices = [re.sub(r'\s', ';', device, 1) for device in devices]
    devices = [dict(zip(['mac', 'name'], device.split(';'))) for device in devices]
    bluetooth = ""
    line = ""
    for i in devices:
        if (i['mac'] in connectedDevices):
            line = f"* {i['name']} ({i['mac']}) *"
        else:
            line = f"{i['name']} ({i['mac']})"
        if(i['mac'] in pairedDevices):
            line += " -p"
        if(i['mac'] in trustedDevices):
            line += " -t"
        line += "\n"
        bluetooth += line
    selected = str(promptDmenu("Select:", bluetooth.strip()))
    return selected.strip()

def connectBluetooth(mac):
    connectedDevices = re.findall(r'(?s)(?<=Device ).*?(?= )', subprocess.getoutput("bluetoothctl devices Connected"))
    pairedDevices = re.findall(r'(?s)(?<=Device ).*?(?= )', subprocess.getoutput("bluetoothctl devices Paired"))
    trustedDevices = re.findall(r'(?s)(?<=Device ).*?(?= )', subprocess.getoutput("bluetoothctl devices Trusted"))
    if (mac in connectedDevices):
        runCommand(f"bluetoothctl disconnect {mac}", True, "Disconnecting")
    else:
        if ((mac not in pairedDevices) and (mac not in trustedDevices)):
            runCommand("bluetoothctl agent on")
            runCommand("bluetoothctl default-agent")
            runCommand(f"bluetoothctl pair {mac}", True)
            runCommand(f"bluetoothctl trust {mac}", True)
            runCommand("bluetoothctl scan off")
            runCommand("bluetoothctl agent off")

        runCommand(f"bluetoothctl connect {mac}", True, "Connecting to device")
    return None

def deleteDevice(mac):
    connectedDevices = re.findall(r'(?s)(?<=Device ).*?(?= )', subprocess.getoutput("bluetoothctl devices Connected"))
    if (mac in connectedDevices):
        runCommand(f"bluetoothctl disconnect {mac}")
    runCommand(f"bluetoothctl remove {mac}", True)
    return None

def scanDevices():
    runCommand("bluetoothctl --timeout 10 scan on", False, "Scanning devices", 10000)
    return None

def main():
    options = "\n".join([
        "Choose Device",
        "Scan Devices",
        "Delete Device",
        "",
        "Enable Bluetooth",
        "Disable Bluetooth"
    ])
    
    selected = str(promptDmenu("Bluetooth:", options)).strip()
    if (selected == "Choose Device"):
        device = getDevice()
        if (device != "None"):
            device = re.findall(r'\(([^)]+)', device)[0]
            connectBluetooth(device)
    elif (selected == "Scan Devices"):
        scanDevices()
    elif (selected == "Delete Device"):
        device = getDevice()
        if (device != "None"):
            device = re.findall(r'\(([^)]+)', device)[0]
            deleteDevice(device)
    elif (selected == "Enable Bluetooth"):
        subprocess.run("bluetoothctl power on", shell=True)
    elif (selected == "Disable Bluetooth"):
        subprocess.run("bluetoothctl power off", shell=True)
    return None

main()
