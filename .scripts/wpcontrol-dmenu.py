import subprocess
import re

DMENU_COMMAND = "fuzzel --dmenu"

def promptDmenu(prompt, items):
    output = subprocess.run(f"echo '{items}' | {DMENU_COMMAND} --prompt='{prompt} '", shell=True, encoding='utf-8', stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if (output.returncode != 0):
        return None
    return output.stdout

def getActive():
    output = subprocess.getoutput("wpctl status -k")
    activePattern = re.compile(r"\*\s+(\d+)\.")
    activeArray = activePattern.findall(output)
    return activeArray

def parse(fromSection, toSection):
    output = subprocess.getoutput("wpctl status -k")
    linesPattern = re.compile(r"(?s)(?<=" + fromSection + ").*?(?=" + toSection + ")", re.MULTILINE)
    linesMatch = linesPattern.findall(output)[0]
    itemsPattern = re.compile(r"\w\d{1,}.+?(?=\[)")
    itemsMatch = itemsPattern.findall(linesMatch)
    itemsMatch = [item.strip() for item in itemsMatch]
    actice = getActive()
    items = {}
    for item in itemsMatch:
        number = item.split(" ")[0].replace(".", "")
        name = " ".join(item.split(" ")[1:])
        if (number in actice):
            name = f"* {name} *"
        items[number] = name
    return items

def setSink():
    sinks = parse("Sinks", "Sources")
    items = ""
    line = ""
    for i in sinks:
        line = f"{i}. {sinks[i]}\n"
        items += line
    selected = str(promptDmenu("Sink:", items.strip()))
    number = re.findall(r"\d{1,}", selected)
    if (len(number) > 0):
        number = number[0]
        subprocess.run(f"wpctl set-default {number}", shell=True)
    return None

def setSource():
    sources = parse("Sources", "Filters")
    items = ""
    line = ""
    for i in sources:
        line = f"{i}. {sources[i]}\n"
        items += line
    selected = str(promptDmenu("Source:", items.strip()))
    number = re.findall(r"\d{1,}", selected)
    if (len(number) > 0):
        number = number[0]
        subprocess.run(f"wpctl set-default {number}", shell=True)
    return None

def clearDefault():
    subprocess.run("wpctl clear-default", shell=True)
    return None

def main():
    options = "\n".join([
        "Output Device",
        "Input Device",
        "",
        "Toggle Mute",
        "Clear Default"
    ])
    selected = str(promptDmenu("Audio:", options)).strip()
    if (selected == "Output Device"):
        setSink()
    elif (selected == "Input Device"):
        setSource()
    if (selected == "Toggle Mute"):
        subprocess.run("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", shell=True)
    elif (selected == "Clear Default"):
        clearDefault()
    return None

main()
