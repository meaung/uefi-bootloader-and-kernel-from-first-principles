struc BOOTLOADER_STRUCT
  label .
  .framebufferAddress  rq 1
  .pixelsPerScanLine   rq 1
end struc

virtual at 0
  BOOTLOADER_STRUCT BOOTLOADER_STRUCT
end virtual
