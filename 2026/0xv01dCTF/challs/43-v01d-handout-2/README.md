# V01D Handout 2

- **Category:** Cryptography
- **Points:** 345
- **Solves:** 32
- **Difficulty:** -
- **URL:** https://0xv01d-ctf.xyz/challenges/97

## Description
V-7's drop was never the point. The drop was a pointer.<br>
<br>
Buried in the payload was a channel address and a tooling blob — the client every node runs to talk upward. We logged eleven seconds of that channel before it went quiet: one handshake, two signed orders, one warrant, and a broadcast nobody at our clearance is meant to read.<br>
<br>
The broadcast is addressed to <b>ARCHITECT</b>. You are not an architect. You are not even an observer — you are a stranger holding somebody else's radio.<br>
<br>
So become one. Three movements, in order. Nothing was left out of the client: every constant you are missing is sitting one movement below you.<br>
<br>
<b>I — THE HANDSHAKE</b><br>
<i>No one checked the discriminant before they shipped this.</i><br>
<i>Once the shape collapses, the group is not the group they promised you.</i><br>
<i>Down at the double root the tangents split, and both of them are rational.</i><br>
<i>An old friend is standing there wearing new clothes.</i><br>
<i>Look hard at what p minus one is built from before you despair.</i><br>
<br>
<b>II — THE ORDER</b><br>
<i>Nothing was reused. That is what they will tell you.</i><br>
<i>One order, then another, minutes apart, same hand, same pen.</i><br>
<i>Nudged — not repeated — and the size of the nudge is written into the client.</i><br>
<i>Carry both equations at once and the unknown has nowhere left to stand.</i><br>
<i>Everything in this movement is algebra. There is no lattice here. Stop looking.</i><br>
<br>
<b>III — THE WARRANT</b><br>
<i>A token you already hold. A token you are not allowed to hold.</i><br>
<i>Padding is part of the message, and part of the message is yours to write.</i><br>
<i>Prefix stays secret. That was never the problem.</i><br>
<i>Every internal state of that construction is a saved game.</i><br>
<i>Nothing stops you from pressing continue.</i><br>
<i>Do not forget how long the secret is. They told you.</i><br>
<br>
Offline. No service, no oracle, no bruteforce.<br>
The client is uncommented and complete — the scheme is fully specified there, nothing is hidden from you except key material.<br>
Reference solution runs in under one second. If your approach needs an hour of compute, it is not the intended one. The cost here is reading, not CPU.<br>
Python 3 only. One integer factorisation is convenient with sympy, and it is a factorisation that will not fight you.<br>
Part 1 taught you three attacks. None of them appear again.

## Connection
-

## Files
- `V01D_Handout2.7z`

## Instance
-

## Hints
None

<!-- Solve → write SOLVE.md here with the flag on top + method. -->
