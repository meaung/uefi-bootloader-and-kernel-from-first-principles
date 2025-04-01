struc Elf64_Addr
  align 8
  . rq 1
end struc

struc Elf64_Off
  align 8
  . rq 1
end struc

struc Elf64_Half
  align 2
  . rw 1
end struc

struc Elf64_Word
  align 4
  . rd 1
end struc

struc Elf64_Sword
  align 4
  . rd 1
end struc

struc Elf64_Xword
  align 8
  . rq 1
end struc

struc Elf64_Sxword
  align 8
  . rq 1
end struc

struc Elf64_Ehdr
  label .
  .e_ident      rb 16
  .e_type       Elf64_Half
  .e_machine    Elf64_Half
  .e_version    Elf64_Word
  .e_entry      Elf64_Addr
  .e_phoff      Elf64_Off
  .e_shoff      Elf64_Off
  .e_flags      Elf64_Word
  .e_ehsize     Elf64_Half
  .e_phentsize  Elf64_Half
  .e_phnum      Elf64_Half
  .e_shentsize  Elf64_Half
  .e_shnum      Elf64_Half
  .e_shstrndx   Elf64_Half
end struc

virtual at 0
  Elf64_Ehdr Elf64_Ehdr
end virtual

struc Elf64_Phdr
  label .
  .p_type     Elf64_Word
  .p_flags    Elf64_Word
  .p_offset   Elf64_Off
  .p_vaddr    Elf64_Addr
  .p_paddr    Elf64_Addr
  .p_filesz   Elf64_Xword
  .p_memsz    Elf64_Xword
  .p_align    Elf64_Xword
end struc

virtual at 0
  Elf64_Phdr Elf64_Phdr
end virtual
