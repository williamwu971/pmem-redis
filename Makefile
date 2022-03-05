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

cp:
	cp -r /home/blepers/pmem-redis/deps/ .

mount:
	mkfs.ext4 /dev/pmem0
	mount -o dax /dev/pmem0 /pmem0

run:
	src/redis-server --nvm-maxcapacity 50 --nvm-dir /pmem0 --nvm-threshold 64