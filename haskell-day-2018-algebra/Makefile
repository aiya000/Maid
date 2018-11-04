all: content

content:
	markdown-pp first-half.md -o first-half-preprocessed.md
	markdown-pp last-half.md -o last-half-preprocessed.md
	markdown-pp content.md -o content-preprocessed.md

code:
	cat first-half-preprocessed.md \
		| awk '/^```haskell$$/,/^```$$/' \
		| grep -Ev '```(haskell)?' \
		> FirstHalf.hs
	cat last-half-preprocessed.md \
		| awk '/^```haskell$$/,/^```$$/' \
		| grep -Ev '```(haskell)?' \
		> LastHalf.hs

install-deps:
	pip install MarkdownPP
	stack install primes

watch:
	watchexec --restart \
		--exts md \
		--ignore */first-half-preprocessed.md \
		--ignore */last-half-preprocessed.md \
		--ignore */content-preprocessed.md \
		-- 'make content && make code'
