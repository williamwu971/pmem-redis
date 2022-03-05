# Top level makefile, the real shit is at src/Makefile
JEMALLOC_PATH=../deps/memkind
export JEMALLOC_PATH

default: all

.DEFAULT:
	cd src && $(MAKE) $@

install:
	cd src && $(MAKE) $@

.PHONY: install

push:
	git commit -am "-AUTO- `date`" || true
	git push https://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@github.com/williamwu971/pmem-redis.git || true