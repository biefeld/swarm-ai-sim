# Swarm-Based AI Simulation Prototype

A simple 2D game prototype built in Lua, simulating swarm-based AI for enemy entities. Inspired by the dynamic fish AI in [*Dave the Diver*](https://store.steampowered.com/app/1868140/DAVE_THE_DIVER/), where schools of fish move realistically and react to environmental stimuli, I wanted to recreate similar patterns using Lua's lightweight scripting capabilities. 

The **LÖVE Framework** was employed as a 2D game engine for rendering, input handling, and window management.

## Running

1. Ensure you have [LÖVE](https://love2d.org/) installed on your system.
2. Configure debug settings in [config.json](db/config.json)
3. Navigate to the project directory and run the game:
   ```bash
   love .
   ```


## Usage

- Use arrow keys or WASD to move the player.
- Avoid enemy swarms to survive.

## Key Learnings and Reflections

This project was an excellent opportunity to dive deep into Lua's unique features and apply them to game development and AI programming. Here are some key learnings:

- **Lua and Code Structure**: Leveraged Lua's tables as versatile data structures for arrays, dictionaries, objects, and classes to create flexible game entities; adopted the 30log library for object-oriented programming, enabling clean inheritance and modular design; and organized the codebase into separate files (e.g., `objects/`, `lib/`) to improve maintainability and experimentation.
- **Physics Implementation**: Experimented with multiple approaches for player and fish movement physics, including velocity-based systems, force accumulators, and kinematic equations, as well as various camera control methods like fixed, follow, and smooth interpolation. Ultimately settled on a simple velocity-based system with linear interpolation for camera tracking to balance performance and realism.
- **Random AI Movement**: Implemented random movement patterns inspired by *Dave the Diver*, where fish select random target points and angles, then tween smoothly using mathematical interpolation (e.g., linear and easing functions). This created natural, unpredictable behavior without complex pathfinding.
- **Collision Masks**: Used simple bitmask-based collision detection to categorize objects (e.g., player, enemies, walls) and efficiently determine interactions, avoiding unnecessary checks and improving performance in dense environments.


## Future Improvements

Based on the project's current state and planned features, here are potential enhancements:

- **Enhanced Enemy AI**: Implement Perlin noise or other random noise for smoother, more natural enemy movement patterns. Add player detection with a hostile state and adjustable detection radius for dynamic behavior.
- **Pathfinding and Combat**: Integrate pathfinding libraries for enemies to pursue the player intelligently. Develop a damage system with health bars for enemies (extending the existing PlayerHealthBar class).
- **Inventory and UI Systems**: Add an inventory menu using a UI library, allowing players to collect items or manage resources.
- **Visual and Physics Fixes**: Correct enemy hitbox/sprite alignment when rotated at angles. Improve collision detection for better accuracy.
- **Gamestate Management**: Refine the gamestate system for better handling of life, collisions, and enums for fixture names to simplify comparisons.
- **Performance Optimizations**: Optimize rendering and physics updates for larger swarms, potentially using spatial partitioning.
- **Additional Features**: Expand level design with procedural generation, add sound effects/music, and implement save/load functionality for game progress.
