TOPDIR = ${shell pwd}

ifndef PROJECT_ROOT
	$(error You must first source the BSP environment: ". ./setenv")
endif

INSTALL_DIRS = src/bootloader src/kernel src/sysapps
CLEAN_DIRS = src/bootloader src/kernel src/sysapps

all: bootloader kernel sysapps

.PHONY: bootloader kernel sysapps

bootloader:
	@(if [ ! -f $(PROJECT_ROOT)/src/bootloader/u-boot/.config ]; then \
		$(MAKE) -C src/bootloader/u-boot LicheePi_Zero_800x480LCD_defconfig; \
	fi)
	$(MAKE) -C src/$@
	cp $(PROJECT_ROOT)/src/bootloader/u-boot/u-boot-sunxi-with-spl.bin $(PROJECT_IMG)/loader

kernel:
	$(MAKE) -C src/kernel

sysapps:
	$(MAKE) -c src/sysapps


.PHONY: clean cleanall
clean:
	@for i in `echo $(CLEAN_DIRS)`; do \
		$(MAKE) -C $$i $@; \
	done

cleanall: clean
	@echo -e "\n\n CleanAll.............\n\n"


