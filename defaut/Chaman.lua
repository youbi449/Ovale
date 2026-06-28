Ovale.defaut["SHAMAN"] =
[[
Define(CHAINLIGHTNING 421)
Define(LIGHTNINGBOLT 548)
Define(LAVABURST 51505)
Define(WATERSHIELD 52127)
Define(FLAMESHOCK 8050)
Define(FLAMETONGUEWEAPON 8024)
Define(WINDFURYWEAPON 8232)
Define(EARTHSHOCK 8042)
Define(FROSTSHOCK 8056)
Define(STORMSTRIKE 17364)
Define(LAVALASH 60103)
Define(LIGHTNINGSHIELD 324)
Define(MAELSTROMWEAPON 53817)
Define(ELEMENTALMASTERY 16166)
Define(SHAMANISTICRAGE 30823)
Define(THUNDERSTORM 51490)
Define(FERALSPIRIT 51533)
Define(HEROISM 32182)
Define(BLOODLUST 2825)
Define(TALENTFLURRY 602)
Define(TALENTCALLOFTHUNDER 562)
Define(FIRENOVA 1535)
Define(FIREELEMENTALTOTEM 2894)
Define(TOTEMOFWRATH 30706)
Define(FLAMETONGTOTEM 8227)
Define(MAGMATOTEM 8190)
Define(SEARINGTOTEM 3599)

AddCheckBox(aoe L(AOE))
AddCheckBox(chain SpellName(CHAINLIGHTNING) checked talent=TALENTCALLOFTHUNDER)
AddCheckBox(firenova SpellName(FIRENOVA) checked)
AddCheckBox(thunderstorm SpellName(THUNDERSTORM))

SpellAddTargetDebuff(FLAMESHOCK FLAMESHOCK=18)
SpellInfo(LAVABURST cd=8)
SpellInfo(CHAINLIGHTNING cd=6)
SpellInfo(STORMSTRIKE cd=8)
SpellInfo(EARTHSHOCK cd=6)
SpellInfo(LAVALASH cd=6)

AddIcon help=main
{
	if SpellKnown(STORMSTRIKE) or TalentPoints(TALENTFLURRY more 0)
	{
		unless InCombat()
		{
			if SpellKnown(WINDFURYWEAPON) and WeaponEnchantExpires(mainhand 400) Spell(WINDFURYWEAPON)
			if SpellKnown(FLAMETONGUEWEAPON) and WeaponEnchantExpires(offhand 400) Spell(FLAMETONGUEWEAPON)
		}

		if SpellKnown(LIGHTNINGSHIELD) and BuffExpires(LIGHTNINGSHIELD 2) Spell(LIGHTNINGSHIELD)
		if SpellKnown(FIREELEMENTALTOTEM) Spell(FIREELEMENTALTOTEM)
		if SpellKnown(FERALSPIRIT) Spell(FERALSPIRIT)
		if BuffPresent(MAELSTROMWEAPON stacks=5)
		{
			if CheckBoxOn(chain) and SpellKnown(CHAINLIGHTNING) Spell(CHAINLIGHTNING)
			if SpellKnown(LIGHTNINGBOLT) Spell(LIGHTNINGBOLT)
		}
		if SpellKnown(FLAMESHOCK) and TargetDebuffExpires(FLAMESHOCK 2 haste=spell mine=1) Spell(FLAMESHOCK)
		if SpellKnown(STORMSTRIKE) Spell(STORMSTRIKE)
		if SpellKnown(MAGMATOTEM) and TotemExpires(fire) Spell(MAGMATOTEM)
		if SpellKnown(EARTHSHOCK) Spell(EARTHSHOCK)
		if CheckBoxOn(firenova) and SpellKnown(FIRENOVA)
		{
			unless TotemExpires(fire) Spell(FIRENOVA)
		}
		if SpellKnown(LAVALASH) Spell(LAVALASH)
		if SpellKnown(SEARINGTOTEM) and TotemExpires(fire) Spell(SEARINGTOTEM priority=2)
	}

	unless SpellKnown(STORMSTRIKE) or TalentPoints(TALENTFLURRY more 0)
	{
		unless InCombat()
		{
			if SpellKnown(FLAMETONGUEWEAPON) and WeaponEnchantExpires(mainhand 400) Spell(FLAMETONGUEWEAPON)
		}
		if SpellKnown(WATERSHIELD) and BuffExpires(WATERSHIELD 2) Spell(WATERSHIELD)
		if SpellKnown(TOTEMOFWRATH) and TotemExpires(fire) Spell(TOTEMOFWRATH)
		if SpellKnown(FLAMESHOCK) and TargetDebuffExpires(FLAMESHOCK 0 mine=1) Spell(FLAMESHOCK)
		if SpellKnown(LAVABURST)
		{
			unless TargetDebuffExpires(FLAMESHOCK 1.6 haste=spell mine=1) Spell(LAVABURST)
		}
		if SpellKnown(SEARINGTOTEM) and TotemExpires(fire) Spell(SEARINGTOTEM priority=2)
		if CheckBoxOn(chain) and SpellKnown(CHAINLIGHTNING) Spell(CHAINLIGHTNING)
		if SpellKnown(LIGHTNINGBOLT) Spell(LIGHTNINGBOLT)
		if SpellKnown(FROSTSHOCK) Spell(FROSTSHOCK priority=2)
	}
}

AddIcon help=aoe
{
	if SpellKnown(MAGMATOTEM) and TotemExpires(fire) Spell(MAGMATOTEM)
	if SpellKnown(FIRENOVA)
	{
		unless TotemExpires(fire) Spell(FIRENOVA)
	}
	if BuffPresent(MAELSTROMWEAPON stacks=5)
	{
		if SpellKnown(CHAINLIGHTNING) Spell(CHAINLIGHTNING)
		if SpellKnown(LIGHTNINGBOLT) Spell(LIGHTNINGBOLT)
	}
	if SpellKnown(CHAINLIGHTNING) Spell(CHAINLIGHTNING)
	if SpellKnown(FLAMESHOCK) and TargetDebuffExpires(FLAMESHOCK 0 mine=1) Spell(FLAMESHOCK)
	if SpellKnown(LAVABURST)
	{
		unless TargetDebuffExpires(FLAMESHOCK 1.6 haste=spell mine=1) Spell(LAVABURST)
	}
	if SpellKnown(STORMSTRIKE) Spell(STORMSTRIKE)
	if SpellKnown(EARTHSHOCK) Spell(EARTHSHOCK)
	if SpellKnown(LAVALASH) Spell(LAVALASH)
	if SpellKnown(LIGHTNINGBOLT) Spell(LIGHTNINGBOLT)
}

AddIcon help=cd
{
	if SpellKnown(ELEMENTALMASTERY) Spell(ELEMENTALMASTERY)
	if SpellKnown(FERALSPIRIT) Spell(FERALSPIRIT)
	if SpellKnown(FIREELEMENTALTOTEM) Spell(FIREELEMENTALTOTEM)
}

AddIcon size=small help=mana
{
	if ManaPercent(less 30)
	{
		if SpellKnown(SHAMANISTICRAGE) Spell(SHAMANISTICRAGE)
		if CheckBoxOn(thunderstorm) and SpellKnown(THUNDERSTORM) Spell(THUNDERSTORM)
	}
}

AddIcon size=small
{
	if SpellKnown(HEROISM) Spell(HEROISM)
	if SpellKnown(BLOODLUST) Spell(BLOODLUST)
}
]]
