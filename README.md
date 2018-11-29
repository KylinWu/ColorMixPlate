# ColorMixPlate
A color mix game based on ERC721 Non-Fungible Tokens (NFTs).

## Join the game
Call the function `register()` to get 5 default color cans.

These 5 cans RGB(255,0,0), RGB(0,255,0), RGB(0, 0, 255), RGB(0, 0, 0) and RGB(255, 255, 255) were `Red`, `Green`, `Blue`, `Black` and `White`, respectively.

These cans volume were pre-filled 100 units each.

## Play
### Mix color
Call the function `mixColor(FirstColorCanId, FirstColorCanVolume, SecondColorCanId, SecondColorCanVolume)`.

e.g., if you want to mix Red and White that inject 10 units each. Suppose these two color cans id were `0` and `4`, respectively.

You'd call `mixColor(0, 10, 4, 10)` then you'll got a new color can RGB(255, 128, 128) that volume is 20 units.
### Refill
The 5 default color cans are refillable. You'd call `refillCan(ColorCanId)` to refill one of the default cans;

e.g., if you  want to refill `Red` color can. Suppose the can id is `0`.

You'd call `refillCan(0)`.
