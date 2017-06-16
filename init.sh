supported_distros=('Ubuntu' 'Debian' 'Fedora' 'CentOS' 'Red Hat' 'Mint' 'Other')

distro_info=$(cat /etc/*release | awk 'NR==1' | cut -d"=" -f2)

package_managers=('apt-get' 'apt-get' 'dnf' 'yum' 'yum' 'apt-get')

distro_colors=('33;1' '38;5;9' '1;34' '1;33' '0;31' '1;32' '1;37')

count=0
for distro in "${supported_distros[@]}"; do
	echo "Trying $distro ..."
	if [[ $distro_info == *$distro* || $distro == $(lsb_release -sirc | awk "NR==1") ]]; then
		echo "Bingo! Proceeding..."
		break;
	fi
	echo "next..."
	(( count++ ))
done


echo "parse_git_branch() {
	     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
     }" >> $HOME/.bashrc


if [[ $(grep -F "PS1" $HOME/.bashrc) ]];
then

	sed -i "/PS1=*/c\export PS1='[\[\e[${distro_colors[$count]}m\]\u\[\e[m\]\[\e[${distro_colors[$count]}m\]@\[\e[m\]\[\e[${distro_colors[$count]}m\]\h\[\e[m\] \[\e[${distro_colors[$count]}m\]\W\[\e[m\]]:\n[\[\e[${distro_colors[$count]}m\]\@\[\e[m\]] \[\e[${distro_colors[$count]}m\]\\$\[\e[m\] '\\" $HOME/.bashrc

else
        echo "export PS1='[\[\e[${distro_colors[$count]}m\]\u\[\e[m\]\[\e[${distro_colors[$count]}m\]@\[\e[m\]\[\e[${distro_colors[$count]}m\]\h\[\e[m\] \[\e[${distro_colors[$count]}m\]\W\[\e[m\]]:\n[\[\e[${distro_colors[$count]}m\]\@\[\e[m\]] \[\e[${distro_colors[$count]}m\]\\$\[\e[m\] '" >> $HOME/.bashrc

fi;



packages=(
#	eog
	git
	curl
	wget
	htop
	vim
	libncurses5-dev
#	ifconfig
	build-essential
	manpages-dev
	modutils
	ffmpeg
#	tilda
	)

gitrepos=(
	https://github.com/KittyKatt/screenFetch
	https://github.com/egalpin/apt-vim
#	https://github.com/torvalds/linux
	https://github.com/rg3/youtube-dl
)

##### Install WP-CLI #####

# curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

for package in ${packages[@]}; do
	sudo "${package_managers[$count]}" -y install "$package"
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
