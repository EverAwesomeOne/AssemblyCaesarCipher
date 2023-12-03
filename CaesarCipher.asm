; Chloe Duncan
; 12 March 2022
; TCSS 372, Professor Fowler
;
; Routines Extra Credit : Caesar Cipher
;
             .ORIG  x3000
;
MAIN         JSR PROMPT                         ; display TYPEMSG and get char
                                                ; get encryption key
                                                ; if char is (E) and encrypt
                                                ; else if char is (D) then decrypt
                                                ; print result
             AND        R0, R0, #0              ; clear R0
             LEA        R0, AGAIN               ; load start address of AGAIN in R0
             PUTS                               ; display PROMPT
             GETC                               ; read char into R0
             OUT
             AND        R1, R1, #0              ; clear R1
             LEA        R1, ASCII_Y             ; load address of ASCII_Y into R1
             LDR        R1, R1, #0              ; load contents of ASCII_Y into R1
             ADD        R1, R1, R0              ; subtract R0 and R1
             
             BRz MAIN                           ; if 0, user typed 'Y' ; loop program
;
             HALT                               ; End of the program
;
; Subroutine to get cipher type and key
PROMPT       ; load TYPEMSG prompt, get user input
             AND        R0, R0, #0              ; clear R0
             LEA        R0, TYPEMSG             ; load start address of TYPEMSG in R0
             PUTS                               ; display PROMPT
             GETC                               ; read char into R0
             OUT                                ; write char from R0 to monitor
             
             ; store user (E or D) char in R0 into R1, and load ASCII E into R2 for future calculation
             AND        R1, R1, #0              ; clear R1
             AND        R2, R2, #0              ; clear R2
             ADD        R1, R1, R0              ; Add R0 into R1
             LEA        R2, ASCII_E             ; Load address of ASCII_E into R2.
             LDR        R2, R2, #0              ; Load contents of ASCII_E into R2 (R2 now holds -69).
            
             ; load KEYMSG prompt, get user input
             AND        R0, R0, #0              ; clear R0
             LEA        R0, KEYMSG              ; load start address of KEYMSG in R0
             PUTS                               ; display KEYMSG
             GETC                               ; read char into R0
             OUT                                ; write char from R0 to monitor
             
             ; store user (encryption key) char in R0 into R3
             AND        R3, R3, #0              ; clear R3
             ADD        R3, R3, R0              ; Add R0 into R3
             
             ; load USERMSG prompt
             AND        R0, R0, #0              ; clear R0
             LEA        R0, USERMSG             ; load start address of USERMSG in R0
             PUTS                               ; display USERMSG
             
             ; get user input
             AND        R4, R4, #0              ; clear R4
             LEA        R4, USERSTR             ; load start address of USERSTR
             BR         LOOP                    ; subroutine to get and store String
;             
; Subroutine to get user String
LOOP         GETC
             OUT
             STR        R0, R4, #0
             ADD        R4, R4, #1
             ADD        R0, R0, -10
             BRnp       LOOP                    ; keep looping until user uses enter key
             BR         NEXT                    ; branch to NEXT
;             
; Subroutine to determine encrypt or decrypt, then branch
NEXT         ADD        R2, R2, R1              ; Subtract ASCII_E from the read in char value (R1), and store in R2.
             BRz        ENCRYPT                 ; if R1 is now zero, user typed 'E' and we branch to ENCRYPT
             BRnp       DECRYPT                 ; else, branch to DECRYPT
             
             RET
;            
; Subroutine to encrypt message with given key
ENCRYPT      
            AND         R0, R0, #0              ; clear R0
            LEA         R0, ENCRYPTMSG
            PUTS
            
            RET
;
; Subroutine to decrypt message with given key
DECRYPT      
            AND         R0, R0, #0              ; clear R0
            LEA         R0, DECRYPTMSG
            PUTS
            
            RET
;
; Data or Addresses        
TYPEMSG     .STRINGZ    "\n\nType (E)ncrypt/ (D)ecrypt: "    
KEYMSG      .STRINGZ    "\nEnter encryption key(1-9): "
USERMSG     .STRINGZ    "\nEnter message (20 char limit): "
ERRORMSG    .STRINGZ    "\nPlease enter a valid input."
ENCRYPTMSG  .STRINGZ    "\nEncrypting..."
DECRYPTMSG  .STRINGZ    "\nDecrypting..."
AGAIN       .STRINGZ    "\n\nGo Again [Y/N]? "
ASCII_E     .FILL       #-69                                  ; 69 is hex for character E
ASCII_Y     .FILL       #-89                                  ; 89 is hex for character Y
USERSTR     .BLKW       #14                                   ; allocate space for user string (13 hex = 20 dec) ; one more space for enter char

;          
            .END