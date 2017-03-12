# dotfiles
My personal dotfiles (still in development)

Utilizes distro detection to present a specialized coloured bash prompt (with basic git support), and streamline application installs across package managers. Currently supports only distros I am likely to use but this will be expanded eventually.

Planned Features

Installation tracks:

Ability to choose and combine multiple installation tracks (ie Base Install, Casual Desktop, Productivity Desktop and Server). This will be geared towards applications I personally use, but the package arrays will be migrated to a separate file to be manipulated at the user's discretion. 

Package Availablility Detection:

If a package isnt available in a given distro, it will attempt to clone the package from github and install it in any way it can detect
