notify ?= notify-send

all:
	[[ -f theme-mod.css ]] && (rm theme-mod.css || true)
	sass theme-mod.sass > theme-mod.css 2> error.log \
		|| (cat error.log ; false)

watch:
	watchexec --exts sass -- '$(MAKE) || $(notify) fail'

open:
	electron index.html &
