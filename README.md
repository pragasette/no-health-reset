# No Health Reset

_No Health Reset_ is a mod for [The Elder Scrolls V: Skyrim][Skyrim] to revert
full health recovery, which occurs when the player sleeps and levels up.

It is intended to work with any mod which reduces or zeroes health
regeneration, such as [No Health Regen] or [Realistic Health Regeneration].

It can also be used to emulate a similar feature present in [Requiem] [until
version 2.0.2][#1], for instance if using a port to Special Edition, for which
the corresponding SKSE plugin was not converted, or a later release, in which
[the feature was removed][#1].

## Requirements

- [The Elder Scrolls V: Skyrim][Skyrim].

- [SKSE].

- A mod or tweak to decrease health regeneration, since vanilla rate wouldn't
  allow to appreciate the effects of this mod.

  Examples include, but are not limited to:

  - [No Health Regen];
  - [Realistic Health Regeneration];
  - [Requiem];
  - [SkyTweak];
  - using [modAV in console][Targeted Commands] to reduce _HealRate_;
  - directly modifying _Health Regen_ in the [Race] record.

## Installation

- Use your mod manager of choice, [Mod Organizer 2] is recommended.

## Features

- After sleep, health is reverted to its previous state; any regeneration rate
  _HealRate_ is accounted for the hours spent sleeping.

- After level up, health is reverted to its previous state; additionally, if
  it was chosen as the attribute to increment, such a difference is added back.

## Known Issues

- Health can be reduced to lower than the initial value, possibly causing
  death, when the resulting regeneration rate is below zero: for example this
  is the case when combining the effect of a mod above with the penalty for
  high exposure given by [Frostfall].

  Note that this is not consistent with how the game handles a negative value
  of regeneration, since it wouldn't cause additional health damage;
  nonetheless I left this side effect as an incentive for players to restore
  their condition before going to sleep.


[Skyrim]: https://elderscrolls.bethesda.net/skyrim
[SKSE]: https://skse.silverlock.org/
[No Health Regen]: https://www.nexusmods.com/skyrim/mods/9972
[Realistic Health Regeneration]: https://www.nexusmods.com/skyrim/mods/29425
[Requiem]: https://www.nexusmods.com/skyrim/mods/19281
[#1]: https://www.reddit.com/r/skyrimrequiem/comments/axou15/requiem_news_requiem_300_consign_to_oblivion_is/ehxmwai
[SkyTweak]: https://www.nexusmods.com/skyrim/mods/33395
[Targeted Commands]: https://en.uesp.net/wiki/Skyrim:Console#Targeted_Commands
[Race]: https://www.creationkit.com/index.php?title=Race
[Mod Organizer 2]: https://www.nexusmods.com/skyrimspecialedition/mods/6194
[Frostfall]: https://www.nexusmods.com/skyrim/mods/11163
