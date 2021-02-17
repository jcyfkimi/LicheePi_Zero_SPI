PWD := $(shell pwd)
ARCH := arm

PROJ_KERNEL_MODULE_DIR = $(PROJECT_INSTALL)/lib/modules/4.10.15-licheepi-zero
KERNEL_DIR = $(PROJECT_KERNEL)/linux

DRV_NAME = hello_drv

obj-m := $(DRV_NAME).o

all:
	$(MAKE) ARCH=$(ARCH) -C $(KERNEL_DIR) M=$(PWD) CROSSCOMPILE=$(SOURCETOOLCHAIN) modules
	@install -D $(DRV_NAME).ko $(PROJ_KERNEL_MODULE_DIR)/$(DRV_NAME).ko

clean:
	@rm -rf .tmp_versions .*.cmd *.cmd *.symvers *.mod.o *.o *.ko
	@rm -rf $(PROJ_KERNEL_MODULE_DIR)/$(DRV_NAME).ko



