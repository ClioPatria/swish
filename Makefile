# Create a ClioPatria SWISH package from the SWISH distribution.

FONTDIR=web/bower_components/bootstrap/dist/fonts
PACKDIR=lib/swish/pack
PACKS=profile smtp wordnet pcache
DIRS=lib/swish lib/swish/render lib/swish/plugin $(PACKDIR) \
     web/icons web/help client $(FONTDIR) \
     web/bower_components/codemirror/mode/htmlmixed \
     web/bower_components/codemirror/mode/css \
     web/bower_components/codemirror/mode/javascript \
     $(addprefix $(PACKDIR)/, $(addsuffix /prolog, $(PACKS))) \
     $(PACKDIR)/profile/prolog/profile/backend \
     config-available/gitty
SWISHLIB=storage.pl page.pl help.pl examples.pl config.pl gitty.pl \
	 highlight.pl render.pl template_hint.pl search.pl form.pl \
	 include.pl swish_csv.pl logging.pl trace.pl markdown.pl \
	 gitty_driver_files.pl gitty_driver_bdb.pl gitty_tools.pl \
	 swish_debug.pl profiles.pl procps.pl download.pl r_swish.pl \
	 patch.pl chat.pl authenticate.pl pep.pl avatar.pl bootstrap.pl \
	 noble_avatar.pl chatstore.pl paths.pl messages.pl dashboard.pl \
	 projection.pl jquery.pl rgb.txt version.pl http_version.pl \
	 bad-words-google.txt bad-words.txt content_filter.pl \
	 cron.pl provenance.pl
RENDER=table.pl graphviz.pl c3.pl codes.pl swish.pl chess.pl sudoku.pl \
       svgtree.pl wordnet.pl
PLUGIN=email.pl profile.pl notify.pl login.pl
GITTY=config-available/gitty/Hangout.swinb
PACKFILES0=profile/pack.pl profile/prolog/user_profile.pl \
	   profile/prolog/profile/backend/profile_prolog.pl \
	   smtp/pack.pl smtp/prolog/smtp.pl \
	   wordnet/pack.pl wordnet/prolog/wn.pl wordnet/prolog/wn_portray.pl \
	   pcache/pack.pl pcache/prolog/signature.pl
PACKFILES=$(addprefix $(PACKDIR)/, $(PACKFILES0))
LIBS=	$(addprefix lib/swish/, $(SWISHLIB)) \
	$(addprefix lib/swish/render/, $(RENDER)) \
	$(addprefix lib/swish/plugin/, $(PLUGIN))
JS=web/js/swish-min.js web/js/swish-min.js.gz web/js/require.js \
   web/js/swish-min.js.map
CSS=web/css/swish-min.css web/css/swish-min.css.gz
ICON_FILES=owl_25_years.png running.gif page-fold-20.png \
	   COMMIT_logo.png Synerscope-logo.png VU-logo.png \
	   vre4eic-logo.png cwi-logo.png \
	   pl.png swinb.png noble avatar.svg
ICONS=$(addprefix web/icons/, $(ICON_FILES))
HELP=$(addprefix web/help/, $(notdir $(wildcard src/web/help/*.html)))
FONTFILES=glyphicons-halflings-regular.ttf \
	  glyphicons-halflings-regular.eot \
	  glyphicons-halflings-regular.woff \
	  glyphicons-halflings-regular.woff2
FONTS=$(addprefix $(FONTDIR)/, $(FONTFILES))
CLIENTFILES=swish-ask.sh README.md sin-table.html
CLIENTS=$(addprefix client/, $(CLIENTFILES))
EXAMPLESFILES=render_c3.swinb render_graphviz.swinb htmlcell.swinb \
	      rendering.swinb jquery.swinb stats.swinb \
	      swish_tutorials.swinb \
	      Rserve.swinb Rdataframe.swinb Rdownload.swinb \
	      iris.swinb
EXAMPLES=$(addprefix examples/, $(EXAMPLESFILES))
CMFILES=mode/htmlmixed/htmlmixed.js \
	mode/javascript/javascript.js \
	mode/css/css.js
CM=$(addprefix web/bower_components/codemirror/, $(CMFILES))

all:	$(DIRS) $(LIBS) $(JS) $(CSS) $(ICONS) $(HELP) $(FONTS) $(CLIENTS) \
	$(CM) $(EXAMPLES) $(PACKFILES) $(GITTY)

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
web/js/swish-min.js.map::
	@if [ -f src/web/js/swish-min.js.map ]; then \
	  rsync -u src/web/js/swish-min.js.map $@; \
	else \
	  rm -f $@; \
        fi
web/js/require.js: src/web/bower_components/requirejs/require.js
	rsync -u $< $@

web/css/%: src/web/css/%
	rsync -u $< $@

web/icons/noble: src/web/icons/noble
	rsync -ua $</ $@

web/icons/%: src/web/icons/%
	rsync -u $< $@

web/help/%: src/web/help/%
	rsync -u $< $@

examples/%: src/examples/%
	rsync -u $< $@

$(FONTDIR)/%: src/$(FONTDIR)/%
	rsync -u $< $@

$(PACKDIR)/%: src/pack/%
	rsync -u $< $@

web/bower_components/codemirror/%: src/web/bower_components/codemirror/%
	rsync -u $< $@

config-available/%: src/config-available/%
	rsync -u $< $@

clean::
	rm -f $(LIBS) $(JS) $(CSS) $(ICONS) $(HELP)
