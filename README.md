# Arch Linux PKGBUILDs for GOG Games

This repository provides optimized PKGBUILDs for GOG games on Arch Linux, focusing on **minimal dependencies** and **XDG Base Directory compliance**. Includes a tool to perform dependency analysis. 

The [`xdg-laucher`](https://github.com/hildigerr/xdg-launcher) project originated from this repository. Rather than continuing to make customized launchers for each game to enforce user XDG directory settings, the launcher was extracted into a standalone script that should work for any application. PKGBUILDs within this repository will depend upon it as needed to ensure compliance.

---

## Dependency Analyzer

`depends.hell` is a script to determine minimal runtime dependencies for games by analyzing shared libraries.

#### Features
- Identifies libraries loaded by a running process (`--pid`) or listed in a file (`--file`)
- Distinguishes between packaged libraries (via `pacman`) and local files
- Builds dependency chains with interactive confirmation for circular or otherwise ambiguous cases

#### Usage

    depends.hell --pid <PID> | --file <input_file>

##### Example (Analyze Running Process)

    depends.hell --pid $(pgrep -f game_executable)

##### Example (Analyze Library List)

    depends.hell --file library_list.txt

#### Output

    Local Libraries:
    linux-vdso.so.1
    /opt/some-game/included.so.x
    
    Confirm dependency (lib-one) [y/N]? 
    Confirm dependency (lib-two) [y/N]? 
    Confirm dependency (lib-three) [y/N]? y
    Confirmed Dependencies:
    lib-zero
    lib-three

As dependencies are confirmed, anything else that is included as a dependency of the one confirmed is eliminated. For instance, lets say an game needs four libraries to be installed to run: `lib-zero`, `lib-one`, `lib-two`, and `lib-three`. Further, `lib-three` depends on `lib-two` , and `lib-two` depends on `lib-one`.  If it were as simple as this, the game can just depend upon `lib-zero` and `lib-three`, the script will automatically detect it and won't ask for confirmation. However, in practice--often due to circular dependencies--the user will have to confirm to include the highest level dependency.

---

## Key Features
- **Minimal Dependencies** - PKGBUILDs only include dependence upon essential libraries identified by `depends.hell`
- **XDG Compliance** - Games use `xdg-launch` where needed to prevent home directory pollution
- **Clean Installation** - All files properly organized in standard Linux directories
- **Arch Linux Optimization** - Leverages system libraries instead of bundled versions where possible

