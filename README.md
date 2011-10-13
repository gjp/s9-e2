# Colony: A cooperative turn-based console game

```
+--------------------------------------------------------------------------------+
|# . . . . .                                                               ~ ~ ~ |
|. . . . . * . . . . . . . . . . . . . .   . . 2 . .       ~ ~             ~ ~ ~ |
|          .                           .   . . ! . !     ~ ~ ~     ~ ~ ~ ~ ~ ~ ~ |
|          . . . . * . . !             . . . .   .       ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ |
|                        .                   .   .       ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ |
|                        . .                 1 . . ~     ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ |
|                          .                 . . * ~ ~ ~ ~ ~ O ~ ~ ~ ~ ~ ~ ~ ~ ~ |
|                      * . .                     . . . ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ |
|                      . . . . . . . . . . . . . . ~ ~ . ~ ~ ~ ~ ~ ~ O ~ ~ ~ ~ ~ |
|                                                  ~ ~ ~ ~ ~   ~ ~ ~ ~ ~ ~ ~ ~ ~ |
|                                                  ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ |
|                                                ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ |
|                                                  ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ O ~ ~ ~ |
|                                                  ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ |
|                                              ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ |
|                                            ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ |
|                                            ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ |
|                                        ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ |
|                                      ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ |
|                                            ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ # |
+--------------------------------------------------------------------------------+
Round 14: Your hive has 235 of 600 food.
Player 1: You have 10 HP, 0 food, and 5 moves
e to end turn, wasd to move, or play cards: (1) Alien Cologne (2) Sentry
```

You're a soldier in an alien hive. It's been a pretty good life so far: dismember your enemies, feed choice bits to your queen; you know, the usual. Unfortunately, an aggressive new hive has spawned nearby. Their drones are leaving ineradicable pheromone trails all around their hive, gradually engulfing everything they encounter with their stink. Your own gatherers can't pass through this. If you enter their territory, you're attacked on scent. To make matters worse, your old queen is near the end of her life and you were just getting started on gathering the food to feed a new queen, who can fly off and start a new hive in fresh, better-smelling territory. Of course you'll all be left behind to be torn limb from limb, but that's a bug's life.

### Map

The two hives start on opposite sides of a simple grid. All territory is initially unclaimed. Resource nodes are scattered semi-randomly around the grid.

### The Threat

The other hive is expanding their territory at an ever-increasing rate. You can only claim unclaimed territory, but they can claim yours.

### Resources
You can claim food nodes by moving to them. This enables your gatherers to find them, which enables a fixed income of resources from each claimed node after each turn. You can also gather food and carry it to your hive.

### Winning and Losing
*Win*: If your hive gathers N food, your new queen reaches maturity.
*Loss*: If the enemy reaches the entrance to your hive, you all go down with your queen.

### Game rounds
The enemy hive has an expansion phase each round, beginning from their hive. This is an accelerating random growth from the existing edge of their territory. The enemy also has a growth spurt each time it engulfs a resource node.

- If the enemy encounters a Sentry (see below), movement is halted for a number of spaces equal to the sentry's HP.
- Enemy expansion is slowed but not stopped on spaces which contain a player pheromone trail.

### Player turns

Players draw up to two cards. Sample cards:

- Sentry: Place some of your food in order to attract a mean-looking soldier
- Speed boost: Move extra spaces during this turn
- Scavenge: Collect food while not on a resource node
- Alien cologne: Pass through enemy territory without consequence

### Movement 
Players move up to 5 spaces by default. Players automatically leave their own pheromone trail wherever they go. Players may capture a neutral resource node by moving to it. Movement in enemy territory is halved.

### Health
Players start with 10 health. They lose health per move while passing through enemy territory, as they are continually attacked by drones. Death ends a turn. Players may respawn at the hive on the next turn, but there's a resource penalty.

### Carrying resources
Players may gather from a resource node. This may be carried home or used to attract Sentries.

## TODO:

- Game balance is hard.
- UX was the lowest priority for the original scope. The only way to make this more primitive would be to run it via Teletype.
- No mechanism for manual discard.
- Ferrying food home ought to be a desperation move; need motivation to guard nodes or do something cooperatively on the front lines rather than spamming sentries. 'cologne' is currently useless.
- Tightly-coupled code, why do you taunt me so?
- Game balance is really hard.
