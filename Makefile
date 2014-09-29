# Create a ClioPatria SWISH package from the SWISH distribution.

DIRS=lib/swish web/icons web/help
LIBS=$(addprefix lib/swish/, \
       storage.pl page.pl help.pl examples.pl config.pl gitty.pl)
JS=web/js/swish-min.js web/js/swish-min.js.gz web/js/require.js
CSS=web/css/swish-min.css web/css/swish-min.css.gz
ICONS=web/icons/owl_25_years.png \
      web/icons/dead.png web/icons/error.png web/icons/running.gif
HELP=$(addprefix web/help/, $(shell cd src/web/help && echo *.html))

all:	$(DIRS) $(LIBS) $(JS) $(CSS) $(ICONS) $(HELP)

lib/swish:
	mkdir -p $@
web/icons:
	mkdir -p $@
web/help:
	mkdir -p $@

lib/swish/%: src/lib/%
	rsync -u $< $@

web/js/swish-min.js: src/web/js/swish-min.js
	rsync -u $< $@
web/js/swish-min.js.gz: src/web/js/swish-min.js.gz
	rsync -u $< $@
web/js/require.js: src/web/bower_components/requirejs/require.js
	rsync -u $< $@

web/css/%: src/web/css/%
	rsync -u $< $@

web/icons/%: src/web/icons/%
	rsync -u $< $@

web/help/%: src/web/help/%
	rsync -u $< $@

clean::
	rm -f $(LIBS) $(JS) $(CSS) $(ICONS) $(HELP)
