# spectralFilter
This is a script for Monome Norns Shield. In its current state it is a simple array of 16 filters (1 lp, 14 bp, 1 hp) in parallel. My intention is to use it with a 16n faderbank to control all the filter amplitudes (a0-a15) but you can also use the Norns encoders to select specific bands to edit.

For ease of use there is also a randomization button.

1. Use Maiden to place the files in the same folder structure in the 'code' folder.
2. Restart Norns to load the SuperCollider engine
3. Load the lua script either via Norns or Maiden
