# [ClioPatria](http://cliopatria.swi-prolog.org) cpack swish -- Add Prolog interaction to ClioPatria

Make the SWI-Prolog [SWISH](https://github.com/SWI-Prolog/swish.git)
package available as a ClioPatria _cpack_.  SWISH brings a Prolog
interface to ClioPatria, providing:

  - Ask RDF queries about our data
  - Make example programs available about your data
  - Save an example program and share it with anyone on the web
  - Collaborate on a program using [TogetherJS](https://togetherjs.com/)
  - Manage a server remotely from the Prolog shell (requires login with
    `admin` rigths).

This package is just a first preview. We have many plans for making this
more powerful and friendly.

## Update the cpack to the latest SWISH

Updating the SWISH cpack from the   upstream resources. Although you can
probably get this done on any OS, I'd  strongly advice to use Linux. You
may try on MacOS and if you're really motivated it might work on Windows
using MinGW or Cygwin.

  - Initialise the src git submodule if this was not done:

	```
	$ git submodule update --init
	```

  - Pull the latest upstream version of SWISH

	```
	$ cd src
	$ git pull
	$ bower install		# or `bower update` if already installed
	```

  - Make sure you have all the tools installed to do the JavaScript and
    CSS building.  See README.md in src or online at
    https://github.com/SWI-Prolog/swish

  - Build the CSS and JS files. Might be wise to clean first. In `src`,
    run:

	```
	$ make clean
	$ make
	```

  - Now update the cpack from the directory holding this README.md using

	```
	$ make
	```

