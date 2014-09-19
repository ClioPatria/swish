# Create a ClioPatria SWISH package from the SWISH distribution.

DIRS=lib/swish
LIBS=lib/swish/storage.pl lib/swish/page.pl lib/swish/help.pl \
     lib/swish/examples.pl lib/swish/authenticate.pl \
     lib/swish/config.pl
JS=web/js/swish-min.js web/js/require.js
CSS=web/css/swish-min.css
ICONS=web/icons/logo.png web/icons/owl_25_years.png

all:	$(DIRS) $(LIBS) $(JS) $(CSS) $(ICONS)

lib/swish::
	mkdir -p $@
web/icons::
	mkdir -p $@

lib/swish/config.pl: src/lib/config.pl lib/swish
	rsync -u $< $@
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
web/js/require.js: src/web/bower_components/requirejs/require.js
	rsync -u $< $@

web/css/swish-min.css: src/web/css/swish-min.css
	rsync -u $< $@

web/icons/logo.png: src/web/icons/logo.png web/icons
	rsync -u $< $@
web/icons/owl_25_years.png: src/web/icons/owl_25_years.png web/icons
	rsync -u $< $@
