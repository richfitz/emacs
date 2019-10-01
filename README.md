## My emacs configuration

Previously I used [prelude](https://github.com/bbatsov/prelude) but it and ESS started taking to wild changes in behaviour with upgrades so I'm going back to basics with a simple emacs configuration.  Eventually this will work on both macOS and linux.

This is fairly vanilla emacs but with ESS frozen to 16.04 because the indentation behaviour there is reasonably sane and because newer versions seem to behave and new and exciting ways each upgrade.  You can adjust the version of ESS installed by editing [`setup/ess`](setup/ess) and editing the `VERSION` variable.

## Installation

* clone this repository into somewhere sensible like `~/lib/emacs`
* `ln -s ~/lib/emacs .emacs.d`
* from the `~/.emacs.d` directory run `./setup/ess` to install ess
* On emacs startup, it will install all required packages from elpa/melpa; this may be slow the first time.

## Requirements

* macOS: works with [Emacs for Mac OS X](https://emacsformacosx.com/) (currently at 26.1-2) but it will not work with the ancient version of command line emacs that the mac ships with macOS (still 22.x on Mojave).  Run `./setup/emacs` to set up some helper scripts, though thse don't really work at present.
* Linux: you may have to add the gpg key with `gpg --homedir ~/.emacs.d/elpa/gnupg --receive-keys 066DAFCB81E42C40`

## Inspiration

* http://aaronbedra.com/emacs.d/
