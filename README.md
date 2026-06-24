# MU0 Crossy Road Assembly Game

A Crossy Road-inspired game written in MU0 assembly for a custom MU0-style processor.

As part of my university course, I first implemented the MU0 CPU using Verilog. The Verilog files are not included in this repository because they are owned by the University of Manchester/course material. I then wrote this Crossy Road game in MU0 assembly and ran it on the processor.


Game Legend

* 🟥 Red squares = cars
* 🟦 Blue square = player character
* 🟩 Green squares = safe land

This is an infinite Crossy Road-style game. Instead of the player reaching a fixed end point, the game creates the illusion of continuous movement: when the player moves up, the whole map scrolls down. This makes it feel like the character is constantly progressing through an endless road.
<html>
<p align="center">
  <img src="assets/CRDemo.gif" width="700" height ='1000' >
</p>
</html>





## Features

- LED grid rendering
- Keypad movement controls
- Player movement: up, left, and right
- Moving cars
- Collision detection
- Score tracking on LCD display
- Pause and reset controls
- Game-over sound/vibration feedback
- Increasing speed as the game progresses

## How It Works

The game uses memory-mapped I/O to control the LED display, keypad, LCD screen, reset button, pause button, and sound/vibration output.

The player is shown on the LED grid and must move upward while avoiding cars. Each successful upward movement increases the score. The game ends when the player collides with a car.

## Main File

```text
src/crossy_road.asm
```

## Main Routines

| Routine | Purpose |
|---|---|
| `load_text` | Writes `SCORE:` to the LCD |
| `start` | Resets the game state |
| `update_grid` | Draws the LED grid |
| `manage_movement` | Handles keypad input |
| `move_cars` | Moves cars across rows |
| `check_collission` | Checks for collisions |
| `update_score` | Updates the score |
| `display_score` | Shows the score on the LCD |
| `game_over` | Handles game-over feedback |

## Notes

This project was created as part of a university computer systems course. The aim was to write a complete interactive game in assembly using a limited instruction set and memory-mapped hardware peripherals.