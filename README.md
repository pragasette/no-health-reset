# No Health Reset

_No Health Reset_ is a mod for [The Elder Scrolls V: Skyrim][Skyrim] to revert
the full health recovery which occurs after sleep and level-up.

It is intended to work with any mod which reduces health
regeneration, such as [NPC Stat Rescaler].


## Features

- After sleep, revert health to its previous value, counting [regeneration][#1]
  for the hours passed.
- After level-up, revert health to its previous value, counting if it was
  chosen as the attribute to increase.

Also see the _Implementation Details_ section below.


## Requirements

- [The Elder Scrolls V: Skyrim][Skyrim]
- [Skyrim Script Extender (SKSE)][SKSE]
- A mod or tweak to decrease health regeneration, for example:
  - [NPC Stat Rescaler]
  - [Requiem]
  - [SkyTweak]
  - the [console command][#2] `player.modAV HealRateMult -100`
  - changing _Health Regen_ in the [Race] record


## Installation

Use your mod manager of choice, [Mod Organizer 2] is recommended.


## Configuration

The following property of the `_p7NHR_Quest` quest can be edited using
[TES5Edit] or the console:

- **`Float`**`SleepHealingMult` (default: **2.0**): multiplies the health
  amount recovered by sleeping.

Also see the _Implementation Details_ section below.


## Implementation Details

Health after sleep is calculated as:

```
newHealth = oldHealth + baseHealth * SleepHealingMult * HealRate / 100 * HealRateMult / 100 * 60 * 60 * hours / TimeScale
```

where:

- `newHealth` is the value after sleeping;
- `oldHealth` is the value before sleeping;
- `baseHealth` is the value without damage;
- `SleepHealingMult` (default: **2.0**) is a `float` property of the
  `_p7NHR_Quest` quest, chosen so that sleeping and waiting restore the same
  amount;
- `HealRate` (default: **0.70**) is an actor value affecting
  [regeneration][#1];
- `HealRateMult` (default: **100**) is another actor value affecting
  regeneration;
- `hours` is the time spent sleeping;
- `TimeScale` (default: **20**) is a global variable determining [how _game
  time_ passes compared to _real time_][#3].

Note that `TimeScale` affects the amount of health restored: since `HealRate`
and `HealRateMult` determine the percentage of `baseHealth` recovered in _real
time_ seconds, a lower value of `TimeScale` makes the same amount of health
recover over a shorter lapse of _game time_. The same can be observed when
waiting in vanilla game, as long as the regeneration rate is low enough.


## Known Issues

- Sleeping can cause death when the regeneration rate is below zero.

  This can occur with effects which further decrease health regeneration, such
  as [Frostfall] exposure or [iNeed] hunger, and is not consistent with how the
  game handles negative rates, but was left as a motivation to treat those
  conditions before resting.


## Alternatives

- [Realistic Regeneration] applies custom regeneration rates to sleep.


## Errata

- This document incorrectly reported a similar feature was included in
  [Requiem] until version **2.0.2**: instead [the changelog reports][#4] it was
  removed since version **3.4.0**.


[Skyrim]: https://store.steampowered.com/app/72850
[NPC Stat Rescaler]: https://www.nexusmods.com/skyrim/mods/96817
[#1]: https://en.uesp.net/wiki/Skyrim:Health#Passive_Regeneration
[SKSE]: https://skse.silverlock.org
[Requiem]: https://www.nexusmods.com/skyrim/mods/19281
[SkyTweak]: https://www.nexusmods.com/skyrim/mods/33395
[#2]: https://en.uesp.net/wiki/Skyrim:Console#Targeted_Commands
[Race]: https://www.creationkit.com/index.php?title=Race
[Mod Organizer 2]: https://www.nexusmods.com/skyrimspecialedition/mods/6194
[TES5Edit]: https://github.com/TES5Edit/TES5Edit
[Frostfall]: https://www.nexusmods.com/skyrim/mods/11163
[iNeed]: https://www.nexusmods.com/skyrim/mods/51473
[#3]: http://en.uesp.net/wiki/Skyrim:Console#set_timescale
[Realistic Regeneration]: https://www.nexusmods.com/skyrim/mods/55507
[#4]: https://requiem.atlassian.net/wiki/spaces/RS/pages/794656953/Requiem+3.4.0+-+The+Shadow+Theory
