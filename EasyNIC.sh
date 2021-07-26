#!/bin/bash

DEFAULT_NAME="" # ENTER YOUR CUSTOM NAME HERE!

if [ ! -f "/usr/bin/perl" ]; then echo "Perl is not installed! Why are you even trying to run theos without perl?" && exit; fi

if [ "$THEOS" != "" ]; then
    dir="$THEOS"
elif [ -d "/opt/theos" ]; then
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

defn=`/usr/bin/perl -x $0`
echo <<'__END__' > /dev/null
#!/usr/bin/perl -wl
use User::pwent;
use POSIX qw(getuid);
my $pw = getpw(getuid());
my ($fullname) = split(/\s*,\s*/, $pw->gecos);
print $fullname && $fullname ne "\"\"" ? $fullname : $pw->name;
__END__

if [ "${DEFAULT_NAME}" != "" ]; then
    defn="${DEFAULT_NAME}"    
fi

ndir="${dir}/templates/"
echo "EasyNIC v1.03 by TheArmKing"
echo "Default Name - ${defn}"
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

read -p "Author/Maintainer Name [${defn}]: " otor
if [ "$otor" == "" ]; then otor="${defn}"; fi
yrc="$(echo "$otor" | awk '{print tolower($0)}' | sed 's/[^0-9a-z]*//g')"
read -p "Package Name [com.${yrc}.${pjn}]: " pckg
if [ "$pckg" == "" ]; then pckg="com.${yrc}.${pjn}"; fi
pckg="$(echo "$pckg" | awk '{print tolower($0)}' | sed 's/[^0-9a-z.]*//g')"
"${dir}/bin/nic.pl" --nic "$tempath" -n "$pjn" -p "$pckg" -u "${otor}"
