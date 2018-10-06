all: code

code:
	cat content.md \
		| awk '/^```haskell$/,/^```$/' \
		| grep -Ev '```(haskell)?' \
		> HaskellDay.hs

watch:
	watchexec --restart --exts md -- make
