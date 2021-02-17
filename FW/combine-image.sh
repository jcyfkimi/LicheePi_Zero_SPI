#!/bin/sh

dd if=/dev/zero of=flashimg.bin bs=1M count=32
dd if=loader of=flashimg.bin bs=1K conv=notrunc
dd if=dtb of=flashimg.bin bs=1K seek=1024 conv=notrunc
dd if=kernel of=flashimg.bin bs=1K seek=1088 conv=notrunc
dd if=filesystem of=flashimg.bin bs=1K seek=5184 conv=notrunc

