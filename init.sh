supported_distros=('Ubuntu' 'Debian' 'Fedora' 'CentOS' 'Other')

distro_info1=$(cat /etc/*release | awk 'NR==1' | cut -d"=" -f2)

package_managers=('apt-get' 'apt-get' 'dnf' 'yum')

distro_colors=('33' '91' '36' '94' '1;32')

count=0
for distro in ${supported_distros[@]}; do
	if [[ $distro == *$distro_info* || $distro == $(lsb_release -sirc) ]]; then
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

onlinepackages=(
	https://go.microsoft.com/fwlink/?LinkID=760868
)

for package in ${packages[@]}; do
	sudo apt-get install "$package"
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
