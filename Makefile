SHELL = /bin/sh

all: 256 ansi

clean:
	rm dircolors.{256dark,ansi-dark,ansi-light,ansi-universal}

dircolors.256dark:
	curl -OJ https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark

dircolors.ansi-dark:
	curl -OJ https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark

dircolors.ansi-light:
	curl -OJ https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-light

dircolors.ansi-universal:
	curl -OJ https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-universal

256: dircolors.256dark

ansi: dircolors.ansi-light dircolors.ansi-dark dircolors.ansi-universal
