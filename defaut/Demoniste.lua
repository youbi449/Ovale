Ovale.defaut["WARLOCK"]=
[[
Define(CURSEELEMENTS 1490)
Define(CURSEAGONY 980)
Define(CURSEDOOM 603)
Define(CURSETONGUES 1714)
Define(CURSEWEAKNESS 702)
Define(UNSTABLEAFFLICTION 30108)
Define(CORRUPTION 172)
Define(TALENTUNSTABLEAFFLICTION 1670)
Define(TALENTSHADOWBOLT 944)
Define(IMMOLATE 348)
Define(TALENTIMMOLATE 961)
Define(TALENTEMBERSTORM 966)
Define(SOULFIRE 6353)
Define(SHADOWBOLT 686)
Define(HAUNT 48181)
Define(TALENTBACKDRAFT 1888)
Define(CONFLAGRATE 17962)
Define(DRAINSOUL 47855)
Define(SHADOWEMBRACE 32391)
Define(TALENTSHADOWEMBRACE 1763)
Define(METAMORPHOSIS 47241)
Define(TALENTDECIMATION 2261)
Define(SOULSHARD 6265)
Define(DEMONICEMPOWERMENT 47193)
Define(INCINERATE 29722)
Define(DECIMATION 63167)
Define(CHAOSBOLT 50796)
Define(MOLTENCORE 47383)
Define(GLYPHOFCONFLAGRATE 56235)
Define(FELARMOR 28176)
Define(DEMONARMOR 706)
Define(FIRESTONE 6366)
Define(SPELLSTONE 2362)
Define(GLYPHLIFETAP 63320)
Define(LIFETAP 1454)
Define(SEEDOFCORRUPTION 27243)
Define(RAINOFFIRE 5740)
Define(HELLFIRE 1949)
Define(SHADOWFLAME 47897)
Define(SHADOWFURY 30283)
Define(INFERNO 1122)

AddListItem(curse elements SpellName(CURSEELEMENTS))
AddListItem(curse agony SpellName(CURSEAGONY))
AddListItem(curse doom SpellName(CURSEDOOM) default)
AddListItem(curse tongues SpellName(CURSETONGUES))
AddListItem(curse weakness SpellName(CURSEWEAKNESS))

SpellAddTargetDebuff(CURSEELEMENTS CURSEELEMENTS=300)
SpellAddTargetDebuff(CURSEAGONY CURSEAGONY=24)
SpellAddTargetDebuff(CURSEDOOM CURSEDOOM=60)
SpellAddTargetDebuff(UNSTABLEAFFLICTION UNSTABLEAFFLICTION=15)
SpellAddTargetDebuff(CORRUPTION CORRUPTION=18)
SpellAddTargetDebuff(IMMOLATE IMMOLATE=15)
SpellAddBuff(LIFETAP LIFETAP=40)
SpellInfo(CHAOSBOLT cd=12)
SpellInfo(CONFLAGRATE cd=10)
SpellInfo(HAUNT cd=8)

AddIcon help=main
{
	unless InCombat()
	{
		if SpellKnown(FELARMOR) and BuffExpires(FELARMOR 400) Spell(FELARMOR)
		if SpellKnown(DEMONARMOR) and BuffExpires(DEMONARMOR 400) Spell(DEMONARMOR)
		if SpellKnown(SPELLSTONE) Spell(SPELLSTONE)
		if SpellKnown(FIRESTONE) Spell(FIRESTONE)
	}

	if Glyph(GLYPHLIFETAP) and SpellKnown(LIFETAP) and BuffExpires(LIFETAP 0) Spell(LIFETAP)
	if SpellKnown(LIFETAP) and ManaPercent(less 20) Spell(LIFETAP priority=2)
	if List(curse elements) and SpellKnown(CURSEELEMENTS) and TargetDebuffExpires(CURSEELEMENTS 2) and TargetDeadIn(more 8) Spell(CURSEELEMENTS)

	if SpellKnown(HAUNT) or SpellKnown(UNSTABLEAFFLICTION)
	{
		if SpellKnown(HAUNT) and TargetDebuffExpires(HAUNT 1.5 mine=1) Spell(HAUNT)
		if SpellKnown(UNSTABLEAFFLICTION) and TargetDebuffExpires(UNSTABLEAFFLICTION 1.5 mine=1 haste=spell) and TargetDeadIn(more 8) Spell(UNSTABLEAFFLICTION)
		if SpellKnown(CORRUPTION) and TargetDebuffExpires(CORRUPTION 1 mine=1) and TargetDeadIn(more 9) Spell(CORRUPTION)
		if SpellKnown(CURSEAGONY) and TargetDebuffExpires(CURSEAGONY 1 mine=1) and TargetDeadIn(more 10) Spell(CURSEAGONY)
		if SpellKnown(DRAINSOUL) and TargetLifePercent(less 25) Spell(DRAINSOUL)
		if SpellKnown(SHADOWBOLT) Spell(SHADOWBOLT)
	}

	if SpellKnown(METAMORPHOSIS)
	{
		if List(curse doom) and SpellKnown(CURSEDOOM) and TargetDebuffExpires(CURSEDOOM 1 mine=1) and TargetDeadIn(more 60) Spell(CURSEDOOM)
		if List(curse agony) and SpellKnown(CURSEAGONY) and TargetDebuffExpires(CURSEAGONY 1 mine=1) and TargetDeadIn(more 10) Spell(CURSEAGONY)
		if SpellKnown(IMMOLATE) and TargetDebuffExpires(IMMOLATE 1.5 mine=1 haste=spell) and TargetDeadIn(more 8) Spell(IMMOLATE)
		if SpellKnown(CORRUPTION) and TargetDebuffExpires(CORRUPTION 1 mine=1) and TargetDeadIn(more 9) Spell(CORRUPTION)
		if BuffPresent(DECIMATION) and SpellKnown(SOULFIRE) Spell(SOULFIRE)
		if BuffPresent(MOLTENCORE) and SpellKnown(INCINERATE) Spell(INCINERATE)
		if SpellKnown(SHADOWBOLT) Spell(SHADOWBOLT)
	}

	if SpellKnown(CHAOSBOLT) or SpellKnown(CONFLAGRATE)
	{
		if List(curse doom) and SpellKnown(CURSEDOOM) and TargetDebuffExpires(CURSEDOOM 1 mine=1) and TargetDeadIn(more 60) Spell(CURSEDOOM)
		if List(curse agony) and SpellKnown(CURSEAGONY) and TargetDebuffExpires(CURSEAGONY 1 mine=1) and TargetDeadIn(more 10) Spell(CURSEAGONY)
		if SpellKnown(IMMOLATE) and TargetDebuffExpires(IMMOLATE 1.5 mine=1 haste=spell) and TargetDeadIn(more 8) Spell(IMMOLATE)
		if SpellKnown(CONFLAGRATE) and TargetDebuffPresent(IMMOLATE mine=1) Spell(CONFLAGRATE)
		if SpellKnown(CHAOSBOLT) Spell(CHAOSBOLT)
		if SpellKnown(INCINERATE) Spell(INCINERATE)
		if SpellKnown(CORRUPTION) and TargetDeadIn(more 9) and TargetDebuffExpires(CORRUPTION 1 mine=1) Spell(CORRUPTION priority=2)
	}

	if List(curse doom) and SpellKnown(CURSEDOOM) and TargetDebuffExpires(CURSEDOOM 1 mine=1) and TargetDeadIn(more 60) Spell(CURSEDOOM)
	if List(curse tongues) and SpellKnown(CURSETONGUES) Spell(CURSETONGUES)
	if List(curse weakness) and SpellKnown(CURSEWEAKNESS) Spell(CURSEWEAKNESS)
	if List(curse agony) and SpellKnown(CURSEAGONY) and TargetDebuffExpires(CURSEAGONY 1 mine=1) and TargetDeadIn(more 10) Spell(CURSEAGONY)
	if SpellKnown(CORRUPTION) and TargetDebuffExpires(CORRUPTION 1 mine=1) and TargetDeadIn(more 9) Spell(CORRUPTION)
	if SpellKnown(IMMOLATE) and TargetDebuffExpires(IMMOLATE 1.5 mine=1 haste=spell) and TargetDeadIn(more 8) Spell(IMMOLATE)
	if SpellKnown(INCINERATE) Spell(INCINERATE)
	if SpellKnown(SHADOWBOLT) Spell(SHADOWBOLT)
}

AddIcon help=aoe
{
	if SpellKnown(SEEDOFCORRUPTION) Spell(SEEDOFCORRUPTION)
	if SpellKnown(SHADOWFURY) Spell(SHADOWFURY)
	if SpellKnown(SHADOWFLAME) Spell(SHADOWFLAME)
	if SpellKnown(RAINOFFIRE) Spell(RAINOFFIRE)
	if SpellKnown(HELLFIRE) Spell(HELLFIRE)
	if SpellKnown(CORRUPTION) and TargetDebuffExpires(CORRUPTION 1 mine=1) and TargetDeadIn(more 9) Spell(CORRUPTION)
	if SpellKnown(IMMOLATE) and TargetDebuffExpires(IMMOLATE 1.5 mine=1 haste=spell) and TargetDeadIn(more 8) Spell(IMMOLATE)
	if SpellKnown(INCINERATE) Spell(INCINERATE)
	if SpellKnown(SHADOWBOLT) Spell(SHADOWBOLT)
}

AddIcon help=cd
{
	if SpellKnown(METAMORPHOSIS) Spell(METAMORPHOSIS)
	if SpellKnown(DEMONICEMPOWERMENT) Spell(DEMONICEMPOWERMENT)
	if SpellKnown(INFERNO) Spell(INFERNO)
}

AddIcon size=small nocd=1 { if SpellKnown(CURSEAGONY) and TargetDebuffExpires(CURSEAGONY 0 mine=1) Spell(CURSEAGONY) }
AddIcon size=small nocd=1 { if SpellKnown(CURSEDOOM) and TargetDebuffExpires(CURSEDOOM 0 mine=1) Spell(CURSEDOOM) }
AddIcon size=small nocd=1 { if SpellKnown(CORRUPTION) and TargetDebuffExpires(CORRUPTION 0 mine=1) Spell(CORRUPTION) }
]]
