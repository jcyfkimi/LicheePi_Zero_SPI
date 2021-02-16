TOPDIR = ${shell pwd}

ifndef PROJECT_ROOT
	$(error You must first source the BSP environment: ". ./setenv")
endif

INSTALL_DIRS = bootloader kernel sysapps
CLEAN_DIRS = bootloader kernel sysapps

all: bootloader kernel sysapps

.PHONY: bootloader kernel sysapps

bootloader:
	$(MAKE) -C src/bootloader

kernel:
	$(MAKE) -C src/kernel

sysapps:
	$(MAKE) -c src/sysapps



