Ovale.defaut["HUNTER"] =
[[
Define(SERPENTSTING 1978)
Define(ARCANESHOT 3044)
Define(AIMEDSHOT 19434)
Define(MULTISHOT 2643)
Define(STEADYSHOT 56641)
Define(EXPLOSIVESHOT 53301)
Define(KILLSHOT 53351)
Define(RAPIDFIRE 3045)
Define(KILLCOMMAND 34026)
Define(BESTIALWRATH 19574)
Define(HUNTERSMARK 53338)
Define(BLACKARROW 3674)
Define(CHIMERASHOT 53209)
Define(READINESS 23989)
Define(SILENCINGSHOT 34490)
Define(ASPECTOFTHEVIPER 34074)
Define(ASPECTOFTHEDRAGONHAWK 61846)
Define(VOLLEY 1510)
Define(EXPLOSIVETRAP 13813)
Define(RAPTORSTRIKE 2973)
Define(MONGOOSEBITE 1495)

Define(TALENTCHIMSHOT 2135)
Define(TALENTEXPLOSHOT 2145)
Define(TALENTTRACKING 1623)
Define(TRACKBEASTS 1494)
Define(TRACKDEMONS 19878)
Define(TRACKDRAGONKIN 19879)
Define(TRACKELEMENTALS 19880)
Define(TRACKGIANTS 19882)
Define(TRACKHUMANOIDS 19883)
Define(TRACKUNDEAD 19884)

AddCheckBox(multi SpellName(MULTISHOT))
AddCheckBox(arcane SpellName(ARCANESHOT) checked)
AddCheckBox(trapweave SpellName(EXPLOSIVETRAP))

SpellAddTargetDebuff(SERPENTSTING SERPENTSTING=15)
SpellAddTargetDebuff(BLACKARROW BLACKARROW=15)
SpellAddTargetDebuff(HUNTERSMARK HUNTERSMARK=300)
SpellInfo(EXPLOSIVESHOT cd=6)
SpellInfo(CHIMERASHOT cd=10)
SpellInfo(AIMEDSHOT cd=10)
SpellInfo(ARCANESHOT cd=6)
SpellInfo(MULTISHOT cd=10)
SpellInfo(RAPTORSTRIKE cd=6)
SpellInfo(MONGOOSEBITE cd=5)

AddIcon help=main
{
	if SpellKnown(ASPECTOFTHEDRAGONHAWK) and ManaPercent(more 95) and BuffPresent(ASPECTOFTHEVIPER) Spell(ASPECTOFTHEDRAGONHAWK)

	if TalentPoints(TALENTTRACKING more 0) and SpellKnown(TRACKBEASTS) and Tracking(TRACKBEASTS no) and Tracking(TRACKDEMONS no) and Tracking(TRACKDRAGONKIN no)
		Spell(TRACKBEASTS)

	if SpellKnown(HUNTERSMARK) and TargetDebuffExpires(HUNTERSMARK 0) and TargetDeadIn(more 15) Spell(HUNTERSMARK)

	if SpellKnown(RAPTORSTRIKE) and TargetInRange(RAPTORSTRIKE)
	{
		if SpellKnown(MONGOOSEBITE) Spell(MONGOOSEBITE usable=1)
		Spell(RAPTORSTRIKE)
	}

	if SpellKnown(KILLSHOT) and TargetLifePercent(less 20) Spell(KILLSHOT)

	if SpellKnown(EXPLOSIVESHOT)
	{
		Spell(EXPLOSIVESHOT)
		if CheckBoxOn(trapweave) and SpellKnown(EXPLOSIVETRAP) Spell(EXPLOSIVETRAP)
		if SpellKnown(BLACKARROW) and TargetDebuffExpires(BLACKARROW 0 mine=1) and TargetDeadIn(more 8) Spell(BLACKARROW)
		if SpellKnown(SERPENTSTING) and TargetDebuffExpires(SERPENTSTING 0 mine=1) and TargetDeadIn(more 8) Spell(SERPENTSTING)
		if SpellKnown(AIMEDSHOT) Spell(AIMEDSHOT)
		if CheckBoxOn(arcane) and SpellKnown(ARCANESHOT) Spell(ARCANESHOT)
		if SpellKnown(STEADYSHOT) Spell(STEADYSHOT)
	}

	if SpellKnown(CHIMERASHOT)
	{
		if SpellKnown(SERPENTSTING) and TargetDebuffExpires(SERPENTSTING 0 mine=1) and TargetDeadIn(more 8) Spell(SERPENTSTING)
		if CheckBoxOn(trapweave) and SpellKnown(EXPLOSIVETRAP) Spell(EXPLOSIVETRAP)
		if TargetDebuffPresent(SERPENTSTING mine=1) Spell(CHIMERASHOT)
		if SpellKnown(AIMEDSHOT) Spell(AIMEDSHOT)
		if CheckBoxOn(arcane) and SpellKnown(ARCANESHOT) Spell(ARCANESHOT)
		if SpellKnown(STEADYSHOT) Spell(STEADYSHOT)
	}

	unless SpellKnown(EXPLOSIVESHOT) or SpellKnown(CHIMERASHOT)
	{
		if SpellKnown(KILLCOMMAND) Spell(KILLCOMMAND usable=1)
		if CheckBoxOn(trapweave) and SpellKnown(EXPLOSIVETRAP) Spell(EXPLOSIVETRAP)
		if SpellKnown(SERPENTSTING) and TargetDebuffExpires(SERPENTSTING 0 mine=1) and TargetDeadIn(more 8) Spell(SERPENTSTING)
		if CheckBoxOn(multi) and SpellKnown(MULTISHOT) Spell(MULTISHOT)
		if SpellKnown(AIMEDSHOT) Spell(AIMEDSHOT)
		if SpellKnown(ARCANESHOT) Spell(ARCANESHOT)
		if SpellKnown(STEADYSHOT) Spell(STEADYSHOT)
	}
}

AddIcon help=aoe
{
	if SpellKnown(VOLLEY) Spell(VOLLEY)
	if SpellKnown(EXPLOSIVETRAP) Spell(EXPLOSIVETRAP)
	if SpellKnown(RAPTORSTRIKE) and TargetInRange(RAPTORSTRIKE)
	{
		if SpellKnown(MONGOOSEBITE) Spell(MONGOOSEBITE usable=1)
		Spell(RAPTORSTRIKE)
	}
	if SpellKnown(MULTISHOT) Spell(MULTISHOT)
	if SpellKnown(SERPENTSTING) and TargetDebuffExpires(SERPENTSTING 0 mine=1) and TargetDeadIn(more 8) Spell(SERPENTSTING)
}

AddIcon help=cd
{
	if SpellKnown(BESTIALWRATH) Spell(BESTIALWRATH usable=1)
	if SpellKnown(KILLCOMMAND) Spell(KILLCOMMAND usable=1)
	if SpellKnown(RAPIDFIRE) Spell(RAPIDFIRE)
	if SpellKnown(READINESS) Spell(READINESS)
	if SpellKnown(SILENCINGSHOT) Spell(SILENCINGSHOT)
}
]]
