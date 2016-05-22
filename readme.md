### Process
1. Choose a random point on the map based on the size of the map (will have to manually get sizes for all CUP maps)
* Using the number of players, scale the area of play and mission time limit
* Pick starting locations for both teams. Need to not be in sight of each other and should at least be three quarters of the distance to the objective away from each other.

### Info
Type:   2 Team PvP
Objective:  Sector / Eliminate

tl;dr - A redone DTAS better suited to playing Fight Night style missions without having to make new missions every week

#### Sector Objective
Why a sector objective?

1. Players need something to fight over. If there's no objective there's no reason for players to risk looking for the enemy. It's better to sit and wait for the enemy to find you so you can ambush them. BORING.

* Other objective types are more complicated to create in a randomly generated map or just don't make sense in a meeting engagement (both teams attacking). Sectors also work good for defensive missions which will be added later.

##### Control Style
There are two ways I think of to handle capture style. Full control and dominant control. 

* With a full control style one team would need to be the only team within the capture zone to start making capture progress. 

* With a dominant control style the team with the most players in the zone makes capture progress. If both teams have an equal number of players inside the zone then the zone becomes contested and neither team makes capture progress.

##### Capture Progress Style
To show the capture progress each team has made there can be two bars at the bottom of the screen. As the teams make progress the bars fill up.

As for how to go about calculating total capture progress, there are three different styles I think of. King of the Hill style, degrading King of the Hill style, and consecutive capture style.

* With King of the Hill style any progress made is saved throughout the duration of the mission. 

* With degrading King of the Hill style a team's capture progress will degrade if they haven't gained any in a while. It can be made to degrade faster the longer a team hasn't had control of the objective. I can see this system making for some good comebacks but it will make missions take longer.

* With consecutive capture style a team who has control of and then loses control of the sector will have their capture progress reset to zero. Depending on the time required to win it could make the objective very important or very unimportant. It might help end lopsided games faster but it might also cause easy wins if an enemy team doesn't go after the sector for whatever reason.


There can be capture progress bars shown (toggleable) at the bottom right of the screen. 

### Parameter Ideas

* AO Size Modifier:   Small (50%), Normal (100%), Large (150%)
* Time Limits:    Very Short (50%), Short (75%), Normal (100%), Long (125%), Very Long (150%)
* Show Enemy Starting Zones to:   Everybody, Nobody, OPFOR Only, BLUFOR Only

### Future Goals

* Allow creation of Attack/Defense missions.
* Option to provide a side objective (Destroy cache, destroy static vehicle, destroy tower, second cap point, etc)
* Option to allow assets (HMG Pickup Trucks, HMMVs, Transport Trucks, Littlebirds, etc)
* Allow admin to re-roll starting positions through briefing option?
* Save last used battlefield and add an option to reuse it on next mission start.
