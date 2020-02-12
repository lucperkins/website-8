prepare:
	rm -rf public
	git submodule foreach git merge origin/master
	cp -rf harbor/docs content

serve:
	hugo server \
		--buildDrafts \
		--buildFuture \
		--disableFastRender

production-build: prepare
	hugo \
	--minify
	make run-link-checker

preview-build: prepare
	hugo \
		--baseURL $(DEPLOY_PRIME_URL) \
		--buildDrafts \
		--buildFuture \
		--minify
	make run-link-checker

link-checker-setup:
	curl https://htmltest.wjdp.uk | bash

run-link-checker: link-checker-setup
	bin/htmltest
