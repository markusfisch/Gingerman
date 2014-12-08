HTDOCS = htdocs
SPRITES = sprites/*
WEBROOT = hhsw.de@ssh.strato.de:sites/proto/ld31/
OPTIONS = \
	--recursive \
	--links \
	--update \
	--delete-after \
	--times \
	--compress

live: atlas
	rsync $(OPTIONS) \
		$(HTDOCS)/* \
		$(WEBROOT)

atlas: $(SPRITES)
	cd $(HTDOCS) && \
		mkatlas ../$(SPRITES) | \
		patchatlas index.html && \
		sed -e "s_data:image/png;base64,[/+a-zA-Z0-9=]*_data:image/png;base64,$$(base64 atlas.png | tr -d '\n')_" < index.html > tmp.html && \
		mv tmp.html index.html && \
		rm atlas.png