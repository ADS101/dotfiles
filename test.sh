echo "THIS IS A TEST"


while getopts ":aA:zZ" flag;
do
case $i in
	a)
		echo "-a was triggered" >&2 ;;
	A)
		echo "-A was triggered" >&2 ;;
	z)
		echo "-z was triggered" >&2 ;;
	Z)
		echo "-Z was triggered" >&2 ;;
esac
done

packages=(
	htop
	ssh
	)

echo "If this were real, I'd be installing..."
if (( ${#packages[@]} > 0 )); then
	for package in "${packages[@]}"; do
		echo "$package"
done
fi

if ! [ -d "$HOME/src" ]; then
	echo "src directory exists"
else
	echo "src directory does not exist"
fi

supported_distros=('Ubuntu' 
			'Debian' 
			'Fedora' 
			"Red Hat" 
			'CentOS' 
			'LinuxMint')

distro_info=$(cat /etc/*release | awk 'NR==1' | cut -d"=" -f2)

package_managers=('apt-get' 'apt-get' 'dnf' 'yum' 'yum' 'apt-get')

distro_colors=('[33m\]' '[91m\]' '[36m\]' '[31m\]' '[94m\]' '[1;32]')


distro_no=0
count=0
for distro in ${supported_distros[@]}; do
	if [[ *$distro_info* =~ $distro || $distro == $(lsb_release -sirc > /dev/null 2&>1 | awk 'NR==1')	]]; then
		echo "You are using $distro"
		distro_no=$count
		echo "You use the package manager ${package_managers[$distro_no]}!"
	fi
	(( count++ ))
done

echo "parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* ](.*\)/ [/1]' 
}" >> testgit

echo "CHECKING FOR PS1 VARIABLE IN .BASRHRC..."

if [[ $(grep -F "PS1" $HOME/.bashrc) ]]; 
then
	echo "PS1 found!"; 
else
	echo "No PS1 found..."; 
fi;

