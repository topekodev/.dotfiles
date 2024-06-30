import subprocess
import re

DMENU_COMMAND = "fuzzel --dmenu"

def promptDmenu(prompt, items):
    output = subprocess.run(f"echo '{items}' | {DMENU_COMMAND} --prompt='{prompt} '", shell=True, encoding='utf-8', stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if (output.returncode != 0):
        return None
    return output.stdout

def promptPassword():
    output = subprocess.run(f"{DMENU_COMMAND} --password --prompt='Password: '", shell=True, encoding='utf-8', stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    return output.stdout.strip()

def newWifi():
    subprocess.run("notify-send -t 1000 'Scanning Wifi'", shell=True)
    output = subprocess.getoutput("nmcli device wifi list")
    networks = re.split(r'\n', output)[1:]
    networks = [re.sub(r'\s{2,}', ';', network) for network in networks]
    networks = [dict(zip(['in-use', 'bssid', 'ssid', 'mode', 'chan', 'rate', 'signal', 'bars', 'security'], network.split(';'))) for network in networks]
    wifi = ""
    line = ""
    for i in networks:
        line = f"{i['ssid']}\n"
        wifi += line
    selected = str(promptDmenu("Wi-Fi:", wifi.strip()))
    return selected.strip()

def savedWifi():
    output = subprocess.getoutput("nmcli connection show")
    networks = re.split(r'\n', output)[1:]
    networks = [re.sub(r'\s{2,}', ';', network) for network in networks]
    networks = [dict(zip(['name', 'uuid', 'type', 'device'], network.split(';'))) for network in networks]
    wifi = ""
    line = ""
    for i in networks:
        if(i['type'] == "wifi"):
            if(i['device'] != "--"):
                line = f"* {i['name']} *\n"
            else:
                line = f"{i['name']}\n"
            wifi += line
    selected = str(promptDmenu("Wi-Fi:", wifi.strip()))
    return selected.replace("*", "").strip()

def connectWifi(ssid, password=""):
    subprocess.run(f"notify-send -t 1000 'Connecting' '{ssid}'", shell=True)
    if (password != ""):
        result = subprocess.run(f"nmcli device wifi connect '{ssid}' password {password}", shell=True)
    else:
        result = subprocess.run(f"nmcli device wifi connect '{ssid}'", shell=True, encoding='utf-8', stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if (result.returncode == 0):
        subprocess.run(f"notify-send -t 3000 Connected '{ssid}'", shell=True)
    else:
        subprocess.run(f"notify-send -t 3000 'Error connecting'", shell=True)
    return None

def deleteConnection(ssid):
    subprocess.run(f"notify-send -t 1000 'Deleting {ssid}'", shell=True)
    subprocess.run(f"nmcli connection delete '{ssid}'", shell=True)
    return None

def main():
    options = "\n".join([
        "Choose Network",
        "New Connection",
        "Delete Connection",
        "",
        "Enable Wifi",
        "Disable Wifi",
        "Connection Manager"
    ])
    
    selected = str(promptDmenu("Network:", options)).strip()
    if (selected == "Choose Network"):
        network = savedWifi()
        if (network != "None"):
            connectWifi(network)
    elif (selected == "New Connection"):
        network = newWifi()
        if (network != "None"):
            password = promptPassword()
            connectWifi(network, password)
    elif (selected == "Delete Connection"):
        network = savedWifi()
        if (network != "None"):
            deleteConnection(network)
    elif (selected == "Enable Wifi"):
        subprocess.run("nmcli radio wifi on", shell=True)
    elif (selected == "Disable Wifi"):
        subprocess.run("nmcli radio wifi off", shell=True)
    elif (selected == "Connection Manager"):
        subprocess.run("nm-connection-editor", shell=True)
    return None

main()
