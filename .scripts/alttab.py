import subprocess
import re

DMENU_COMMAND = "fuzzel --dmenu"

def promptDmenu(prompt, items):
    output = subprocess.run(f"echo '{items}' | {DMENU_COMMAND} --prompt='{prompt} '", shell=True, encoding='utf-8', stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if (output.returncode != 0):
        return None
    return output.stdout

def getClients():
    titles = re.findall(r'(?s)(?<=-> ).*?(?=:\n)', subprocess.getoutput("hyprctl clients"))
    clients = ""
    for i in range(len(titles)):
        clients += f"{titles[i]}\n"
    return clients.strip()

def main():
    clients = getClients()
    selected = str(promptDmenu("Window:", clients))
    print(selected)
    subprocess.run(f"hyprctl dispatch focuswindow title:{selected}", shell=True, encoding='utf-8', stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    return None

main()
