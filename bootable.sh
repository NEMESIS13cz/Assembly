#!/bin/bash

rm "done/floppy_boot/os.asm"
cp "os.asm" "done/floppy_boot/os.asm"
cd "done/floppy_boot"
nasm os.asm -f bin -o os.img
fallocate -l 1500k foo
cat os.img foo > boot.img
rm foo
rm os.img
