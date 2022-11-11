# Frog universe

- Category : Misc
- Difficulty : easy
- Final point value : 477
- Number of solves : 7

Every CTF has a remote algorithmics challenge, and I usuallly enjoy solving them. Though this one was tagged "easy", it turned out to be solved by only 7 teams out of 680...

## Challenge description

Welcome to Frog Universe! Can you wander to the flag and back to actually receive it? If you encounter a frog or nebula, it's game over. Thankfully, frogs will 'ribbit,' 'giggle,' and 'chirp,' and nebulas will 'light,' 'dust,' and 'dense.'
```
nc pwn.chall.pwnoh.io 13380
```
Associated file : [maze.py](./maze.py)

## Server source code review

Here are the information we can gather by reading the server source code and playing around with it using `netcat` :
- we are playing in a square grid of size `M=2034`, and with spawn in the angle of coordinates `(M - 1, 0)`;
- a flag is located in a random tile of the opposite quarter of the grid, but we know its coordinate (note: according to what was said in the Discord CTF, this might have been unintended);
- to win, we have to get to the flag tile and then back to our spawnpoint
- in this maze the "walls" are tiles containing a "frog" or a "nebula". Walking on these tiles would kill you and end the game;
- exactly one frog or nebula is spawned randomly in each `3x3` chunk of the game grid. In the spawn chunk and in the flag chunk, it may happen that the frog/nebula is overwritten by the spawnpoint/flag though;
- one can move in the four cardinal directions by sending `w`, `a`, `s` or `d`
- every time we move to a new free tile, we receive warnings about the dangers around us : each frog and nebula in an adjacent tile will produce a warning. So, we can receive up to three warnings per move. After each move we also receive our new coordinates, which is could be useful for debugging
- there is no pattern indicating the end of the warnings after a move. That will be quite annoying when scripting a solution, we'll have to wait until the servers stops sending.
- when trying to move out of bounds, we just virtually move to the tile we are already on. This means that we can get the warnings for the spawn tile by walking toward the grid boundary (`s` or `a`)

## Strategy design

We first observe that the maze is really scarce : only one obstacle per `3x3` chunk. This means that the [Manhattan distance](https://en.wikipedia.org/wiki/Taxicab_geometry) will be a very good approximation of the shortest path length between two points. So if we have to do any pathfinding, we'll use [A*](https://en.wikipedia.org/wiki/A*_search_algorithm) with the Manhattan distance as the guiding heuristic.

Then, I tried to solve some very small instances of the problem with pen and paper. I quickly found out that some cases are not deterministically solvable. See for instance this situation, where `0` is a free tile and `1` is a frog, our spawnpoint being in the bottom left.
```
| 0 0 0
| 1 0 0
| 0 0 0
  - - -
```
In this situation, we start by going South (`s`) to get information about the surroundings of the spawn point. We receive one warning about a frog in an adjacent tile. Now it is impossible to know wether we are in the situation illustrated by the previous plan or by the following one :
```
| 0 0 0
| 0 0 0
| 0 1 0
  - - -
```
And in a similar way, the following two situations are indistinguishable :
```
| 0                     | 1
| 0 1 0                 | 0 0 0
| 0 0 0                 | 0 0 1
| 0 0 0 1               | 0 0 0 0
  - - - -                 - - - -
```
The first of the two tricky situations exposed here is quite likely to happen (probability of `2/9 = 0.22`), but the other one is already much less likely to happen (`2/(9*9*9) = 0.0027` if there were only frogs as dangers, and this probability is even decreased if we take into account the fact that one of the two frogs could be a nebula and thus remove the ambiguity). So we may end up in situation where deterministic play is impossible, but except for the first case exposed here (which is immediately identified at the start of the game), they will be very uncommon.

Now, what we will try to do is to exploit the warnings to get as much knowledge as we can about the position of the obstacles. For that, we will need some datastructure that holds the possible values for each tile (`0`: free, `1`: frog, `3`: nebula, `5`: flag), and keep it updated with the information we get from the warnings. Here are some heuristics one could easily come up with :
- moving to a new tile raises no warnings -> all 4 adjacent tiles are free
- moving to a new tile raises one warning, and we already know that 3 of the adjacent tiles are free -> the fourth one contains the frog/nebula
- we are sure that one tile contains a frog/nebula -> the 8 other tiles in the `3x3` chunk are free or flag
- we know that 8 tiles out of the 9 in a chunk (which is not the spawn or flag chunk=) are free -> the 9th one contains a frog or nebula
- if a warning is found to target only tiles that lie in a common chunk, then hte other tiles of this chunk are free

Now we will try to move around in the maze and uncover it step by step. Time to code.

## Coding the solution

I wrote my solution in Python, you'll find the final script [here](exploit.py). Now some explanations on how it works.

To communicate with the server, I used [pwntools](https://docs.pwntools.com/en/stable/intro.html), which is very convenient in that kind of challenges because you can write your exploit locally and once it works, you just have to change one line to make it communicate with the server instead of your local copy. It also has an interesting `can_recv` function that tells whether we could actually receive more bytes from the server or not. Quite useful to know whether we have received all the warnings or not.

In the `__init__` function you will see that we represent the maze using an array of sets containing all the possible values for each cell. A few other useful data structures are defined in the `explore` function, we'll talk about them later. We then have many boring utility functions to know in which directions we can walk, if a tile is safe, how a moving instruction transforms the position, etc.

The `move` and `update_chunk` instructions are probably the more complicated functions, because they implement all the heuristics we told about, using the warnings received after a move to update our knowledge of the maze. I commented the code of these functions so you can match their different parts with the heuristics exposed in the previous section.

Then I have a `get_path` functions that computes a path from the current position to any other tile. This functions uses the A* algortihm with the Manhattan distance as a guiding heuristic. Note that I did not fully optimize the algorithm : to achieve a better worst case complexity, I should have used a priority queue for the `openSet` variable. But my guess was that most of the requested paths would be very short and thus woould not need such an optimization. This function is then used in a `goto` function that calculates the path and then walk along it.

Ok, now we can move wherever we want along the tiles that are free for sure, what should we do ? I first considered trying to explore the entire maze, then move to the flag and then back to the exit. But since we already know where the flag is, we can use an A*-like mechanism to guide our exploration toward the flag. This is done in the `explore` function, and this time I am using a priority queue. The function stops exploring prematurely if the flag is found. Note that the exploration logic is inside a loop, because it may happen that at some point in the exploration we uncover information that would have helped us in a previous part of the exploration. So, if we haven't found the flag after a first pass but updated our knowledge of the maze, we do another pass to see if we can use that knowledge, as many time as necessary.

## Running the exploit

I first tried on a smaller instance of the problem in order to debug my code and develop the heuristics. Then I tried the full size problem locally, and after a few restarts because of indistinguishable situations, I managed to get the flag after a few minutes. But playing against the remote server took an awfully long time (approximately 45 minutes), because of all the packet transfer between the client and the server. So anyway, I was monitoring the progress on Wireshark and finally got the flag. At that time I was the third one to get it, by the end only 7 teams found it.

