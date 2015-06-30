# Create a ClioPatria SWISH package from the SWISH distribution.

FONTDIR=web/bower_components/bootstrap/dist/fonts
DIRS=lib/swish lib/swish/render web/icons web/help client $(FONTDIR)
SWISHLIB=storage.pl page.pl help.pl examples.pl config.pl gitty.pl \
	 highlight.pl render.pl template_hint.pl search.pl form.pl \
	 include.pl csv.pl logging.pl trace.pl markdown.pl
RENDER=table.pl c3.pl
LIBS=	$(addprefix lib/swish/, $(SWISHLIB)) \
	$(addprefix lib/swish/render/, $(RENDER))
JS=web/js/swish-min.js web/js/swish-min.js.gz web/js/require.js
CSS=web/css/swish-min.css web/css/swish-min.css.gz
ICON_FILES=owl_25_years.png dead.png error.png running.gif page-fold-20.png \
	   COMMIT_logo.png Synerscope-logo.png VU-logo.png pl.png swinb.png \
	   select.png
ICONS=$(addprefix web/icons/, $(ICON_FILES))
HELP=$(addprefix web/help/, $(notdir $(wildcard src/web/help/*.html)))
FONTFILES=glyphicons-halflings-regular.ttf \
	  glyphicons-halflings-regular.eot \
	  glyphicons-halflings-regular.woff \
	  glyphicons-halflings-regular.woff2
FONTS=$(addprefix $(FONTDIR)/, $(FONTFILES))
CLIENTFILES=swish-ask.sh README.md sin-table.html
CLIENTS=$(addprefix client/, $(CLIENTFILES))

all:	$(DIRS) $(LIBS) $(JS) $(CSS) $(ICONS) $(HELP) $(FONTS) $(CLIENTS)

$(DIRS):
	mkdir -p $@

lib/swish/%: src/lib/%
	rsync -u $< $@
client/%: src/client/%
	rsync -u $< $@
client/swish-ask.sh: src/client/swish-ask.sh
	sed -e 's/:3050}/:3020}/' -e 's/-prolog}/-rdf}/' $< > $@
	chmod +x $@

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

$(FONTDIR)/%: src/$(FONTDIR)/%
	rsync -u $< $@

clean::
	rm -f $(LIBS) $(JS) $(CSS) $(ICONS) $(HELP)
