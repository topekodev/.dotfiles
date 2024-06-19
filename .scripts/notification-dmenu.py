import subprocess
import json

DMENU_COMMAND = "fuzzel --dmenu"

def promptDmenu(prompt, items):
    output = subprocess.run(f"echo '{items}' | {DMENU_COMMAND} --prompt='{prompt} '", shell=True, encoding='utf-8', stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if (output.returncode != 0):
        return None
    return output.stdout


def getNotification():
    output = subprocess.getoutput("dunstctl history")
    history = json.loads(output)
    history = history['data'][0]
    notifications = ""
    summary = ""
    for i in history:
        summary = i['summary']['data']
        id = i['id']['data']
        notifications += "(" + str(id) + ") " + summary + "\n"
    selected = str(promptDmenu("History:", notifications.strip())).split("(")[1].split(")")[0].strip()
    return selected

def main():
    options = "\n".join([
        "Show History",
        "Do Not Disturb",
    ])
    
    selected = str(promptDmenu("Notifications:", options)).strip()
    if (selected == "Show History"):
        notification = getNotification()
        if (notification != "None"):
            subprocess.run(f"dunstctl history-pop {notification}", shell=True)
    elif (selected == "Do Not Disturb"):
        subprocess.run("dunstctl set-paused toggle", shell=True)
    return None

main()
