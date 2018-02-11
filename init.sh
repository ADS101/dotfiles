supported_distros=('Ubuntu' 'Debian' 'Fedora' 'CentOS' 'Red Hat' 'Mint' 'OSX' 'Arch Linux' 'Other')

distro_info=$(cat /etc/*release 2> /dev/null | awk 'NR==1' | cut -d"=" -f2)

package_managers=('apt-get' 'apt-get' 'dnf' 'yum' 'yum' 'apt-get' 'brew' 'pacman')

distro_colors=('33;1' '38;5;9' '1;34' '1;33' '0;31' '1;32' '1;30' '1;37')

count=0

current_os=""

dry_run=false

verbose=false
install_file=""
restricted=false
prompt_only=false

while getopts ":DvcpRi:" params; do
	case $params in
		D)
			$dry_run=true
			;;
		v)
			$verbose=true
			;;
		i)
			$install_file=$OPTARG
			;;
		p)
			$prompt_only=true
			;;
		R)
			$restricted=true
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			exit
			;;
	esac
done

detectHost() {
for distro in "${supported_distros[@]}"; do
	echo "Trying $distro ..."
	if [[ $distro_info == *$distro* || $distro == $(lsb_release -sirc 2> /dev/null | awk "NR==1") || $(sw_vers 2> /dev/null | awk 'NR==1' | cut -d $'\t' -f2) == $distro ]]; then
		echo "Bingo! Proceeding..."
		break;
	fi
	echo "next..."
	(( count++ ))
done

}

echo "parse_git_branch() {
	     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
     }" >> $HOME/.bashrc


prompt_color() {
if [[ ! -f $HOME/.bashrc ]]; then
	touch $HOME/.bashrc
fi

if [[ $dry_run == false ]]; then

	if [[ $(grep -F "PS1" $HOME/.bashrc) ]];
		then

			sed -i "/PS1=*/c\export PS1='[\[\e[${distro_colors[$count]}m\]\u\[\e[m\]\[\e[${distro_colors[$count]}m\]@\[\e[m\]\[\e[${distro_colors[$count]}m\]\h\[\e[m\] \[\e[${distro_colors[$count]}m\]\w\[\e[m\]]:\n[\[\e[${distro_colors[$count]}m\]\@\[\e[m\]] \[\e[${distro_colors[$count]}m\]\\$\[\e[m\] '\\" $HOME/.bashrc

		else
			echo "export PS1='[\[\e[${distro_colors[$count]}m\]\u\[\e[m\]\[\e[${distro_colors[$count]}m\]@\[\e[m\]\[\e[${distro_colors[$count]}m\]\h\[\e[m\] \[\e[${distro_colors[$count]}m\]\W\[\e[m\]]:\n[\[\e[${distro_colors[$count]}m\]\@\[\e[m\]] \[\e[${distro_colors[$count]}m\]\\$\[\e[m\] '" >> $HOME/.bashrc

		fi;

	else
		echo "Your bash prompt would have \[\033[${distro_colors[$count]}m\] this colour, moving on! \[\033[0m\] "
	fi
}


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


# Installing Homebrew for Mac Package Management

if [[ $current_os == "Mac OS X" ]]; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

for package in ${packages[@]}; do
	if [[ $dry_run == false ]]; then
		if [[ $current_distro == 'Arch Linux' ]]; then
			sudo pacman -Syu
		else
			sudo "${package_managers[$count]}" -y install "$package"
		fi
	else
		echo "Verifying package $package . . . "
	fi
done

if ! [ -d "$HOME/src" ]; then
	mkdir $HOME/src
fi

cd $HOME/src

for repo in ${gitrepos[@]}; do
	if [[ $dry_run == false ]]; then
		git clone "$repo"
	else
		echo "Verifying repository $repo . . ."
	fi
done

if [[ $dry_run == false ]]; then

	cd $HOME/src/screenFetch; chmod +x screenfetch-dev; sudo mv screenfetch-dev /usr/bin/screenfetch

	cd $HOME/src/apt-vim; bash install.sh;

	cd $HOME/src/dotfiles; cp -rf .vimrc $HOME/

	. $HOME/.bashrc
fi
