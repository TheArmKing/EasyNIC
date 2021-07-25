# EasyNIC
An easier way of initialising tweaks with the Default NIC in theos. (iOS/Mac)

# What's the use?
Calling the script is easy - `EasyNIC.sh` instead of `$(THEOS)/bin/nicify.pl` and it makes projects a bit easier to initialize. It follows these steps:
1. List all the templates in `$(THEOS)/templates` based on filenames.
2. Ask for the project name
3. Ask for username
4. Ask for input where the user can type their own packageID or leave it blank to use the suitable packageID derived from the project and user names provided. (In the normal NIC, the packageID is asked first, which means typing your name out twice!)
</a>
It also includes an Exit option in case you call it accidentally (I'm not sure if the Ctrl+C functionality is available on iOS consoles)

# Automatic Username Detection
On iOS, the default name is 'System Administrator' and sometimes your system name might not be the same as what you publish your tweaks with. Therefore, the tool has a feature where it can read a custom username you provide on disk. This can be done by making a file with path `/var/mobile/Documents/EasyNIC.txt` on iOS or `/Users/username/Documents/EasyNIC.txt` on MacOS where the first line containes the custom username. The tool will automatically fetch it for you.\
\
If none of the files exist then it uses what's provided by the system, just like in NIC.pl

# Changelog
v1.02
- The main selection menu now includes an exit option

v1.01
- Capital letters are replaced with lowercase instead of being removed (from packageID)

v1.00
- Initial Release
