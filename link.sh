#/bin/bash

# Just a little script I made to make creating assemlby runnables easier

cp "$1.asm" "done/$1.asm"
cd "done"
nasm -f elf64 "$1.asm"
ld -m elf_x86_64 -s -o $1 "$1.o"
rm "$1.o"
rm "$1.asm"
