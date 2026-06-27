# Ovale Spell Priority for WotLK 3.3.5

This repository contains a maintained WotLK 3.3.5 version of the Ovale spell-priority addon, focused on practical rotation support for private/legacy 3.3.5 clients.

The project keeps the original addon structure and adds modernized default class scripts for level-aware single-target, AoE, cooldown, and utility suggestions.

## Highlights

- Restores missing embedded libraries required by the 3.3.5 client.
- Adds `SpellKnown(...)` support so rotations adapt while leveling.
- Splits single-target and multi-target suggestions into separate Ovale icons.
- Updates default rotations for all DPS and tank classes available in WotLK.
- Keeps disruptive utility spells behind options or tank-only contexts.

## Supported Classes

- Death Knight
- Druid
- Hunter
- Mage
- Paladin
- Priest
- Rogue
- Shaman
- Warlock
- Warrior

## Installation

1. Put the `Ovale` folder into `Interface/AddOns`.
2. Restart the client or run `/reload`.
3. Enable `Ovale Spell Priority` in the addon list.

## Notes

This is a legacy addon fork/update for World of Warcraft 3.3.5. The original Ovale addon was authored by Sidoine; this repository preserves the addon and updates the default behavior for a modern WotLK private-server workflow.
