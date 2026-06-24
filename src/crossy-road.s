org 0
MEMORY_TABLE
bal load_text
GREEN defw 0x0019 
BACK_RIGHT defw 0xFF3F 
BLUE defw 0x0002 
COUNTER defw 0xFFA4
MOVEMENT_DELAY defw 0x7000 
CURRENT_LOCATION defw 0xFF24 
LINK_TO_MOVEMENT_TABLE defw MOVEMENT_TABLE
NON_GREEN_ROWS defw 0x0000
LINK_TO_JUMP_TABLE defw JMP_TABLE
LINK_TO_ROW_TABLE defw ROW_TABLE
RED defw 0x00E0;
LINK_TO_SPEED_TABLE defw SPEED_TABLE
LINK_TO_PERIPHERAL_TABLE defw PERIPHERAL_TABLE
LINK_TO_RESET_VALUES defw RESET_VALUES


JMP_TABLE
update_grid_func DEFW update_grid;0
finished_cars_func DEFW finished_cars;1
check_collission_func DEFW check_collission;2
move_cars_func DEFW  move_cars;3
finished_checking_collision_func DEFW finished_checking_collision;4
increase_speed_func DEFW increase_speed;5
move_grid_func DEFW move_grid;6
return_func DEFW return;7
game_over_func DEFW game_over;8
not_reset_func DEFW not_reset;9
start_func DEFW start;10
check_reset_func DEFW check_reset;11
finished_movement_func DEFW finished_movement;12
display_score_func DEFW display_score;13
LINK_TO_SECOND_JUMP_TABLE DEFW SECOND_JUMP_TABLE

SECOND_JUMP_TABLE
link_to_check_pause defw check_pause ; 0 
link_to_finish_pause defw finish_pause ; 1

ROW_TABLE
ROW1 defw 0b11111111;0
ROW2 defw 0b00101000;1
ROW3 defw 0b10000001;2
ROW4 defw 0b00100010;3
ROW5 defw 0b11111111;4
ROW6 defw 0b10010000;5
ROW7 defw 0b10001000;6
ROW8 defw 0b11000000;7
TASK defw 0x0000;9
CLEAR_BIT_7 defw 0x007F;10
SET_BIT_7 defw 0x0080;11
OUTER defw 0x001F;12
INNER defw 0x0000;13
SET_OUTER defw 0x001F;14

RESET_VALUES
S_ROW1 defw 0b11111111;0
S_ROW2 defw 0b00101000;1
S_ROW3 defw 0b10000001;2
S_ROW4 defw 0b00100010;3
S_ROW5 defw 0b11111111;4
S_ROW6 defw 0b10010000;5
S_ROW7 defw 0b10001000;6
S_ROW8 defw 0b11000000;7
STARTING_LOCATION defw 0xFF24;8
RESET_OUTER defw 0x001F;14


SPEED_TABLE
SPEED defw 0x0000;
SCORE defw 0x0000;


PERIPHERAL_TABLE
VIBRATOR defw 0xFF96
VIBRATION_TIME defw 0xFFFF
RESET defw 0xFF95
BIT_5_PRESSED defw 0x0020
LINK_TO_LCD_SCREEN_TABLE defw LCD_SCREEN_TABLE
LINK_TO_NUMBERS_TABLE defw 0x0000 ; change
LINK_TO_STACK_SPACE defw STACK_SPACE
PAUASE defw 0xFF91

LCD_SCREEN_TABLE
LINE1 defw 0xFF40
S defw 0x53;
C defw 0x43
O defw 0x4f
R defw 0x52
E defw 0x45
colon defw 0x3A
 

MOVEMENT_TABLE
MOVE_RIGHT defw 0x0040 ; 6  
KEYPAD defw 0xFF94 ; 5 
MAX_LEFT defw 0xFF20;10
MAX_RIGHT defw 0xFF27;3
OUTER_MOVEMENT defw 0x0004;12
INNER_MOVEMENT defw 0x0000;13


STACK_SPACE:
HUNDREDS DEFW 0x0
TENS DEFW 0x0
UNITS DEFW 0x0

STACK_PTR DEFW STACK_BASE + 2
STACK_BASE EQU STACK_SPACE

ASCII_OFFSET DEFW 0x0030 ; 30 
UNIT_LOCATION DEFW 0xFF48 ;H 


load_text

;load the word score into the LCD screen
LD r1,[r0,#LINK_TO_PERIPHERAL_TABLE]
LD r1,[r1,#LINK_TO_LCD_SCREEN_TABLE-PERIPHERAL_TABLE]
LD r2,[r1,#LINE1-LCD_SCREEN_TABLE]

LD r3,[r1,#S-LCD_SCREEN_TABLE]
ST r3,[r2]
ADD r2,r2,#1

LD r3,[r1,#C-LCD_SCREEN_TABLE]
ST r3,[r2]
ADD r2,r2,#1

LD r3,[r1,#O-LCD_SCREEN_TABLE]
ST r3,[r2]
ADD r2,r2,#1

LD r3,[r1,#R-LCD_SCREEN_TABLE]
ST r3,[r2]
ADD r2,r2,#1

LD r3,[r1,#E-LCD_SCREEN_TABLE]
ST r3,[r2]
ADD r2,r2,#1

LD r3,[r1,#colon-LCD_SCREEN_TABLE]
ST r3,[r2]
ADD r2,r2,#1

bal start_state


start
LD r6,[r0,#LINK_TO_RESET_VALUES]
;reset global variables
ST r0,[r0,#NON_GREEN_ROWS]

;reset variables in the speed table
LD r1, [r0,#LINK_TO_SPEED_TABLE]
ST r0,[r1,#SPEED-SPEED_TABLE]
ST r0,[r1,#SCORE-SPEED_TABLE]

;reset row table
LD r1, [r0,#LINK_TO_ROW_TABLE]
LD r0, [r1,#TASK-ROW_TABLE]

LD r2, [r6,#RESET_OUTER-RESET_VALUES]
ST r2, [r1,#SET_OUTER-ROW_TABLE]

LD r2, [r6,#S_ROW1-RESET_VALUES]
ST r2, [r1,#ROW1-ROW_TABLE]

LD r2, [r6,#S_ROW2-RESET_VALUES]
ST r2, [r1,#ROW2-ROW_TABLE]

LD r2, [r6,#S_ROW3-RESET_VALUES]
ST r2, [r1,#ROW3-ROW_TABLE]

LD r2, [r6,#S_ROW4-RESET_VALUES]
ST r2, [r1,#ROW4-ROW_TABLE]

LD r2, [r6,#S_ROW5-RESET_VALUES]
ST r2, [r1,#ROW5-ROW_TABLE]

LD r2, [r6,#S_ROW6-RESET_VALUES]
ST r2, [r1,#ROW6-ROW_TABLE]

LD r2, [r6,#S_ROW7-RESET_VALUES]
ST r2, [r1,#ROW7-ROW_TABLE]

LD r2, [r6,#S_ROW8-RESET_VALUES]
ST r2, [r1,#ROW8-ROW_TABLE]

;reset text
LD r1,[r0,#LINK_TO_PERIPHERAL_TABLE]
LD r1,[r1,#LINK_TO_STACK_SPACE-PERIPHERAL_TABLE]
ST r0,[r1]
ADD r1,r1,#1
ST r0,[r1]
ADD r1,r1,#1
ST r0,[r1]


LD r1,[r0,#LINK_TO_JUMP_TABLE]
ADD r1,r1, #13

LD r7,[r1]

start_state

update_grid
LD r2, [r0,#LINK_TO_ROW_TABLE]
MOV r5,#7 ; init outer loop
   ; LD r3, [r1,#3] 
LD r6, [r0,#NON_GREEN_ROWS] ; green row or not variable
LD r1,[r0,#BACK_RIGHT] ;starting from the back row 


outer_loop
;get red 
LD r3 ,[r0,#LINK_TO_ROW_TABLE]
LD r3, [r0, #RED] ; load red 
CMP r6,r5
beq row_must_be_green
ADD r6,r6,#4
CMP r6,r5
bne row_must_not_be_green
row_must_be_green
MOV r3,#1 ; load green
LD r3,[r3]
row_must_not_be_green
SUB r6,r6,#4
    ; get the correct binary string that we are using 
    LD r2, [r0,#LINK_TO_ROW_TABLE] ; get row values
    LD r2,[r2,r5] ; row is now in r2
    ;set up the inner loop
    MOV r4,#8
inner_loop
        ANDS r0,r2,#1
        beq not_red
        ST r3,[r1] ; load red into that square
        bal skip
        not_red
        ST r0,[r1]
        skip
        ADD r2,r2,r0, RRC  ;shift bits by 1
       SUB r1,r1,#1 ; move to the next pixel to check
        SUB r4,r4,#1
        CMP r4,#0
        bne inner_loop
    SUB r5,r5,#1
    CMP r5,#0
    bge outer_loop

LD r6 ,[r0,#LINK_TO_ROW_TABLE]
LD r6, [r6,#TASK-ROW_TABLE]   
CMP r6,#1

Bne dont_return

LD r1, [r0,#LINK_TO_JUMP_TABLE]
ADD r1,r1, #7 
LD r7,[r1]

dont_return

CMP r6,#2
LD r1, [r0,#LINK_TO_JUMP_TABLE]
ADD r1,r1, #2 
LD r7,[r1]

; SET THE CHARACTER
LD r2, [r0,#BLUE] ; get blue
LD r3, [r0,#CURRENT_LOCATION]
ST r2, [r3] ; store the colour blue



CMP r6,#3
beq game_over


main
    bal manage_movement
    finished_movement

    LD r1,[r0,#LINK_TO_JUMP_TABLE]
    ADD r1,r1, #3
    LD r7,[r1]

    finished_cars
    finished_checking_collision
    
    LD r1,[r0,#LINK_TO_JUMP_TABLE]
    ADD r1,r1, #11
    LD r7,[r1]

    not_reset

    LD r1,[r0,#LINK_TO_JUMP_TABLE]
    ADD r1,r1, #14
    LD r1,[r1]
    LD r7,[r1]

    finish_pause

    
    bal main

end_game
    LD r1, [r0,#LINK_TO_ROW_TABLE]
    MOV r2, #3
    ST r2, [r1,#TASK-ROW_TABLE]
    bal move_grid

game_over
    LD r1,[r0,#LINK_TO_PERIPHERAL_TABLE]
    LD r2,[r1] ; load the buzzer
    LD r3,[r1,#VIBRATION_TIME-PERIPHERAL_TABLE]
    MOV r4,#1
    ST r4,[r2]
    continue_vibration
        SUB r3,r3,#1
        CMP r3,#0
        bne continue_vibration
    ST r0,[r2]

    finish
    LD r1,[r0,#LINK_TO_PERIPHERAL_TABLE]
    LD r2,[r1,#RESET-PERIPHERAL_TABLE]
    LD r2,[r2] ; get the value
    LD r3,[r1,#BIT_5_PRESSED-PERIPHERAL_TABLE]
    CMP r3,r2
    bne finish

    LD r1,[r0,#LINK_TO_JUMP_TABLE]
    ADD r1,r1, #10
    LD r7,[r1]


    


; r4 has the position of the player 

; USING r3-bit mask r4-player r2-users move r5-light storage r6 - check if 

manage_movement

LD r1, [r0,#LINK_TO_MOVEMENT_TABLE]
LD r2, [r1, #OUTER_MOVEMENT-MOVEMENT_TABLE]
LD r3, [r1, #INNER_MOVEMENT-MOVEMENT_TABLE]
LD r4, [r0,#COUNTER]
LD r4,[r4]
LD r5, [r0,#MOVEMENT_DELAY]

SUB r3,r4,r3
CMP r5,r3
bpl finished_movement
CMP r2,r0
beq movement_delay_done
SUB r2,r2,#1
ST r2,[r1,#OUTER_MOVEMENT-MOVEMENT_TABLE]
ST r4,[r1,#INNER_MOVEMENT-MOVEMENT_TABLE]
bal finished_movement
movement_delay_done
ADD r2,r2,#2
ST r2,[r1,#OUTER_MOVEMENT-MOVEMENT_TABLE]
ST r4,[r1,#INNER_MOVEMENT-MOVEMENT_TABLE]





LD r2, [r1, #KEYPAD-MOVEMENT_TABLE] ; get keypad address
LD r2, [r2]; get the value at keypad address

LD r4, [r0,#CURRENT_LOCATION]

check_up; check if '2' has been clicked
    MOV r3,#4 ; load clicking 2
    ANDS r0,r2,r3 ; check if 2 is clicked
    beq check_left; if not 
    SUB r5,r4,#8
    LD r5, [r5] ; get the colour of the position above
    LD r6,[r0,#RED]
    CMP r5,r6
    Beq end_game
    LD r6, [r0,#LINK_TO_ROW_TABLE]
    MOV r5,#1
    ST r5,[r6,#TASK-ROW_TABLE]
    ;add 1 to to the score 
    LD r1,[r0,#LINK_TO_SPEED_TABLE]
    LD r2,[r1,#SCORE-SPEED_TABLE]
    ADD r2,r2,#1
    ST r2,[r1,#SCORE-SPEED_TABLE]

    LD r1,[r0,#LINK_TO_JUMP_TABLE]
    ADD r1,r1, #5
    LD r7,[r1]
    


check_left
    ADD r3, r3,#12 ; load clicking 2
    ANDS r0,r2,r3 ; check if 4 is clicked
    beq check_right; if not 
    LD r5, [r1,#MAX_LEFT-MOVEMENT_TABLE]; check if in bounds
    CMP r5,r4
    beq check_right
    SUB r4,r4 ,#1
    ;check for collision
    LD r6,[r0,#RED]
    LD r5,[r4]
    CMP r5,r6
    beq detected_left

    LD r5, [r0,#BLUE];  
    ST r5, [r4]
    ST r4, [r0,#CURRENT_LOCATION]
    ADD r4,r4,#1
    bal prev
   ; LD r4,[r1,r3] ; row 7

    detected_left
    ADD r4,r4,#1
    ST r0,[r4] 
    SUB r4,r4,#1 
    bal complete_collission
    detected_right
    SUB r4,r4,#1
    ST r0,[r4] 
    ADD r4,r4,#1 

    complete_collission
    ST r6,[r4]
    bal game_over


   
check_right
    LD r3, [r1,#MOVE_RIGHT-MOVEMENT_TABLE]
    ANDS r0,r2,r3 ; check if 4 is clicked
    beq finished_movement; if not 
    LD r5, [r1,#MAX_RIGHT-MOVEMENT_TABLE]
    CMP r5,r4
    beq finished_movement
    ADD r4,r4 ,#1
    ;check for collision
    LD r6,[r0,#RED]
    LD r5,[r4]
    CMP r5,r6
    beq detected_right

    LD r5, [r0,#BLUE];  
    ST r5, [r4]
    ST r4, [r0,#CURRENT_LOCATION]
    SUB r4,r4,#1

    prev
    ;next check if it green or grey that needs to be added 
    LD r5,[r0,#GREEN-MEMORY_TABLE] ; pre empt greem
    LD r6, [r0,#NON_GREEN_ROWS] ; get if it is a green row or not 
    CMP r0,r6 ; checking if we are on a green row 
    beq is_green
    MOV r5,r0
    is_green
    ST r5, [r4]
    bal finished_movement





move_grid 

; get access to the row memory block

;r1 base
;r2 temp variable to store 8
;r3 loop variable
;r4 current row
;r5 row to copy to

LD r1,[r0,#LINK_TO_ROW_TABLE]
LD r2,[r1,#ROW8-ROW_TABLE] ; get the value of row8

MOV r3,#6
LD r4,[r1,#ROW7-ROW_TABLE] ; row 7
ADD r5,r1,#ROW8-ROW_TABLE ; row to copy to
move_row 
ST r4,[r5]
SUB r5,r5,#1
SUB r3,r3,#1
LD r4,[r1,r3] ; next row
CMP r3,#0
bge move_row
ST r2,[r5]
MOV r6,#1
MOV r1,#1
LD r2,[r0,#NON_GREEN_ROWS]
CMP r2,#3
bne add_one
ST r0,[r0,#NON_GREEN_ROWS] 
bal updated
add_one
ADD r2,r2,#1
ST r2,[r0,#NON_GREEN_ROWS] 
updated
LD r1, [r0,#LINK_TO_JUMP_TABLE] 
ld r7, [r1]
return

; copying thr blue counter to the right position 
;r1 base
;r2 number of non green rows / colour to be added
;r3 current position of player
;r4 green
copy_player
; colour for prev positon
LD r3,[r0,#CURRENT_LOCATION] 
ADD r3,r3,#8
LD r2, [r0,#NON_GREEN_ROWS] 
CMP r2,#1 ; meaning that the prev value is grey so add grey
MOV r4,r0
bne add_grey
LD r4,[r0,#GREEN] 
add_grey
ST r4,[r3]

; add colour for current 
SUB r3,r3,#8
LD r2, [r0,#BLUE]
ST r2, [r3]

bal update_score

;registers 
; r1base
; r2 loop variable 
; r3 current row 
; r4 removes bit 7
; r5 assigns bit 7

check_collission
LD r2,[r0,#CURRENT_LOCATION]
LD r2,[r2]
LD r3,[r0,#RED]
CMP r2,r3
bne not_over


LD r1,[r0,#LINK_TO_JUMP_TABLE]
ADD r1,r1, #8
LD r7,[r1]

not_over
; SET THE CHARACTER
LD r2, [r0,#BLUE] ; get blue
LD r3, [r0,#CURRENT_LOCATION]
ST r2, [r3] ; store the colour blue


LD r1,[r0,#LINK_TO_JUMP_TABLE]
ADD r1,r1, #4
LD r7,[r1]



move_cars


LD r2,[r0,#LINK_TO_ROW_TABLE]
LD r3, [r2,#OUTER-ROW_TABLE] ; load outer
LD r4, [r2,#INNER-ROW_TABLE] ; load inner
LD r5,[r0,#COUNTER] ; get the free running counter
LD r5,[r5] ; ge the value of the counter
LD r6, [r0,#MOVEMENT_DELAY] ; get the delay

SUB r4,r5,r4; find the difference between current and stored
CMP r6,r4
bmi not_fin
LD r1,[r0,#LINK_TO_JUMP_TABLE]
ADD r1,r1, #3
LD r7,[r1]
not_fin
CMP r3,r0
beq delay_done
SUB r3,r3,#1
ST r3,[r2,#OUTER-ROW_TABLE]
ST r5,[r2,#INNER-ROW_TABLE]
LD r1,[r0,#LINK_TO_JUMP_TABLE]
ADD r1,r1,#1
ld r7, [r1]
delay_done
LD r3, [r2,#SET_OUTER-ROW_TABLE] ; reset the counter
ST r3,[r2,#OUTER-ROW_TABLE]
ST r5,[r2,#INNER-ROW_TABLE]



LD r1,[r0,#LINK_TO_ROW_TABLE]

LD r3, [r1,#ROW8-ROW_TABLE] ; last row
LD r4, [r1,#CLEAR_BIT_7-ROW_TABLE] ; clear bit 7 MASK
LD r5, [r1,#SET_BIT_7-ROW_TABLE] ; set bit 7 MASK

MOV r2,#7
next_row
ORS r3,r3,r0,RRC
AND r3,r3,r4
bcc dont_set_bit
OR r3,r3,r5
dont_set_bit
ST r3, [r1,r2]
SUB r2,r2,#1
LD r3,[r1,r2]
CMP r2,#0
bne next_row

MOV r6,#2
ST r6,[r1,#TASK-ROW_TABLE]
LD r1, [r0,#LINK_TO_JUMP_TABLE] ; 10 (16)
ld r7, [r1]

increase_speed

LD r1,[r0,#LINK_TO_ROW_TABLE]
LD r4,[r0,#LINK_TO_SPEED_TABLE]
LD r2,[r4]

CMP r2,#6
bne increment
ST r0,[r4]
LD r3, [r1,#SET_OUTER-ROW_TABLE]
SUB r3,r3,#2
ST r3, [r1,#SET_OUTER-ROW_TABLE]


bal go_back
increment
ADD r2,r2,#1
ST r2, [r4]
go_back
LD r1,[r0,#LINK_TO_JUMP_TABLE]
ADD r1,r1, #6
LD r7,[r1]


check_reset
    LD r1,[r0,#LINK_TO_PERIPHERAL_TABLE]
    LD r2,[r1,#RESET-PERIPHERAL_TABLE]
    LD r2,[r2] ; get the value
    LD r3,[r1,#BIT_5_PRESSED-PERIPHERAL_TABLE]
    CMP r3,r2
    bne not_clicked

    LD r1,[r0,#LINK_TO_JUMP_TABLE]
    ADD r1,r1, #10
    LD r7,[r1]


    not_clicked
    LD r1,[r0,#LINK_TO_JUMP_TABLE]
    ADD r1,r1, #9
    LD r7,[r1]

update_score 
; load the stack for the score 
LD r1,[r0,#LINK_TO_PERIPHERAL_TABLE]
LD r1,[r1,#LINK_TO_STACK_SPACE-PERIPHERAL_TABLE]
LD r2,[r1,#STACK_PTR-STACK_SPACE] ; stack pointer 
LD r3 ,[r2] ; load the units
ADD r3,r3,#1
CMP r3,#10
beq update_tens
ST r3 ,[r2]
ST r2, [r1,#STACK_PTR-STACK_SPACE]
bal display_score


update_tens
SUB r2,r2,#1 ; move pointer to the tens
LD r3 ,[r2] ; load the tens
ADD r3,r3,#1
CMP r3,#10
beq update_hundreds
ST r3 ,[r2]
ADD r2,r2,#1
ST r0, [r2]
ST r2, [r1,#STACK_PTR-STACK_SPACE]

bal display_score


update_hundreds
SUB r2,r2,#1 ; move pointer to the tens
LD r3 ,[r2] ; load the hundreds
ADD r3,r3,#1
ST r3,[r2]
ADD r2,r2,#1
ST r0,[r2]
ADD r2,r2,#1
ST r0,[r2]
ST r2, [r1,#STACK_PTR-STACK_SPACE]

display_score

; load the stack for the score 
LD r1,[r0,#LINK_TO_PERIPHERAL_TABLE]
LD r1,[r1,#LINK_TO_STACK_SPACE-PERIPHERAL_TABLE]
LD r3,[r1,#UNIT_LOCATION-STACK_SPACE] 
LD r2,[r1,#STACK_PTR-STACK_SPACE] ; stack pointer 
LD r4,[r2] ; load the digit
LD r5,[r1,#ASCII_OFFSET-STACK_SPACE]
ADD r4,r4,r5

ST r4,[r3]

SUB r2,r2,#1
SUB r3,r3,#1
LD r4,[r2]
ADD r4,r4,r5
ST r4,[r3]

SUB r2,r2,#1
SUB r3,r3,#1
LD r4,[r2]
ADD r4,r4,r5
ST r4,[r3]

LD r1,[r0,#LINK_TO_JUMP_TABLE]
ADD r1,r1, #12
LD r7,[r1]

