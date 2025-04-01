include 'efi.inc'
include 'elf.inc'
include 'bootloaderstruct.inc'

macro unicoderdxto addr
  mov [rsp+7*8+48], rax
  mov [rsp+6*8+48], rbx
  mov [rsp+5*8+48], rcx

  lea rax, addr

  mov word [rax], '0'
  mov word [rax+2], 'x'

  mov r8, rdx
  rol r8, 8

  i = 0
  repeat 8
    mov rbx, r8
    shr rbx, 4
    and rbx, 0xf
    add rbx, 0x30
    xor rcx, rcx
    cmp rbx, 0x3a
    setge cl
    imul rcx, 7
    add rbx, rcx
    mov word [rax+i*4+4], bx

    mov rbx, r8
    and rbx, 0xf
    add rbx, 0x30
    xor rcx, rcx
    cmp rbx, 0x3a
    setge cl
    imul rcx, 7
    add rbx, rcx
    mov word [rax+i*4+2+4], bx

    rol r8, 8
    i = i + 1
  end repeat
  
  mov word [rax+i*4+4], 0

  mov rax, [rsp+7*8+48]
  mov rbx, [rsp+6*8+48]
  mov rcx, [rsp+5*8+48]
end macro

use64

BASE = 0x400000

org BASE

DosStub:
db 0x4d, 0x5a, 0x80, 0x00, 0x01, 0x00, 0x00, 0x00
db 0x04, 0x00, 0x10, 0x00, 0xff, 0xff, 0x00, 0x00
db 0x40, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db 0x00, 0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00
db 0x0e, 0x1f, 0xba, 0x0e, 0x00, 0xb4, 0x09, 0xcd
db 0x21, 0xb8, 0x01, 0x4c, 0xcd, 0x21, 0x54, 0x68
db 0x69, 0x73, 0x20, 0x70, 0x72, 0x6f, 0x67, 0x72
db 0x61, 0x6d, 0x20, 0x63, 0x61, 0x6e, 0x6e, 0x6f
db 0x74, 0x20, 0x62, 0x65, 0x20, 0x72, 0x75, 0x6e
db 0x20, 0x69, 0x6e, 0x20, 0x44, 0x4f, 0x53, 0x20
db 0x6d, 0x6f, 0x64, 0x65, 0x2e, 0x0d, 0x0a, 0x24
db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

PeSignature:
db 'PE', 0, 0

CoffFileHeader:
.Machine               dw 0x8664
.NumberOfSections      dw 2
.TimeDateStamp         dd %t and 0xffffffff
.PointerToSymbolTable  dd 0
.NumberOfSymbols       dd 0
.SizeOfOptionalHeader  dw SectionTable - PeOptionalHeader
.Characteristics       dw 0x0001 or 0x0002 or 0x0020 or 0x0200

PeOptionalHeader:
PeOptionalHeader.StandardFields:
.Magic                        dw 0x20b
.MajorLinkerVersion           db 0
.MinorLinkerVersion           db 0
.SizeOfCode                   dd 0xe00
.SizeOfInitializedData        dd 0x200
.SizeOfUninitializedData      dd 0
.AddressOfEntryPoint          dd 0x1000
.BaseOfCode                   dd 0x1000

PeOptionalHeader.WindowsSpecificFields:
.ImageBase                    dq BASE
.SectionAlignment             dd 0x1000
.FileAlignment                dd 0x200

.MajorOperatingSystemVersion  dw 0
.MinorOperatingSystemVersion  dw 0
.MajorImageVersion            dw 0
.MinorImageVersion            dw 0
.MajorSubsystemVersion        dw 0
.MinorSubsystemVersion        dw 0

.Win32VersionValue            dd 0
.SizeOfImage                  dd 0x10000
.SizeOfHeaders                dd HeadersEnd - DosStub
.CheckSum                     dd 0
.Subsystem                    dw 10
.DllCharacteristics           dw 0
.SizeOfStackReserve           dq 0x4000
.SizeOfStackCommit            dq 0x4000
.SizeOfHeapReserve            dq 0x40000
.SizeOfHeapCommit             dq 0
.LoaderFlags                  dd 0
.NumberOfRvaAndSizes          dd 0x10

PeOptionalHeader.DataDirectories:
PeOptionalHeader.DataDirectories.Export:
.VirtualAddress dd 0
.Size           dd 0
PeOptionalHeader.DataDirectories.Import:
.VirtualAddress dd 0
.Size           dd 0
PeOptionalHeader.DataDirectories.Resource:
.VirtualAddress dd 0
.Size           dd 0
PeOptionalHeader.DataDirectories.Exception:
.VirtualAddress dd 0
.Size           dd 0
PeOptionalHeader.DataDirectories.Certificate:
.VirtualAddress dd 0
.Size           dd 0
PeOptionalHeader.DataDirectories.BaseRelocation:
.VirtualAddress dd 0
.Size           dd 0
PeOptionalHeader.DataDirectories.Debug:
.VirtualAddress dd 0
.Size           dd 0
PeOptionalHeader.DataDirectories.Architecture:
.VirtualAddress dd 0
.Size           dd 0
PeOptionalHeader.DataDirectories.GlobalPtr:
.VirtualAddress dd 0
.Size           dd 0
PeOptionalHeader.DataDirectories.Tls:
.VirtualAddress dd 0
.Size           dd 0
PeOptionalHeader.DataDirectories.LoadConfig:
.VirtualAddress dd 0
.Size           dd 0
PeOptionalHeader.DataDirectories.BoundImport:
.VirtualAddress dd 0
.Size           dd 0
PeOptionalHeader.DataDirectories.Iat:
.VirtualAddress dd 0
.Size           dd 0
PeOptionalHeader.DataDirectories.DelayImportDescriptor:
.VirtualAddress dd 0
.Size           dd 0
PeOptionalHeader.DataDirectories.ClrRuntimeHeader:
.VirtualAddress dd 0
.Size           dd 0
PeOptionalHeader.DataDirectories.Reserved:
.VirtualAddress dd 0
.Size           dd 0

SectionTable:
SectionTable.Text:
.Name                 db '.text', 0, 0, 0
.VirtualSize          dd EndSectionText - BeginSectionText
.VirtualAddress       dd 0x1000
.SizeOfRawData        dd 0xe00
.PointerToRawData     dd 0x200
.PointerToRelocations dd 0
.PointerToLinenumbers dd 0
.NumberOfRelocations  dw 0
.NumberOfLinenumbers  dw 0
.Characteristics      dd 0x60000020

SectionTable.Data:
.Name                 db '.data', 0, 0, 0
.VirtualSize          dd EndSectionData - BeginSectionData
.VirtualAddress       dd 0x2000
.SizeOfRawData        dd 0x20000
.PointerToRawData     dd 0x1000
.PointerToRelocations dd 0
.PointerToLinenumbers dd 0
.NumberOfRelocations  dw 0
.NumberOfLinenumbers  dw 0
.Characteristics      dd 0xc0000040

HeadersEnd:

rb 0x200 - (HeadersEnd - DosStub)

org BASE + 0x1000
BeginSectionText:
main:

sub rsp, 8*8+48+8

mov [ImageHandle], rcx
mov [SystemTable], rdx

;; print rdx {
;mov rdx, rsp
;unicoderdxto [rsp]
;
;mov rax, [SystemTable]
;mov rcx, [rax+EFI_SYSTEM_TABLE.ConOut]
;lea rdx, [rsp]
;call [rcx+EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.OutputString]
;
;; }

mov rax, [SystemTable]
mov rcx, [rax+EFI_SYSTEM_TABLE.ConOut]
call [rcx+EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.ClearScreen]

mov rax, [SystemTable]
mov rcx, [rax+EFI_SYSTEM_TABLE.ConOut]
lea rdx, [HelloStr]
call [rcx+EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.OutputString]

;mov rax, [SystemTable]
;mov rax, [rax+EFI_SYSTEM_TABLE.BootServices]
;mov rcx, 0 ; AllocateAnyPages
;mov rdx, 2 ; EfiLoaderData
;mov r8, 1
;lea r9, [KernelAddress]
;call [rax+EFI_BOOT_SERVICES.AllocatePages]

mov rax, [SystemTable]
mov rax, [rax+EFI_SYSTEM_TABLE.BootServices]
mov rcx, [ImageHandle]
lea rdx, [efiLoadedImageProtocolGuid]
lea r8, [loadedImage]
call [rax+EFI_BOOT_SERVICES.HandleProtocol]

mov rax, [SystemTable]
mov rax, [rax+EFI_SYSTEM_TABLE.BootServices]
mov rcx, [loadedImage]
mov rcx, [rcx+EFI_LOADED_IMAGE_PROTOCOL.DeviceHandle]
lea rdx, [efiSimpleFileSystemProtocolGuid]
lea r8, [bootVolume]
call [rax+EFI_BOOT_SERVICES.HandleProtocol]


mov rax, [bootVolume]
mov rcx, [bootVolume]
lea rdx, [rootFile]
call [rax+EFI_SIMPLE_FILE_SYSTEM_PROTOCOL.OpenVolume]

mov rax, [rootFile]
mov rcx, [rootFile]
mov rdx, kernelFile
mov r8, fileName
mov r9, EFI_FILE_MODE_READ
mov r10, 0
mov [rsp + 4*8], r10
call [rax+EFI_FILE_PROTOCOL.Open]

mov rax, [kernelFile]
mov rcx, [kernelFile]
mov rdx, readSize
mov r8, KernelAddress
call [rax+EFI_FILE_PROTOCOL.Read]

mov rdx, [KernelAddress+Elf64_Ehdr.e_entry]
mov [KernelEntryPoint], rdx


;SystemTable->BootServices->LocateProtocol(&gopGuid, 0, (void **) &gop);
mov rax, [SystemTable]
mov rax, [rax+EFI_SYSTEM_TABLE.BootServices]
mov rcx, efiGraphicsOutputProtocolGuid
mov rdx, 0
mov r8, gop
call [rax+EFI_BOOT_SERVICES.LocateProtocol]

;gop->SetMode(gop, mode);
mov rax, [gop]
mov rcx, rax
mov rdx, 0
call [rax+EFI_GRAPHICS_OUTPUT_PROTOCOL.SetMode]

mov rbx, [gop]
xor rcx, rcx
mov rcx, [rbx+EFI_GRAPHICS_OUTPUT_PROTOCOL.Mode]
mov rdx, [rcx+EFI_GRAPHICS_OUTPUT_PROTOCOL_MODE.FrameBufferBase]
mov [bootloaderStruct+BOOTLOADER_STRUCT.framebufferAddress], rdx
mov rax, [rcx+EFI_GRAPHICS_OUTPUT_PROTOCOL_MODE.Info]
xor rdx, rdx
mov edx, [rax+EFI_GRAPHICS_OUTPUT_MODE_INFORMATION.PixelsPerScanLine]
mov [bootloaderStruct+BOOTLOADER_STRUCT.pixelsPerScanLine], rdx

;; print rdx {
;mov rdx, [bootloaderStruct+BOOTLOADER_STRUCT.pixelsPerScanLine]
;;xor rdx, rdx
;;mov dword edx, [rcx+EFI_GRAPHICS_OUTPUT_PROTOCOL_MODE.Mode]
;sub rsp, 40
;unicoderdxto [rsp]
;
;mov rax, [SystemTable]
;mov rcx, [rax+EFI_SYSTEM_TABLE.ConOut]
;lea rdx, [rsp]
;call [rcx+EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.OutputString]
;
;; }


mov rax, [SystemTable]
mov rax, [rax+EFI_SYSTEM_TABLE.BootServices]
mov rcx, MemoryMapSize
mov rdx, MemoryMap
mov r8, MapKey
mov r9, DescriptorSize
mov r10, DescriptorVersion
mov [rsp + 4*8], r10
call [rax+EFI_BOOT_SERVICES.GetMemoryMap]

; Off we go!
mov rax, [SystemTable]
mov rax, [rax+EFI_SYSTEM_TABLE.BootServices]
mov rcx, [ImageHandle]
mov rdx, [MapKey]
call [rax+EFI_BOOT_SERVICES.ExitBootServices]

;mov rcx, [FramebufferAddress]
;mov rdx, [PixelsPerScanLine]
;mov rcx, FramebufferAddress
mov rcx, bootloaderStruct
call [KernelEntryPoint]

; Halt and catch fire
add rsp, 8*8+48+8
ret

EndSectionText:

rb 0xe00 - (EndSectionText - BeginSectionText)

org BASE + 0x2000
BeginSectionData:

efiLoadedImageProtocolGuid      EFI_LOADED_IMAGE_PROTOCOL_GUID
efiSimpleFileSystemProtocolGuid EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID
efiFileInfoId                   EFI_FILE_INFO_ID
efiGraphicsOutputProtocolGuid   EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID

loadedImage                 EFI_LOADED_IMAGE_PROTOCOL
bootVolume                  EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL
rootFile                    UINTN
kernelFile                  UINTN
fileName                    du '\kernel', 0
readSize                    dq  1024

HelloStr                    du  'Loading kernel into memory...', 13, 10, 0
SystemTable                 dq  ?
ImageHandle                 dq  ?
KernelEntryPoint            dq  ?
MapKey                      UINTN
MemoryMapSize               dq  0x1000
DescriptorSize              dq  36
DescriptorVersion           dd  0
MemoryMap                   rb  0x1000

gop                         UINTN
bootloaderStruct            BOOTLOADER_STRUCT

ending                      db 0

EndNormalData:

rb 0x6000 - (EndNormalData - BeginSectionData)

org BASE + 0x8000
KernelAddress:                  rb  1024

EndSectionData:

rb 0x1ffff - (EndSectionData - BeginSectionData)
db 0
