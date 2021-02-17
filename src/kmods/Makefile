SUBDIRS := hello_drv

DIR_INFO := $(shell ls -F | grep /)
REAL_DIR_INFO :=$(DIR_INFO:/= )
DIR_INFO := $(filter-out $(SUBDIRS),$(REAL_DIR_INFO))


all:
	@echo "Build Kernel Modules...."
	@for i in `echo $(SUBDIRS)`; do \
		$(MAKE) -C $$i $@ || exit 1; \
	done

install:
	@for i in `echo $(SUBDIRS)`; do \
		$(MAKE) -C $$i $@; \
	done

clean mrproper:
	@for i in `echo $(SUBDIRS)`; do \
		$(MAKE) -C $$i $@; \
	done



