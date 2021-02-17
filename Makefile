TOPDIR = ${shell pwd}

ifndef PROJECT_ROOT
	$(error You must first source the BSP environment: ". ./setenv")
endif

INSTALL_DIRS = src/bootloader src/kernel/linux src/sysapps
CLEAN_DIRS = src/bootloader src/kernel/linux src/sysapps

all: bootloader kernel sysapps

.PHONY: bootloader kernel sysapps

bootloader:
	@(if [ ! -f $(PROJECT_ROOT)/src/bootloader/u-boot/.config ]; then \
		$(MAKE) -C src/bootloader/u-boot LicheePi_Zero_800x480LCD_defconfig; \
	fi)
	$(MAKE) -C src/$@
	cp $(PROJECT_ROOT)/src/bootloader/u-boot/u-boot-sunxi-with-spl.bin $(PROJECT_IMG)/loader

kernel:
	@(if [ ! -f $(PROJECT_ROOT)/src/kernel/linux/.config ]; then \
		$(MAKE) -C src/kernel/linux licheepi_zero_defconfig; \
	fi)
	$(MAKE) -C src/kernel/linux
	$(MAKE) -C src/kernel/linux INSTALL_MOD_PATH=$(PROJECT_INSTALL) modules
	$(MAKE) -C src/kernel/linux INSTALL_MOD_PATH=$(PROJECT_INSTALL) modules_install
	cp $(PROJECT_ROOT)/src/kernel/linux/arch/arm/boot/zImage $(PROJECT_IMG)/kernel
	cp $(PROJECT_ROOT)/src/kernel/linux/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dtb $(PROJECT_IMG)/dtb

sysapps:
	$(MAKE) -c src/sysapps


.PHONY: clean cleanall
clean:
	@for i in `echo $(CLEAN_DIRS)`; do \
		$(MAKE) -C $$i $@; \
	done

cleanall: clean
	@echo -e "\n\n CleanAll.............\n\n"


