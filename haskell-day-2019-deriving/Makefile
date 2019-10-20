all:
	[[ -f theme-mod.css ]] && rm theme-mod.css || true
	sass theme-mod.sass | tee theme-mod.css

watch:
	watchexec --exts sass -- $(MAKE)

open:
	electron index.html &
