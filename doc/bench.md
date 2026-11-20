# Benchmark

The originals (`build/orig`, `tools/originals.sh`) and the ports
(`build/port`, `tools/ports.sh`), both at `-O2` against the same raylib,
measured one after the other by `tools/bench.py`, in the test mode of
raylib: no screen (the software renderer `rlsw` draws into memory), no
frame cap, no sound device. Each game runs one of its scripted runs
(`play` if it has one), cut at 1200 frames; each number is the median
of 3 runs. Machine: Intel(R) Xeon(R) Processor @ 2.10GHz, x86_64.

- **CPU/frame**: user and system time over the frames, in ms.
- **fps**: frames per second with no cap (wall time).
- **CPU at 60 fps**: what a core spends at 60 frames per second, from
  the CPU per frame (`60 x CPU/frame`); derived, not measured apart.
- **Memory**: peak resident set, in MB.
- **Binary**: size of the program, in KB (raylib linked in, both; the
  port also has the runtime of Atmos).

| Game | Run | Frames | CPU/frame C | CPU/frame Atmos | Atmos/C | fps C | fps Atmos | CPU at 60 fps C | CPU at 60 fps Atmos | Memory C | Memory Atmos | Binary C | Binary Atmos |
|------|-----|-------:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|----:|
| snake | play | 760 | 0.68 | 0.82 | 1.21 | 1465 | 1197 | 4% | 5% | 12.8 | 12.8 | 790 | 2314 |
| floppy | play | 1200 | 2.04 | 2.18 | 1.07 | 484 | 450 | 12% | 13% | 12.8 | 12.8 | 790 | 2294 |
| gold_fever | play | 1009 | 3.77 | 3.76 | 1.00 | 262 | 261 | 23% | 23% | 12.8 | 12.8 | 790 | 2330 |
| arkanoid | lose | 1200 | 3.12 | 3.29 | 1.05 | 317 | 300 | 19% | 20% | 12.8 | 12.7 | 790 | 2326 |
| asteroids_survival | seed3 | 1200 | 1.17 | 1.22 | 1.04 | 844 | 810 | 7% | 7% | 12.8 | 12.8 | 790 | 2330 |
| space_invaders | play | 1200 | 0.96 | 1.15 | 1.19 | 1029 | 862 | 6% | 7% | 12.8 | 12.8 | 790 | 2346 |
| missile_commander | play | 1200 | 1.60 | 1.65 | 1.03 | 617 | 590 | 10% | 10% | 12.8 | 12.7 | 790 | 2342 |
| gorilas | play | 648 | 3.35 | 3.29 | 0.98 | 292 | 302 | 20% | 20% | 12.8 | 12.8 | 790 | 2346 |
| asteroids | die | 577 | 1.01 | 0.97 | 0.97 | 973 | 1012 | 6% | 6% | 12.8 | 12.8 | 790 | 2370 |
| pang | play | 1200 | 1.08 | 1.15 | 1.07 | 914 | 857 | 6% | 7% | 12.8 | 12.8 | 790 | 2354 |
| platformer | play | 734 | 1.79 | 1.68 | 0.94 | 555 | 590 | 11% | 10% | 12.8 | 12.7 | 790 | 2342 |
| tetris | play | 1200 | 1.17 | 1.62 | 1.38 | 844 | 613 | 7% | 10% | 12.8 | 12.8 | 790 | 2435 |
| raylife | play | 800 | 2.67 | 2.56 | 0.96 | 370 | 383 | 16% | 15% | 22.4 | 15.3 | 790 | 2306 |
| wave_collector | lose | 1200 | 12.24 | 12.55 | 1.03 | 81 | 79 | 73% | 75% | 44.3 | 45.2 | 1363 | 2443 |
| repair | play | 1200 | 20.53 | 20.23 | 0.99 | 48 | 49 | 123% | 121% | 36.5 | 36.1 | 1363 | 2484 |
| cat_vs_roomba | play | 1200 | 18.83 | 19.95 | 1.06 | 53 | 50 | 113% | 120% | 25.9 | 26.5 | 1368 | 2560 |
| light_my_ritual | start | 1200 | 19.87 | 19.73 | 0.99 | 50 | 50 | 119% | 118% | 42.9 | 43.6 | 1367 | 2507 |
| transmission | play | 1200 | 9.09 | 9.23 | 1.02 | 109 | 107 | 55% | 55% | 29.0 | 29.5 | 1373 | 2484 |
| drturtle | play | 1200 | 37.34 | 37.89 | 1.01 | 27 | 26 | 224% | 227% | 29.4 | 29.9 | 1356 | 2395 |
| just_do | play | 1200 | 12.10 | 11.87 | 0.98 | 82 | 83 | 73% | 71% | 17.1 | 17.9 | 1383 | 2638 |
| skully_escape | play | 1200 | 10.62 | 10.65 | 1.00 | 93 | 93 | 64% | 64% | 32.4 | 33.0 | 1407 | 2618 |
| retro_maze_3d | play | 1200 | 7.23 | 7.18 | 0.99 | 137 | 138 | 43% | 43% | 13.9 | 14.4 | 1644 | 2727 |
| koala_seasons | play | 1200 | 35.54 | 36.60 | 1.03 | 28 | 27 | 213% | 220% | 52.9 | 54.6 | 1456 | 3849 |

Over the 23 games, the sum of the CPU per frame of the ports is 1.02 times
that of the originals. The frames of these games are mostly drawing: the
software renderer fills a window of up to 1280x720 pixels per frame,
which costs the same in both, and hides the cost of the logic. Above
100% at 60 fps, one core of this machine cannot draw 60 frames per
second in software, with the C as with the port; with a GPU, the
drawing leaves the CPU.

## The logic alone

The same runs with `RL_NODRAW=1`: the test mode of raylib rasterizes
nothing (no point, line, triangle, quad, nor clear writes a pixel) and
copies no screen, in the original and in the port alike. What is left
in a frame is the logic of the game and its calls of drawing, which
raylib still receives, batches and transforms. The time is the CPU of
the run minus the CPU of the same program run for 1 frame (its start:
the window, the assets), over the other frames, in µs; the whole frame
of the table above is beside it. The traces are the same with and
without the switch.

| Game | Run | Frames | Logic C (µs) | Logic Atmos (µs) | Atmos/C | Whole frame C (µs) | Whole frame Atmos (µs) |
|------|-----|-------:|----:|----:|----:|----:|----:|
| snake | play | 760 | 7.8 | 20.9 | 2.68 | 675 | 817 |
| floppy | play | 1200 | 37.5 | 137.6 | 3.67 | 2036 | 2178 |
| gold_fever | play | 1009 | 16.8 | 26.0 | 1.55 | 3767 | 3762 |
| arkanoid | lose | 1200 | 37.7 | 124.7 | 3.31 | 3124 | 3292 |
| asteroids_survival | seed3 | 1200 | 82.9 | 131.6 | 1.59 | 1169 | 1217 |
| space_invaders | play | 1200 | 79.5 | 305.7 | 3.85 | 962 | 1147 |
| missile_commander | play | 1200 | 13.7 | 40.1 | 2.93 | 1602 | 1652 |
| gorilas | play | 648 | 7.1 | 28.2 | 3.97 | 3353 | 3285 |
| asteroids | die | 577 | 53.2 | 35.1 | 0.66 | 1007 | 972 |
| pang | play | 1200 | 115.3 | 129.3 | 1.12 | 1080 | 1153 |
| platformer | play | 734 | 14.1 | 49.9 | 3.54 | 1791 | 1682 |
| tetris | play | 1200 | 82.1 | 240.1 | 2.92 | 1169 | 1617 |
| raylife | play | 800 | 337.8 | 268.5 | 0.79 | 2666 | 2558 |
| wave_collector | lose | 1200 | 128.8 | 375.6 | 2.92 | 12237 | 12555 |
| repair | play | 1200 | 11.6 | 19.6 | 1.69 | 20526 | 20234 |
| cat_vs_roomba | play | 1200 | 35.9 | 136.3 | 3.80 | 18829 | 19945 |
| light_my_ritual | start | 1200 | 77.5 | 97.0 | 1.25 | 19871 | 19726 |
| transmission | play | 1200 | 69.2 | 76.2 | 1.10 | 9091 | 9232 |
| drturtle | play | 1200 | 14.0 | 30.7 | 2.19 | 37340 | 37893 |
| just_do | play | 1200 | 18.1 | 25.0 | 1.38 | 12103 | 11873 |
| skully_escape | play | 1200 | 26.3 | 35.7 | 1.36 | 10616 | 10648 |
| retro_maze_3d | play | 1200 | 140.9 | 146.3 | 1.04 | 7229 | 7182 |
| koala_seasons | play | 1200 | 24.3 | 589.0 | 24.24 | 35544 | 36596 |

Over the 23 games, the sum of the logic of the ports is 2.14 times that
of the originals (3069 against 1432 µs for one frame of each game), where the
whole frames are 1.02 times.
Each number is the difference of two runs of a whole program, a few
tens of milliseconds in all: the small ones (under some 20 µs per frame)
carry the noise of the machine, and a ratio under 1 is within it.

## Stress: many entities

`tools/stress.py` builds space_invaders with a first wave of N enemies
(10 in the game) in a copy of the original and of the port; each runs
150 frames (the enemies come from the right and reach no one) with no
input; CPU per frame in ms, median of 3. In the port, each enemy is a
task; in the C, a slot of an array.

| Enemies | CPU/frame C | CPU/frame Atmos | Atmos/C |
|--------:|----:|----:|----:|
| 10 | 0.769 | 0.761 | 0.99 |
| 100 | 1.081 | 1.056 | 0.98 |
| 1000 | 1.623 | 2.174 | 1.34 |
| 5000 | 4.523 | 7.693 | 1.70 |

From 10 to 5000 enemies, each enemy adds 0.75 µs per frame in the C and
1.39 µs in the port (its move, its collision with the player and the
shots, and its drawing).

Not measured: a stress of `raylife` (its board of 250000 cells is C in
the port too, in a prelude, so it would measure the same C twice).
