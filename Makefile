# Create a ClioPatria SWISH package from the SWISH distribution.

DIRS=lib/swish
LIBS=lib/swish/storage.pl lib/swish/page.pl lib/swish/help.pl \
     lib/swish/examples.pl lib/swish/authenticate.pl
JS=web/js/swish-min.js
CSS=web/css/swish-min.css

all:	$(DIRS) $(LIBS) $(JS) $(CSS)

lib/swish::
	mkdir -p $@

lib/swish/storage.pl: src/lib/storage.pl lib/swish
	rsync -u $< $@
lib/swish/page.pl: src/lib/page.pl lib/swish
	rsync -u $< $@
lib/swish/help.pl: src/lib/help.pl lib/swish
	rsync -u $< $@
lib/swish/examples.pl: src/lib/examples.pl lib/swish
	rsync -u $< $@
lib/swish/authenticate.pl: src/lib/authenticate.pl lib/swish
	rsync -u $< $@

web/js/swish-min.js: src/web/js/swish-min.js
	rsync -u $< $@

web/css/swish-min.css: src/web/css/swish-min.css
	rsync -u $< $@

