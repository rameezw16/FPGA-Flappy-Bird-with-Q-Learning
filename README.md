# FPGA Flappy Bird with Q-Learning

A Flappy Bird game implementation on FPGA featuring autonomous AI gameplay using Q-Learning.

## Overview
This project implements the classic Flappy Bird game on an FPGA with:
- **VGA Display**: 640x480 resolution graphics output showing the bird, moving pipes, and score
- **Game Logic**: Finite state machine managing game states and collision detection
- **AI Control**: Q-Learning algorithm that trains the bird to navigate obstacles autonomously
- **Score Display**: 7-segment display showing current game score

## Key Components
- **vga640x480**: Renders game graphics and handles pixel generation at 25MHz
- **bird**: Controls bird physics including velocity, gravity, and jumping
- **pipes**: Generates and manages obstacle pipes with random heights
- **GameStateCalculator**: Extracts state features (distances to pipes and bird position)
- **QLearningController**: Learns optimal jump actions using Q-Learning with reward/penalty system
- **clockdiv**: Provides necessary clock frequencies (25MHz pixel clock, 381Hz display clock)
- **Collision Detection**: Real-time detection of collisions between bird and pipes/boundaries
