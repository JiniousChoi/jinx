[ORG 0x00]
[BITS 16]

SECTION .text

jmp 0x07C0:START                    ; assign code segment and then jump to the label

START:
    mov ax, 0x07C0
    mov ds, ax                      ; data segment for memory access
    mov ax, 0xB800
    mov es, ax                      ; es mostly used for string manipulation
    mov si, 0

.SCREENCLEARLOOP:   ;do while
    mov byte [es:si], 0
    mov byte [es:si+1], 0x0A
    add si, 2
    cmp si, 80 * 25 * 2
    jl .SCREENCLEARLOOP

    mov si, 0                       ; si for source idx of string
    mov di, 0                       ; di for destination idx of string

.MESSAGELOOP:
    mov cl, byte [si + MESSAGE1]    ; same as [ds: si + MESSAGE1]
    cmp cl, 0
    je .MESSAGEEND

    mov byte [es:di], cl            ; memory(si) -> register(cl) -> memory(di)
    add si, 1
    add di, 2
    jmp .MESSAGELOOP

.MESSAGEEND:
    jmp $

MESSAGE1: db 'JINX OS Bootloader Start ...', 0

times 510-($-$$) db 0x00

db 0x55
db 0xAA
