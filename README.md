# GodotGpuConwaysLife
This project is an implementation of [Conways Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life), running on a **fragment shader**

*Tested with Godot 3.5-stable*

## Constrains
- using only GLES2 features to allow web/mobile operation
- gdsript only (no custom modules needed)

## Main principle
- There are two Viewports (Front and Back)
- Each is containing a sprite, which displays the viewport-texture of the opposite VP.
- That way, the shader can read the texture of previous frame for current frame. (with 1 frame delay)

