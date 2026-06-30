Ovale.defaut["DEATHKNIGHT"] = [[
Define(FROSTPRESENCE 48263)
Define(BLOODPRESENCE 48266)
Define(UNHOLYPRESENCE 48265)
Define(RUNESTRIKE 56815)
Define(DEATHANDECAY 43265)
Define(HOWLINGBLAST 49184)
Define(OBLITERATE 49020)
Define(BLOODSTRIKE 45902)
Define(BLOODBOIL 48721)
Define(BLOODPLAGUE 59879)
Define(FROSTFEVER 59921)
Define(PESTILENCE 50842)
Define(ICYTOUCH 45477)
Define(PLAGUESTRIKE 45462)
Define(HEARTSTRIKE 55050)
Define(DEATHSTRIKE 49998)
Define(SCOURGESTRIKE 55090)
Define(DEATHCOIL 47541)
Define(ARMYOFTHEDEAD 42650)
Define(DANCINGRUNEWEAPON 49028)
Define(FROSTSTRIKE 49143)
Define(HYSTERIA 49016)
Define(SUMMONGARGOYLE 49206)
Define(RAISEDEAD 46584)
Define(HORNOFWINTER 57330)
Define(STRENGTHOFEARTHTOTEM 8075)
Define(BLOODTAP 45529)
Define(FREEZINGFOG 59052)
Define(KILLINGMACHINE 51124)
Define(UNHOLYBLIGHT 49194)
Define(ANTIMAGICSHELL 48707)
Define(ICEBOUNDFORTITUDE 48792)
Define(VAMPIRICBLOOD 55233)
Define(RUNETAP 48982)
Define(DEATHPACT 48743)
Define(BONESHIELD 49222)
Define(UNBREAKABLEARMOR 51271)

Define(TALENTDEATHSTRIKE 2259)
Define(TALENTFROSTSTRIKE 1975)
Define(TALENTHEARTSTRIKE 1957)
Define(TALENTBLOODYSTRIKES 2015)
Define(TALENTABOMINATIONMIGHT 2105)
Define(GLYPHDISEASE 63334)
Define(GLYPHHOWLINGBLAST 63335)
Define(GLYPHOFRAISEDEAD 60200)

AddCheckBox(rolldes SpellName(GLYPHDISEASE) checked glyph=GLYPHDISEASE)
AddCheckBox(dnd SpellName(DEATHANDECAY) checked)
AddCheckBox(aoe L(AOE))

SpellAddTargetDebuff(BLOODPLAGUE BLOODPLAGUE=15)
SpellAddTargetDebuff(FROSTFEVER FROSTFEVER=15)
SpellAddBuff(HORNOFWINTER HORNOFWINTER=120)
SpellInfo(DEATHANDECAY cd=30)
SpellInfo(HOWLINGBLAST cd=8)
SpellInfo(OBLITERATE cd=1.5)
SpellInfo(HEARTSTRIKE cd=1.5)
SpellInfo(SCOURGESTRIKE cd=1.5)
SpellInfo(ANTIMAGICSHELL cd=45)
SpellInfo(ICEBOUNDFORTITUDE cd=120)
SpellInfo(VAMPIRICBLOOD cd=60)
SpellInfo(RUNETAP cd=30)
SpellInfo(DEATHPACT cd=120)
SpellInfo(BONESHIELD cd=60)
SpellInfo(UNBREAKABLEARMOR cd=60)
SpellAddBuff(BONESHIELD BONESHIELD=300)

AddIcon help=main
{
	if SpellKnown(HORNOFWINTER) and BuffExpires(HORNOFWINTER 2) and BuffExpires(STRENGTHOFEARTHTOTEM 0) Spell(HORNOFWINTER)

	if SpellKnown(HOWLINGBLAST) or SpellKnown(FROSTSTRIKE)
	{
		if SpellKnown(ICYTOUCH) and TargetDebuffExpires(FROSTFEVER 2) Spell(ICYTOUCH)
		if SpellKnown(PLAGUESTRIKE) and TargetDebuffExpires(BLOODPLAGUE 2) Spell(PLAGUESTRIKE)
		if CheckBoxOn(rolldes) and Glyph(GLYPHDISEASE) and TargetDebuffPresent(BLOODPLAGUE) and TargetDebuffPresent(FROSTFEVER) and { TargetDebuffExpires(BLOODPLAGUE 4) or TargetDebuffExpires(FROSTFEVER 4) } Spell(PESTILENCE)
		if BuffPresent(KILLINGMACHINE) and SpellKnown(FROSTSTRIKE) Spell(FROSTSTRIKE usable=1)
		if BuffPresent(FREEZINGFOG) and SpellKnown(HOWLINGBLAST) Spell(HOWLINGBLAST)
		if SpellKnown(OBLITERATE) Spell(OBLITERATE)
		if SpellKnown(BLOODSTRIKE) Spell(BLOODSTRIKE)
		if SpellKnown(FROSTSTRIKE) Spell(FROSTSTRIKE usable=1)
		if SpellKnown(DEATHCOIL) and Mana(more 39) Spell(DEATHCOIL usable=1)
	}

	if SpellKnown(SCOURGESTRIKE) or SpellKnown(SUMMONGARGOYLE)
	{
		if SpellKnown(ICYTOUCH) and TargetDebuffExpires(FROSTFEVER 2) Spell(ICYTOUCH)
		if SpellKnown(PLAGUESTRIKE) and TargetDebuffExpires(BLOODPLAGUE 2) Spell(PLAGUESTRIKE)
		if CheckBoxOn(rolldes) and Glyph(GLYPHDISEASE) and TargetDebuffPresent(BLOODPLAGUE) and TargetDebuffPresent(FROSTFEVER) and { TargetDebuffExpires(BLOODPLAGUE 4) or TargetDebuffExpires(FROSTFEVER 4) } Spell(PESTILENCE)
		if CheckBoxOn(dnd) and SpellKnown(DEATHANDECAY) Spell(DEATHANDECAY usable=1)
		if SpellKnown(SCOURGESTRIKE) Spell(SCOURGESTRIKE)
		if SpellKnown(BLOODSTRIKE) Spell(BLOODSTRIKE)
		if SpellKnown(BLOODBOIL) Spell(BLOODBOIL usable=1)
		if SpellKnown(DEATHCOIL) and Mana(more 39) Spell(DEATHCOIL usable=1)
	}

	if SpellKnown(HEARTSTRIKE) or TalentPoints(TALENTHEARTSTRIKE more 0)
	{
		if SpellKnown(ICYTOUCH) and TargetDebuffExpires(FROSTFEVER 2) Spell(ICYTOUCH)
		if SpellKnown(PLAGUESTRIKE) and TargetDebuffExpires(BLOODPLAGUE 2) Spell(PLAGUESTRIKE)
		if SpellKnown(HEARTSTRIKE) Spell(HEARTSTRIKE)
		if SpellKnown(DEATHSTRIKE) Spell(DEATHSTRIKE)
		if SpellKnown(BLOODSTRIKE) Spell(BLOODSTRIKE)
		if SpellKnown(DEATHCOIL) and Mana(more 39) Spell(DEATHCOIL usable=1)
	}

	if SpellKnown(ICYTOUCH) and TargetDebuffExpires(FROSTFEVER 2) Spell(ICYTOUCH)
	if SpellKnown(PLAGUESTRIKE) and TargetDebuffExpires(BLOODPLAGUE 2) Spell(PLAGUESTRIKE)
	if SpellKnown(DEATHSTRIKE) Spell(DEATHSTRIKE)
	if SpellKnown(OBLITERATE) Spell(OBLITERATE)
	if SpellKnown(BLOODSTRIKE) Spell(BLOODSTRIKE)
	if SpellKnown(DEATHCOIL) and Mana(more 39) Spell(DEATHCOIL usable=1)
	if SpellKnown(HORNOFWINTER) Spell(HORNOFWINTER priority=2)
}

AddIcon help=aoe
{
	if SpellKnown(DEATHANDECAY) Spell(DEATHANDECAY usable=1)
	if SpellKnown(HOWLINGBLAST) Spell(HOWLINGBLAST)
	if SpellKnown(PESTILENCE) and TargetDebuffPresent(BLOODPLAGUE) and TargetDebuffPresent(FROSTFEVER) Spell(PESTILENCE usable=1)
	if SpellKnown(BLOODBOIL) Spell(BLOODBOIL usable=1)
	if SpellKnown(FROSTSTRIKE) Spell(FROSTSTRIKE usable=1)
	if SpellKnown(DEATHCOIL) and Mana(more 39) Spell(DEATHCOIL usable=1)
}

AddIcon help=offgcd
{
	if SpellKnown(RUNESTRIKE) Spell(RUNESTRIKE usable=1)
}

AddIcon help=mitigation
{
	if BuffPresent(FROSTPRESENCE) and { SpellKnown(BONESHIELD) or SpellKnown(UNBREAKABLEARMOR) or SpellKnown(VAMPIRICBLOOD) or SpellKnown(RUNETAP) } and TargetTargetIsPlayer()
	{
		if SpellKnown(BONESHIELD) and BuffExpires(BONESHIELD 2) Spell(BONESHIELD usable=1)
		if LifePercent(less 70) and SpellKnown(ANTIMAGICSHELL) Spell(ANTIMAGICSHELL usable=1)
		if LifePercent(less 60) and SpellKnown(UNBREAKABLEARMOR) Spell(UNBREAKABLEARMOR usable=1)
		if LifePercent(less 55) and SpellKnown(RUNETAP) Spell(RUNETAP usable=1)
		if LifePercent(less 45) and SpellKnown(VAMPIRICBLOOD) Spell(VAMPIRICBLOOD usable=1)
		if LifePercent(less 35) and SpellKnown(ICEBOUNDFORTITUDE) Spell(ICEBOUNDFORTITUDE usable=1)
		if LifePercent(less 25) and PetPresent() and SpellKnown(DEATHPACT) Spell(DEATHPACT usable=1)
	}
}

AddIcon help=cd
{
	if SpellKnown(DANCINGRUNEWEAPON) Spell(DANCINGRUNEWEAPON usable=1)
	if SpellKnown(HYSTERIA) Spell(HYSTERIA)
	if SpellKnown(SUMMONGARGOYLE) Spell(SUMMONGARGOYLE)
	if SpellKnown(UNHOLYBLIGHT) Spell(UNHOLYBLIGHT)
	if SpellKnown(RAISEDEAD) and PetPresent(no) Spell(RAISEDEAD)
	if SpellKnown(BLOODTAP) Spell(BLOODTAP)
	if SpellKnown(ARMYOFTHEDEAD) Spell(ARMYOFTHEDEAD)
}
]]
