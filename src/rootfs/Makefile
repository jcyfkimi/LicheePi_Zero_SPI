ROOT_DIR=$(PROJECT_ROOT)/img/fs/root

ROOT_IMAGE = fs.img

all: fs-image install

fs-image: _rootfs
	@rm -rf $(ROOT_IMAGE)
	@mkfs.jffs2 -s 0x100 -e 0x10000 -p 0x1AF0000 -d $(ROOT_DIR) -o $(ROOT_IMAGE)
	@echo "root filesystem is generated..."
	@ls -l $(ROOT_IMAGE)
	@chmod 666 $(ROOT_IMAGE)

_rootfs:
	@rm -rf $(ROOT_DIR)
	install -m 755 -d $(ROOT_DIR)
	cp -aR * $(ROOT_DIR)
	cp -aR $(PROJECT_ROOT)/img/fs/shadow_root/* $(ROOT_DIR)
	rm -rf $(ROOT_DIR)/Makefile
	find $(ROOT_DIR) -name ".git" | xargs rm -rf
	du -h $(ROOT_DIR)

install: fs-image
	cp -f $(ROOT_IMAGE) $(PROJECT_ROOT)/img
	
clean:
	@rm -rf $(ROOT_IMAGE)

distclean:
	@echo "clean shadow root from $(ROOT_DIR)/fs"
	rm -rf $(ROOT_IMAGE) $(ROOT_DIR)
	rm -rf $(ROOT_DIR)/fs/shadow_root


