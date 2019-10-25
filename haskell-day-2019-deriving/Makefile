all: build

serve:
	cd .. && $(MAKE) serve

build:
	[[ -f theme-mod.css ]] && (rm theme-mod.css || true)
	sass theme-mod.sass > theme-mod.css 2> error.log \
		|| (cat error.log ; false)

notify ?= notify-send

watch:
	watchexec --exts sass -- '$(MAKE) || $(notify) fail'

open:
	chromium http://localhost:25252/haskell-day-2019-deriving &
