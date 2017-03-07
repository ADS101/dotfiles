supported_distros=('Ubuntu' 'Debian' 'Fedora' 'CentOS' 'Red Hat' 'Mint' 'Other')

distro_info=$(cat /etc/*release | awk 'NR==1' | cut -d"=" -f2)

package_managers=('apt-get' 'apt-get' 'dnf' 'yum' 'yum' 'apt-get')

distro_colors=('38;5;9' '38;5;9' '1;34' '1;33' '1;32' '1;37')

count=0
for distro in "${supported_distros[@]}"; do
	echo $distro
	if [[ $distro_info == *$distro* || $distro == $(lsb_release -sirc | awk "NR==1") ]]; then
		break;
	fi
	(( count++ ))
done


echo "parse_git_branch() {
	     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
     }" >> $HOME/.bashrc

sed -i "/PS1=*/c\export PS1='[\[\e[${distro_colors[$count]}m\]\u\[\e[m\]\[\e[${distro_colors[$count]}m\]@\[\e[m\]\[\e[${distro_colors[$count]}m\]\h\[\e[m\] \[\e[${distro_colors[$count]}m\]\W\[\e[m\]]:\n[\[\e[${distro_colors[$count]}m\]\@\[\e[m\]] \[\e[${distro_colors[$count]}m\]\\$\[\e[m\] '\\" $HOME/.bashrc


packages=(
	git
	curl
	wget
	htop
	vim
	libncurses5-dev
	ifconfig
	build-essential
	manpages-dev
	modutils
	)

gitrepos=(
	https://github.com/KittyKatt/screenFetch
	https://github.com/egalpin/apt-vim
#	https://github.com/torvalds/linux
)

for package in ${packages[@]}; do
	sudo "${package_managers[$count]}" install "$package"
done

if ! [ -d "$HOME/src" ]; then
	mkdir $HOME/src
fi

cd $HOME/src

for repo in ${gitrepos[@]}; do
	git clone "$repo"
done

cd $HOME/src/screenFetch; chmod +x screenfetch-dev; sudo mv screenfetch-dev /usr/bin/screenfetch

cd $HOME/src/apt-vim; bash install.sh;

cd $HOME/src/dotfiles; cp -rf .vimrc $HOME/

. $HOME/.bashrc
