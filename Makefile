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
	git commit -am "-AUTO- `date`"
	git push

cp_make:
	git pull
	cp -r /home/blepers/pmem-redis/deps/ .
	make USE_NVM=yes

mount:
	mkfs.ext4 /dev/pmem0
	mount -o dax /dev/pmem0 /pmem0

run:
	rm -rf /pmem0/*
	/home/blepers/linux/tools/perf/perf record --call-graph dwarf -a -g >/dev/null 2>&1 &
	taskset -c 3 src/redis-server --nvm-maxcapacity 50 --nvm-dir /pmem0 --nvm-threshold 64
	killall -w perf