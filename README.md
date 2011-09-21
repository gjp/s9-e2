# Colony

You're a soldier in an alien hive. It's been a pretty good life so far: dismember your enemies, feed choice bits to your queen; you know, the usual. Unfortunately, an aggressive new hive has spawned nearby. Their drones are leaving ineradicable pheromone trails all around their hive, gradually engulfing everything they encounter with their stink. Your own gatherers can't pass through this. If you enter their territory, you're attacked on scent. To make matters worse, your old queen is near the end of her life and you were just getting started on gathering the food to feed a new queen, who can fly off and start a new hive in fresh, better-smelling territory.  Of course you'll all be left behind to be torn limb from limb, but that's a bug's life.

### Map

The two hives start on opposite sides of a simple grid. All territory is initially unclaimed. Resource nodes are scattered semi-randomly around the grid.

### The Threat

The other hive is expanding their territory at an ever-increasing rate. You can only claim unclaimed territory, but they can claim yours.

### Resources
You can claim food nodes by moving to them. This enables your gatherers to find them, which enables a fixed income of resources from each claimed node after each turn. You can also carry food and walk it home or trade it, bucket-brigade style.

### Winning and Losing
*Win*: If your hive gathers N food, your new queen reaches maturity.
*Loss*: If the enemy hive engulfs all resource nodes or reaches the entrance to your hive, you all go down with your queen.

### Game rounds
The enemy hive has an expansion phase each round, beginning from their hive. This is an ever-increasing random walk from the existing edge of their territory.

- If the enemy encounters a Sentry (see below), movement is halted for a number of spaces equal to the soldier's HP.
- If the enemy encounters a resource node, it will attempt to engulf it.
- Enemy expansion is slowed but not stopped on spaces which contain a player pheromone trail.

### Player turns

Players draw up to two cards. Sample cards:

- Sentry: Place a marker which will cause an NPC soldier to park here, slowing enemy encroachment (many in deck)
- Speed boost: Move extra spaces during this turn
- Alien cologne: Pass through enemy territory without consequence
- Scavenge: Collect food while not on a resource node
- Enemy Scout: Player immediate loses N HP

### Movement 
Players move up to N spaces. Players automatically leave their own pheromone trail wherever they go. Players may capture a neutral resource node by moving to it, ending their turn. Movement in enemy territory is halved.

### Health
Players start with N health. They lose health per move while passing through enemy territory, as they are continually attacked by drones. Death ends a turn. Players may respawn at the hive on the next turn, but there's a resource penalty.

Players may eat food they are currently carrying in order to heal, at the end of their turn.

### Carrying resources
Players may choose to carry N food from a resource node, to heal, trade, or carry home.
