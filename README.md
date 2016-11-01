# Gmod Airdrop Addon
Airdrop addon created by Ryl ( https://steamcommunity.com/id/royalxvi/ ) 

## Basic Info

This is an addon which creates 'airdrops' which contain items that are defined in the config and 
each item has a rarity defining how likely it is to be in the drop.

## Airdrop Inventory Preview

![Inventory Example](https://i.gyazo.com/a47b22569d75104fbc36d27307f72132.png)

## Spawn Chance Percentages
These may change overtime, but this is how they are now:
- Common      - `33.333%`
- Uncommmon   - `26.666%`
- Unusual     - `20%`
- Rare        - `13.333%`
- Ultra Rare  - `6.666%`

## Setting It Up
Place in addons, then boot up server to let the addon set everything up.

The config file is located in `Airdrops-master/lua`.
It explains what everything does, so it's pretty easy to edit.

Nothing else will need to be editted / changed, otherwise you could
break the addon.

## Chat Commands ( ADMIN+ ONLY ) 
Only the ranks defined in the config can use these commands. To edit which ranks can
use them edit the `dropst.ranks` table. 
- !dropadd   - Adds a drop point where the player is aiming
- !forcedrop - Force the addon to spawn in airdrops 

## License

<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/InteractiveResource" property="dct:title" rel="dct:type">Airdrop Addon</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://steamcommunity.com/id/royalxvi/" property="cc:attributionName" rel="cc:attributionURL">Ryl</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License</a>.
