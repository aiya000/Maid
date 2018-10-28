all: content

content:
	markdown-pp content.md -o content-preprocessed.md

code:
	cat content-preprocessed.md \
		| awk '/^```haskell$$/,/^```$$/' \
		| grep -Ev '```(haskell)?' \
		> HaskellDay.hs

install-deps:
	pip install MarkdownPP

watch:
	watchexec --restart \
		--exts md \
		--ignore */content-preprocessed.md \
		-- 'make content && make code'
