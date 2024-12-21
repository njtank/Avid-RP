## Update 6/29/2024
With the recent modifications I have added QB/ESX Support as well as inventory support for QB/PS/OX/QS/CODEM.

## Description
This resource lets you create usable crates, that will give the player items that you associate with them.

(Minor fork of: (https://github.com/JoeSzymkowiczFiveM/qb-lootcrate) I mainly modified this just to add a little more flare by incorporating the sound of a spinning wheel. May provide future updates.)

## Features
* Support for QB/ESX
* Supports common inventory systems
* Custom weighted chances to drop specific items
* Use local or remote images for spinner
* Create multiple cases, each with the own set of items
* Randomized, server-sided item selection and validation

## Credit
- [JoeSzymkowiczFiveM](https://github.com/JoeSzymkowiczFiveM/qb-lootcrate) I copied 100% of this and added some sound for immersion also removed potential copyrighted images.
- [Dimka Zheleznov](https://codepen.io/zheleznov) for the UI code and posting it to codepen. Wherever you are, hats off to you. I absolutely copied near-100% to make this work.

## Supported frameworks
- [qb-core](https://github.com/qbcore-framework/qb-core)
- [esx](https://github.com/esx-framework/esx_core)

## Supported Inventorys
- [qb-inventory](https://github.com/qbcore-framework/qb-inventory)
- [ox\_inventory](https://github.com/overextended/ox_inventory)
- [ps-inventory](https://github.com/Project-Sloth/ps-inventory)
- [qs-inventory](https://buy.quasar-store.com/package/4770732)
- [codem-inventory](https://codem.tebex.io/package/5900973)


## New Preview
[![dw_lootcrate](https://img.youtube.com/vi/1I88Y7o465Y/0.jpg)](https://www.youtube.com/watch?v=1I88Y7o465Y "dw_lootcrate")

## Shared items example
```lua
	['bumpbox']      = {
		['name'] = 'bumpbox',
		['label'] = 'Bump Loot Crate',
		['weight'] = 1000,
		['type'] = 'item',
		['image'] = 'bumpbox.png',
		['unique'] = false,
		['useable'] = true,
		['shouldClose'] = true,
		['combinable'] = nil,
		['description'] = 'Thank you for supporting Castaway <3'
	},

bumpbox                      = { name = 'bumpbox', label = 'Bump Loot Crate', weight = 1000, type = 'item', image = 'bumpbox.png', unique = 'false', useable = 'true', shouldClose = true, combinable = nil,  description = 'Thank you for supporting <servername> <3' },

```

## Discord for support
- [DWDevelopment](https://discord.gg/K7dgeVWNcR)

## Original creator
- [Joe Szymkowicz FiveM Development](https://discord.gg/5vPGxyCB4z)
