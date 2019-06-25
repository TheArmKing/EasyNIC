# EasyNIC
An easier way of initialising tweaks with the Default NIC in theos. (iOS/Mac)

# What's the use?
Calling the script is easy EasyNIC.sh instead of $(THEOS)/bin/nicify.pl and it makes projects a bit easy to initialize
It lists all the templates based on Filenames, asks for a project name, then asks for the User and gives a suitable packageID. In the normal NIC, the packageID is asked first, which means typing your name out twice! :(\
\
On iOS, the default name is System Administrator. Therefore, the tool has a feature where you could save your name.
By making a file -\
On iOS - /var/root/Documents/EasyNIC.txt or /var/mobile/Documents/EasyNIC.txt\
On Mac - /Users/username/Documents/EasyNIC.txt\
where the first line containes the User Name, the tool will automatically fetch it for you.\
\
Note - The Priority is /var/root/Documents/EasyNIC.txt on iOS since $HOME is /var/root on iOS, but the Documents directory doesn't exist so /var/mobile/Documents/EasyNIC.txt makes more sense
If none of the file exists it uses what's provided by the System, just like in NIC

# Changelog
v1.01
- Capital letters are replaced with lowercase instead of being removed (from packageID)

v1.00
- Initial Release
