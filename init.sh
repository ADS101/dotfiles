supported_distros=('Ubuntu' 'Debian' 'Fedora' 'CentOS')

distro_info1=$(cat /etc/*release | awk 'NR==1' | cut -d"=" -f2)

package_managers=('apt-get' 'apt-get' 'dnf' 'yum' 'yum')

distro_colors=('[33m\]' '[91m\]' '[36m\]' '[94m\]')

count=0
for distro in ${supported_distros[@]}; do
	if [[ $distro == *$distro_info* || $distro == $(lsb_release -sirc) ]]; then
		$distro=$count
	fi
	(( count++ ))
done

packages=(
	git
	htop
	vim
	libncurses5-dev
	ifconfig
	build-essential
	manpages-dev
	)

gitrepos=(
	https://github.com/KittyKatt/screenFetch
	https://github.com/egalpin/apt-vim
#	https://github.com/torvalds/linux
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

cd screenFetch; chmod +x screenfetch-dev; sudo mv screenfetch-dev /usr/bin/screenfetch

cd $HOME/src/apt-vim; apt-vim init

cd $HOME/dotfiles; cp -rf .bashrc $HOME/; cp -rf .bash_profile $HOME/; cp -rf .vimrc $HOME/

echo 'export PS1="[\[\e[104;40m\]\u\[\e[m\]\[\e[34m\]@\[\e[m\]\[\e[31m\]\h\[\e[m\]]:\n[\[\e[94m\]\@\[\e[m\]] "'

