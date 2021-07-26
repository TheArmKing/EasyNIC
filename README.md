# EasyNIC
An easier way of initialising tweaks with the Default NIC in theos. (iOS/Mac)

# What's the use?
Calling the script is easy - `EasyNIC.sh` instead of `${THEOS}/bin/nicify.pl` and it makes projects a bit easier to initialize. It follows these steps:
1. Finds the theos directory. It will check for `$THEOS` first, then `/opt/theos/` or `/var/theos` or `/var/root/theos`
2. List all the templates in `theosdir/templates` based on filenames
3. Ask for the project name
4. Ask for the author name
5. Ask for input where the user can type their packageID or leave it blank to use the suitable packageID derived from the project and user names provided. (In the normal NIC, the packageID is asked first, which means typing your name out twice!)
</a>
It also includes an Exit option in case you call it accidentally (I'm not sure if the Ctrl+C functionality is available on iOS consoles)

# Automatic Author Name Detection
The script uses Perl internally to get the default author name exactly how theos does. On iOS, the default name is 'System Administrator' and sometimes your system name might not be the same as what you publish your tweaks with. Therefore you should edit the `DEFAULT_NAME` in the .sh file (line 3) 
```
DEFAULT_NAME="" # ENTER YOUR CUSTOM NAME HERE!
```
and write your preferred default name within the quotes like
```
DEFAULT_NAME="TheArmKing" # ENTER YOUR CUSTOM NAME HERE!
```

# Changelog
v1.03
- Added `$THEOS` check as the primary theos dir
- Removed the `EasyNIC.txt` logic with simply having an editable variable in the script for preferred default name selection
- Changed the internal Perl script for getting author name. The output is now directly assigned to a bash variable instead of being printed to a temp file

v1.02
- The main selection menu now includes an exit option

v1.01
- Capital letters are replaced with lowercase instead of being removed (from packageID)

v1.00
- Initial Release
