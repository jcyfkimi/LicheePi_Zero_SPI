TOPDIR = ${shell pwd}

ifndef PROJECT_ROOT
	$(error You must first source the BSP environment: ". ./setenv")
endif

INSTALL_DIRS = src/bootloader src/kernel/linux src/rootfs src/sysapps
CLEAN_DIRS = src/bootloader src/kernel/linux src/rootfs src/sysapps

all: bootloader kernel sysapps rootfs FW

.PHONY: bootloader kernel sysapps rootfs FW

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
	$(MAKE) -C src/$@

rootfs:
	$(MAKE) -C src/$@

FW:
	@echo "Building Firmware Image"
	@rm -rf $(PROJECT_ROOT)/FW/loader $(PROJECT_ROOT)/FW/kernel $(PROJECT_ROOT)/dtb $(PROJECT_ROOT)/filesystem
	@ln -sf $(PROJECT_ROOT)/img/loader $(PROJECT_ROOT)/FW/loader
	@ln -sf $(PROJECT_ROOT)/img/kernel $(PROJECT_ROOT)/FW/kernel
	@ln -sf $(PROJECT_ROOT)/img/dtb $(PROJECT_ROOT)/FW/dtb
	@ln -sf $(PROJECT_ROOT)/img/fs.img $(PROJECT_ROOT)/FW/filesystem
	@cd $(PROJECT_ROOT)/FW; $(PROJECT_ROOT)/FW/combine-image.sh

.PHONY: clean cleanall
clean:
	@for i in `echo $(CLEAN_DIRS)`; do \
		$(MAKE) -C $$i $@; \
	done

cleanall: clean
	@echo -e "\n\n CleanAll.............\n\n"


