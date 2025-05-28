import platform

system = platform.system()
machine = platform.machine()


if system == "Windows":
    print("Witaj w systemie Windows!")
elif system == "Linux":
    arch = "ARM" if "ARM" in machine.upper() else "AMD64"
    print(f"Witaj w systemie Linux na architekturze {arch}!")
else:
    print(f"Witaj w systemie {system}!")
