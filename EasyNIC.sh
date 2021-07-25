#!/bin/bash
if [ -d "/opt/theos" ]; then
	dir="/opt/theos"
elif [ -d "/var/theos" ] && [ -d "/var/root/theos" ] ; then
	echo -en "1. /var/theos\n2. /var/root/theos\n"
	fg=0
	while (( !fg )); do
		read -p "Choose a dir: " num
		if [ "$num" != "1" ] && [ "$num" != "2" ] ; then
			echo "Invalid Choice!"
		elif [ "$num" == "1" ]; then
			dir="/var/theos"
			fg=1
		elif [ "$num" == "2" ]; then
			dir="/var/root/theos"
			fg=1
		fi
	done
elif [ -d "/var/theos" ]; then
	dir="/var/theos"
elif [ -d "/var/root/theos" ]; then
	dir="/var/root/theos"
else
	echo "No valid theos directories found!"
	exit
fi
ndir="${dir}/templates/"
echo "EasyNIC 1.0 - TheArmKing"
echo "------------------------"
bjen="$(find "$dir" -type f -name '*.tar' | sed "s/${ndir//\//\\/}//g" | sed 's/.tar//g' | sed 's/.nic//g')"
IFS=$'\n' read -rd '' -a aro <<< "$bjen"
aro=( "${aro[@]}" "Exit" )
hj=1
for dmf in "${aro[@]}"; do
	echo "  [${hj}.] $dmf"
	(( hj = hj + 1 ))
done
ja=0
while (( !ja )); do
	read -p "Choose a Template (required): " nump
	if [ $((nump)) == "$nump" ]; then
		if [ "$nump" -eq "${#aro[@]}" ]; then exit; fi
		if [ "$nump" -gt 0 ] && [ "$nump" -lt "${#aro[@]}" ]; then
			tempath="${dir}/templates/${aro[$nump - 1]}.nic.tar"
			ja=1
		fi
	fi
	if [ "$ja" == "0" ]; then echo "Invalid Template Number!"; fi
done
qw=0
while (( !qw )); do
	read -p "Project Name (required): " pjn
	if [ "$pjn" == "" ]; then echo "Invalid Project Name!"; else qw=1; fi
done
perl -x "$0"

echo <<EOF >/dev/null
#!/usr/bin/perl

use strict;
use warnings;

use User::pwent;
use POSIX qw(getuid);

my $bat = getUserName();
open my $fh, ">", "/tmp/easynicusername.txt" or die("Could not open file. $!");
print $fh $bat;
close $fh;

sub getUserName {
	my $pw = getpw(getuid());
	my ($fullname) = split(/\s*,\s*/, $pw->gecos);
	return $fullname && $fullname ne "\"\"" ? $fullname : $pw->name;
}

__END__
EOF
if [ -f "$HOME/Documents/EasyNIC.txt" ]; then
	line=$(head -n 1 "$HOME/Documents/EasyNIC.txt")
elif [ -f "/var/mobile/Documents/EasyNIC.txt" ]; then
	line=$(head -n 1 "/var/mobile/Documents/EasyNIC.txt")
else
	line=$(head -n 1 "/tmp/easynicusername.txt")
fi
rm "/tmp/easynicusername.txt"
read -p "Author/Maintainer Name [${line}]: " otor
if [ "$otor" == "" ]; then otor="${line}"; fi
yrc="$(echo "$otor" | awk '{print tolower($0)}' | sed 's/[^0-9a-z]*//g')"
read -p "Package Name [com.${yrc}.${pjn}]: " pckg
if [ "$pckg" == "" ]; then pckg="com.${yrc}.${pjn}"; fi
pckg="$(echo "$pckg" | awk '{print tolower($0)}' | sed 's/[^0-9a-z.]*//g')"
"${dir}/bin/nic.pl" --nic "$tempath" -n "$pjn" -p "$pckg" -u "$otor"
