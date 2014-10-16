# Create a ClioPatria SWISH package from the SWISH distribution.

DIRS=lib/swish lib/swish/render web/icons web/help
SWISHLIB=storage.pl page.pl help.pl examples.pl config.pl gitty.pl \
	 highlight.pl render.pl
RENDER=table.pl
LIBS=	$(addprefix lib/swish/, $(SWISHLIB)) \
	$(addprefix lib/swish/render/, $(RENDER))
JS=web/js/swish-min.js web/js/swish-min.js.gz web/js/require.js
CSS=web/css/swish-min.css web/css/swish-min.css.gz
ICON_FILES=owl_25_years.png dead.png error.png running.gif page-fold-20.png
ICONS=$(addprefix web/icons/, $(ICON_FILES))
HELP=$(addprefix web/help/, $(notdir $(wildcard src/web/help/*.html)))

all:	$(DIRS) $(LIBS) $(JS) $(CSS) $(ICONS) $(HELP)

lib/swish:
	mkdir -p $@
lib/swish/render:
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
