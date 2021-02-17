SUBDIRS := u-boot

DIR_INFO :=$(shell ls -F | grep /)
REAL_DIR_INFO :=$(DIR_INFO:/= )
DIR_INFO := $(filter-out $(SUBDIRS),$(REAL_DIR_INFO))

ifeq ($(PROJECT_INSTALL),)
all install:
	@echo "YOU SHALL NOT PASS!!!"
	@echo "Please set environment first."
	@exit
else
all install:
	@for i in `echo $(SUBDIRS)`; do \
		$(MAKE) -C $$i $@ || exit 1; \
	done
endif

clean mrproper:
	@for i in `echo $(SUBDIRS)`; do \
		$(MAKE) -C $$i $@ || exit 1; \
	done

