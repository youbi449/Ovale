Ovale.defaut["DRUID"] =
[[
Define(FAERIEFIRE 770)
Define(FAERIEFERAL 16857)
Define(MANGLEBEAR 33878)
Define(DEMOROAR 99)
Define(SWIPE 779)
Define(LACERATE 33745)
Define(MAUL 6807)
Define(RIP 1079)
Define(MANGLECAT 33876)
Define(SHRED 5221)
Define(INSECTSWARM 27013)
Define(MOONFIRE 8921)
Define(STARFIRE 2912)
Define(WRATH 5176)
Define(ECLIPSESTARFIRE 48518)
Define(ECLIPSEWRATH 48517)
Define(TIGERSFURY 5217)
Define(FORCEOFNATURE 33831)
Define(RAKE 59886)
Define(SAVAGEROAR 52610)
Define(FEROCIOUSBITE 22568)
Define(BERSERK 50334)
Define(CLEARCASTING 16870)
Define(CLAW 16827)
Define(STARFALL 48505)
Define(HURRICANE 16914)
Define(TYPHOON 50516)
Define(TRAUMA 46856)
Define(GLYPHOFSHRED 54815)
Define(GLYPHOFRIP 54818)

AddCheckBox(demo SpellName(DEMOROAR))
AddCheckBox(shred SpellName(SHRED) checked)
AddCheckBox(moonfire SpellName(MOONFIRE))
AddCheckBox(wrathfiller SpellName(WRATH) checked)
AddCheckBox(aoe L(AOE))

SpellAddTargetDebuff(FAERIEFIRE FAERIEFIRE=300)
SpellAddTargetDebuff(FAERIEFERAL FAERIEFERAL=300)
SpellAddTargetDebuff(DEMOROAR DEMOROAR=30)
SpellAddTargetDebuff(LACERATE LACERATE=15)
SpellAddTargetDebuff(RAKE RAKE=9)
SpellAddTargetDebuff(RIP RIP=12)
SpellAddTargetDebuff(MANGLECAT MANGLECAT=60)
SpellAddTargetDebuff(INSECTSWARM INSECTSWARM=12)
SpellAddTargetDebuff(MOONFIRE MOONFIRE=12)
SpellAddBuff(SAVAGEROAR SAVAGEROAR=14)
SpellInfo(MANGLEBEAR cd=6)
SpellInfo(MANGLECAT cd=6)
SpellInfo(STARFALL cd=90)
SpellInfo(TIGERSFURY cd=30)

AddIcon help=main
{
	if Stance(1)
	{
		if SpellKnown(FAERIEFERAL) and TargetDebuffExpires(FAERIEFERAL 2) Spell(FAERIEFERAL)
		if CheckBoxOn(demo) and SpellKnown(DEMOROAR) and TargetDebuffExpires(DEMOROAR 2) Spell(DEMOROAR)
		if SpellKnown(MANGLEBEAR) Spell(MANGLEBEAR)
		if SpellKnown(LACERATE) and TargetDebuffExpires(LACERATE 4 stacks=5) Spell(LACERATE)
		if SpellKnown(LACERATE) Spell(LACERATE priority=2)
		if SpellKnown(SWIPE) Spell(SWIPE priority=2)
	}

	if Stance(3)
	{
		if SpellKnown(TIGERSFURY) and Mana(less 40) Spell(TIGERSFURY)
		if ComboPoints(more 0) and SpellKnown(SAVAGEROAR) and BuffExpires(SAVAGEROAR 2) Spell(SAVAGEROAR priority=4)
		if SpellKnown(FAERIEFERAL) and TargetDebuffExpires(FAERIEFERAL 2) Spell(FAERIEFERAL)
		if SpellKnown(MANGLECAT) and TargetDebuffExpires(MANGLECAT 2) and TargetDebuffExpires(TRAUMA 0) Spell(MANGLECAT)
		if SpellKnown(RAKE) and TargetDebuffExpires(RAKE 0 mine=1) and TargetDeadIn(more 9) Spell(RAKE)
		if ComboPoints(less 5) and SpellKnown(SHRED) and BuffPresent(CLEARCASTING) Spell(SHRED)
		if ComboPoints(more 4)
		{
			if TargetDeadIn(less 7) and SpellKnown(FEROCIOUSBITE) Spell(FEROCIOUSBITE priority=4)
			if SpellKnown(RIP) and TargetDebuffExpires(RIP 0 mine=1) and TargetDeadIn(more 8) Spell(RIP priority=4)
			unless BuffExpires(SAVAGEROAR 6) or TargetDebuffExpires(RIP 6 mine=1)
			{
				if SpellKnown(FEROCIOUSBITE) Spell(FEROCIOUSBITE)
			}
		}
		if CheckBoxOn(shred) and SpellKnown(SHRED) and Mana(more 69) Spell(SHRED priority=2)
		if CheckBoxOff(shred) and SpellKnown(CLAW) Spell(CLAW)
		if SpellKnown(CLAW) Spell(CLAW)
	}

	unless Stance(1) or Stance(3)
	{
		if SpellKnown(FAERIEFIRE) and TargetDebuffExpires(FAERIEFIRE 2) and TargetDeadIn(more 10) Spell(FAERIEFIRE)
		if SpellKnown(INSECTSWARM) and TargetDebuffExpires(INSECTSWARM 0 mine=1) and TargetDeadIn(more 12) Spell(INSECTSWARM)
		if CheckBoxOn(moonfire) and SpellKnown(MOONFIRE) and TargetDebuffExpires(MOONFIRE 0 mine=1) and TargetDeadIn(more 12) Spell(MOONFIRE)
		if BuffPresent(ECLIPSESTARFIRE) and SpellKnown(STARFIRE) Spell(STARFIRE)
		if BuffPresent(ECLIPSEWRATH) and SpellKnown(WRATH) Spell(WRATH)
		if CheckBoxOn(wrathfiller) and SpellKnown(WRATH) Spell(WRATH)
		if SpellKnown(STARFIRE) Spell(STARFIRE)
		if SpellKnown(WRATH) Spell(WRATH)
	}
}

AddIcon help=aoe
{
	if Stance(1)
	{
		if SpellKnown(SWIPE) Spell(SWIPE)
		if SpellKnown(MANGLEBEAR) Spell(MANGLEBEAR)
		if SpellKnown(LACERATE) Spell(LACERATE)
	}
	if Stance(3)
	{
		if SpellKnown(MANGLECAT) Spell(MANGLECAT)
		if SpellKnown(RAKE) and TargetDebuffExpires(RAKE 0 mine=1) and TargetDeadIn(more 9) Spell(RAKE)
		if SpellKnown(SWIPE) Spell(SWIPE)
		if SpellKnown(CLAW) Spell(CLAW)
	}
	unless Stance(1) or Stance(3)
	{
		if SpellKnown(STARFALL) Spell(STARFALL)
		if SpellKnown(TYPHOON) Spell(TYPHOON)
		if SpellKnown(HURRICANE) Spell(HURRICANE)
		if SpellKnown(INSECTSWARM) and TargetDebuffExpires(INSECTSWARM 0 mine=1) and TargetDeadIn(more 12) Spell(INSECTSWARM)
		if CheckBoxOn(moonfire) and SpellKnown(MOONFIRE) and TargetDebuffExpires(MOONFIRE 0 mine=1) and TargetDeadIn(more 12) Spell(MOONFIRE)
		if SpellKnown(STARFIRE) Spell(STARFIRE)
		if SpellKnown(WRATH) Spell(WRATH)
	}
}

AddIcon help=offgcd
{
	if Stance(1) and SpellKnown(MAUL) and Mana(more 50) Spell(MAUL)
}

AddIcon help=cd
{
	unless Stance(1) or Stance(3)
	{
		if SpellKnown(STARFALL) Spell(STARFALL)
		if SpellKnown(FORCEOFNATURE) Spell(FORCEOFNATURE)
	}
	if Stance(1) or Stance(3)
	{
		if SpellKnown(BERSERK) Spell(BERSERK)
	}
	if Stance(3)
	{
		if SpellKnown(TIGERSFURY) and Mana(less 40) Spell(TIGERSFURY)
	}
}
]]
