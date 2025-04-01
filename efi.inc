EFI_FILE_MODE_READ    := 0x0000000000000001
EFI_FILE_MODE_WRITE   := 0x0000000000000002
EFI_FILE_MODE_CREATE  := 0x8000000000000000

EFI_FILE_READ_ONLY  := 0x0000000000000001
EFI_FILE_HIDDEN     := 0x0000000000000002
EFI_FILE_SYSTEM     := 0x0000000000000004
EFI_FILE_RESERVED   := 0x0000000000000008
EFI_FILE_DIRECTORY  := 0x0000000000000010
EFI_FILE_ARCHIVE    := 0x0000000000000020
EFI_FILE_VALID_ATTR := 0x0000000000000037

struc UINT32
  align 4
  . rd 1
end struc

struc UINT64
  align 8
  . rq 1
end struc

struc UINTN
  align 8
  . rq 1
end struc

struc EFI_LOADED_IMAGE_PROTOCOL_GUID
  label .
  dd 0x5B1B31A1
  dw 0x9562
  dw 0x11d2
  db 0x8E, 0x3F, 0x00, 0xA0, 0xC9, 0x69, 0x72, 0x3B
end struc

struc EFI_SIMPLE_FILE_SYSTEM_PROTOCOL_GUID
  label .
  dd 0x0964e5b22
  dw 0x6459
  dw 0x11d2
  db 0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b
end struc

struc EFI_FILE_INFO_ID
  label .
  dd 0x09576e92
  dw 0x6d3f
  dw 0x11d2
  dw 0x8e39
  db 0x00,0xa0,0xc9,0x69,0x72,0x3b
end struc

struc EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID
  label .
  dd 0x9042a9de
  dw 0x23dc
  dw 0x4a38
  db 0x96,0xfb,0x7a,0xde,0xd0,0x80,0x51,0x6a
end struc

struc EFI_TABLE_HEADER
  label .
  .Signature  UINT64
  .Revision   UINT32
  .HeaderSize UINT32
  .CRC32      UINT32
  .Reserved   UINT32
end struc

virtual at 0
  EFI_TABLE_HEADER EFI_TABLE_HEADER
end virtual

struc EFI_SYSTEM_TABLE
  label .
  .Hdr                  EFI_TABLE_HEADER
  .FirmwareVendor       UINTN
  .FirmwareRevision     UINT32
  .ConsoleInHandle      UINTN
  .ConIn                UINTN
  .ConsoleOutHandle     UINTN
  .ConOut               UINTN
  .StandardErrorHandle  UINTN
  .StdErr               UINTN
  .RuntimeServices      UINTN
  .BootServices         UINTN
  .NumberOfTableEntries UINTN
  .ConfigurationTable   UINTN
end struc

virtual at 0
  EFI_SYSTEM_TABLE EFI_SYSTEM_TABLE
end virtual

struc EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL
  label .
  .Reset             UINTN
  .OutputString      UINTN
  .TestString        UINTN
  .QueryMode         UINTN
  .SetMode           UINTN
  .SetAttribute      UINTN
  .ClearScreen       UINTN
  .SetCursorPosition UINTN
  .EnableCursor      UINTN
  .Mode              UINTN
end struc

virtual at 0
  EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL
end virtual

struc EFI_BOOT_SERVICES
  label .
  .Hdr                                 EFI_TABLE_HEADER
  .RaiseTPL                            UINTN
  .RestoreTPL                          UINTN
  .AllocatePages                       UINTN
  .FreePages                           UINTN
  .GetMemoryMap                        UINTN
  .AllocatePool                        UINTN
  .FreePool                            UINTN
  .CreateEvent                         UINTN
  .SetTimer                            UINTN
  .WaitForEvent                        UINTN
  .SignalEvent                         UINTN
  .CloseEvent                          UINTN
  .CheckEvent                          UINTN
  .InstallProtocolInterface            UINTN
  .ReinstallProtocolInterface          UINTN
  .UninstallProtocolInterface          UINTN
  .HandleProtocol                      UINTN
  .Reserved                            UINTN
  .RegisterProtocolNotify              UINTN
  .LocateHandle                        UINTN
  .LocateDevicePath                    UINTN
  .InstallConfigurationTable           UINTN
  .LoadImage                           UINTN
  .StartImage                          UINTN
  .Exit                                UINTN
  .UnloadImage                         UINTN
  .ExitBootServices                    UINTN
  .GetNextMonotonicCount               UINTN
  .Stall                               UINTN
  .SetWatchdogTimer                    UINTN
  .ConnectController                   UINTN
  .DisconnectController                UINTN
  .OpenProtocol                        UINTN
  .CloseProtocol                       UINTN
  .OpenProtocolInformation             UINTN
  .ProtocolsPerHandle                  UINTN
  .LocateHandleBuffer                  UINTN
  .LocateProtocol                      UINTN
  .InstallMultipleProtocolInterfaces   UINTN
  .UninstallMultipleProtocolInterfaces UINTN
  .CalculateCrc32                      UINTN
  .CopyMem                             UINTN
  .SetMem                              UINTN
  .CreateEventEx                       UINTN
end struc

virtual at 0
  EFI_BOOT_SERVICES EFI_BOOT_SERVICES
end virtual

struc EFI_FILE_PROTOCOL
  label .
  .Revision       UINT64
  .Open           UINTN
  .Close          UINTN
  .Delete         UINTN
  .Read           UINTN
  .Write          UINTN
  .GetPosition    UINTN
  .SetPosition    UINTN
  .GetInfo        UINTN
  .SetInfo        UINTN
  .Flush          UINTN
  .OpenEx         UINTN
  .ReadEx         UINTN
  .WriteEx        UINTN
  .FlushEx        UINTN
end struc

virtual at 0
  EFI_FILE_PROTOCOL EFI_FILE_PROTOCOL
end virtual

struc EFI_LOADED_IMAGE_PROTOCOL
  label .
  .Revision         UINT32
  .ParentHandle     UINTN
  .SystemTable      UINTN
  .DeviceHandle     UINTN
  .FilePath         UINTN
  .Reserved         UINTN
  .LoadOptionsSize  UINT32
  .LoadOptions      UINTN
  .ImageBase        UINTN
  .ImageSize        UINTN
  .ImageCodeType    UINTN
  .ImageDataType    UINTN
  .Unload           UINTN
end struc

virtual at 0
  EFI_LOADED_IMAGE_PROTOCOL EFI_LOADED_IMAGE_PROTOCOL
end virtual

struc EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
  label .
  .Revision    UINT64
  .OpenVolume  UINTN
end struc

virtual at 0
  EFI_SIMPLE_FILE_SYSTEM_PROTOCOL EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
end virtual

struc EFI_MEMORY_DESCRIPTOR
  label .
  .Type           UINT32
  .PhysicalStart  UINTN
  .VirtualStart   UINTN
  .NumberOfPages  UINT64
  .Attribute      UINT64
end struc

virtual at 0
  EFI_MEMORY_DESCRIPTOR EFI_MEMORY_DESCRIPTOR
end virtual

struc EFI_GRAPHICS_OUTPUT_PROTOCOL
  label .
  .QueryMode    UINTN
  .SetMode      UINTN
  .Blt          UINTN
  .Mode         UINTN
end struc

virtual at 0
  EFI_GRAPHICS_OUTPUT_PROTOCOL EFI_GRAPHICS_OUTPUT_PROTOCOL
end virtual

struc EFI_GRAPHICS_OUTPUT_PROTOCOL_MODE
  label .
  .MaxMode         UINT32
  .Mode            UINT32
  .Info            UINTN
  .SizeOfInfo      UINTN
  .FrameBufferBase UINTN
  .FrameBufferSize UINTN
end struc

virtual at 0
  EFI_GRAPHICS_OUTPUT_PROTOCOL_MODE EFI_GRAPHICS_OUTPUT_PROTOCOL_MODE
end virtual

struc EFI_PIXEL_BITMASK
  label .
  .RedMask      UINT32
  .GreenMask    UINT32
  .BlueMask     UINT32
  .ReservedMask UINT32
end struc

virtual at 0
  EFI_PIXEL_BITMASK EFI_PIXEL_BITMASK
end virtual

struc EFI_GRAPHICS_OUTPUT_MODE_INFORMATION
  label .
  .Version              UINT32
  .HorizontalResolution UINT32
  .VerticalResolution   UINT32
  .PixelFormat          UINT32
  .PixelInformation     EFI_PIXEL_BITMASK
  .PixelsPerScanLine    UINT32
end struc

virtual at 0
  EFI_GRAPHICS_OUTPUT_MODE_INFORMATION EFI_GRAPHICS_OUTPUT_MODE_INFORMATION
end virtual
