# Compact Controller Task

This project demonstrates the implementation of a compact, interactive controller in a Swift-based application that can adjust its height based on user interaction, with a fixed width and animated transitions.

![ScreenRecording2024-11-15](https://github.com/user-attachments/assets/4c328de2-a2f2-4269-a623-83fc2eaa4ef7)

## Overview

The main goal of this project is to create a controller that opens upon button tap and allows the user to toggle between two heights using a switch. The controller features the following:

- **Fixed Width**: The controller always has a width of 300pt.
- **Height Toggle**: The controller’s height changes between 280pt and 150pt when a switch is toggled.
  - The default state shows a height of 280pt.
  - The second option changes the height to 150pt.
  - The height change is animated smoothly.
- **Close Button**: A close button located at the top-right corner dismisses the controller.
- **Triangle Attachment**: The controller is visually attached to the button using a triangle shape, centered at the top of the controller, pointing to the button.
