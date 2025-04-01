all: bootableiso testqemu

bootableiso: efi.img tkernel tbootloader
	mcopy -o -i efi.img bootloader.efi ::/EFI/BOOT/BOOTX64.efi
	mcopy -o -i efi.img kernel ::/kernel
	mkdir -p isobuild
	cp efi.img isobuild
	xorriso -as mkisofs -R -f -e efi.img -no-emul-boot -o bootable.iso isobuild

efi.img:
	dd if=/dev/zero of=efi.img bs=1k count=1440
	mkfs.msdos -F 12 efi.img
	mmd -i efi.img ::/EFI
	mmd -i efi.img ::/EFI/BOOT

tkernel:
	./fasm2/fasm2 -n kernel.asm kernel

tbootloader:
	./fasm2/fasm2 -n bootloader.asm bootloader.efi

testqemu:
	cp OVMF_VARS_ORIGINAL.fd OVMF_VARS.fd
	qemu-system-x86_64 -drive if=pflash,format=raw,readonly=on,file=OVMF_CODE.fd -drive if=pflash,format=raw,file=OVMF_VARS.fd -cdrom bootable.iso

clean:
	rm -rf kernel bootloader.efi efi.img OVMF_VARS.fd isobuild OVMF_VARS.fd
