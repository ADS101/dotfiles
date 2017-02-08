packages=(
	htop
	ssh
	)

if (( ${#packages[@]} > 0 )); then
	for package in "${packages[@]}"; do
		echo "$package"
done
fi

if ! [ -d "$HOME/src" ]; then
	echo "exists"
else
	echo "Does not exist"
fi

supported_distros=('Ubuntu' 'Debian' 'Fedora' 'Red Hat' 'CentOS')

distro_info=$(cat /etc/*release | awk 'NR==1' | cut -d"=" -f2)

package_managers=('apt-get' 'apt-get' 'dnf' 'yum' 'yum')

distro_colors=('[33m\]' '[91m\]' '[36m\]' '[31m\]' '[94m\]')


distro_no=0
count=0
for distro in ${supported_distros[@]}; do
	if [[ $distro == *$distro_info* || $distro == $(lsb_release -sirc)	]]; then
		echo "It's $distro!"
		distro_no=$count
		echo "I use ${package_managers[$distro_no]}!"
	fi
	(( count++ ))
done

echo "parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* ](.*\)/ [/1]' 
}" >> testgit
