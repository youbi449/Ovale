Ovale.defaut["WARRIOR"] =
[[
Define(THUNDERCLAP 6343)
Define(SHOCKWAVE 46968)
Define(DEMOSHOUT 1160)
Define(COMMANDSHOUT 469)
Define(BATTLESHOUT 2048)
Define(BLOODRAGE 2687)
Define(REVENGE 6572)
Define(SHIELDSLAM 23922)
Define(DEVASTATE 20243)
Define(VICTORY 34428)
Define(EXECUTE 5308)
Define(BLOODTHIRST 23881)
Define(WHIRLWIND 1680)
Define(SLAMBUFF 46916)
Define(SLAM 1464)
Define(MORTALSTRIKE 12294)
Define(SWEEPINGSTRIKES 12328)
Define(SLAMTALENT 2233)
Define(CLEAVE 845)
Define(HEROICSTRIKE 78)
Define(SUNDER 7386)
Define(CONCUSSIONBLOW 12809)
Define(REND 772)
Define(OVERPOWER 7384)
Define(SHIELDBLOCK 2565)
Define(SHIELDWALL 871)
Define(LASTSTAND 12975)
Define(ENRAGEDREGENERATION 55694)
Define(DEATHWISH 12292)
Define(RECKLESSNESS 1719)
Define(BLADESTORM 46924)
Define(SHATTERINGTHROW 64382)
Define(SUDDENDEATH 52437)
Define(RETALIATION 20230)
Define(TASTEFORBLOOD 56636)

Define(DEMORALIZINGROAR 48560)
Define(CURSEOFWEAKNESS 50511)

AddCheckBox(multi L(AOE))
AddCheckBox(demo SpellName(DEMOSHOUT))
AddCheckBox(whirlwind SpellName(WHIRLWIND) checked)
AddCheckBox(sunder SpellName(SUNDER))
AddCheckBox(bloodrage SpellName(BLOODRAGE) checked)
AddListItem(shout none L(None))
AddListItem(shout battle SpellName(BATTLESHOUT) default)
AddListItem(shout command SpellName(COMMANDSHOUT))

SpellAddTargetDebuff(THUNDERCLAP THUNDERCLAP=30)
SpellAddTargetDebuff(DEMOSHOUT DEMOSHOUT=45)
SpellAddTargetDebuff(REND REND=15)
SpellAddTargetDebuff(DEVASTATE SUNDER=30)
SpellAddTargetDebuff(SUNDER SUNDER=30)
SpellAddBuff(BATTLESHOUT BATTLESHOUT=120)
SpellAddBuff(COMMANDSHOUT COMMANDSHOUT=120)
SpellAddBuff(SLAM SLAMBUFF=-1)
SpellAddBuff(SWEEPINGSTRIKES SWEEPINGSTRIKES=10)
SpellInfo(WHIRLWIND cd=8)
SpellInfo(BLOODTHIRST cd=4)
SpellInfo(MORTALSTRIKE cd=6)
SpellInfo(SWEEPINGSTRIKES cd=30)
SpellInfo(DEATHWISH cd=180)
SpellInfo(SHATTERINGTHROW cd=300)
SpellInfo(BLOODRAGE cd=60)
SpellInfo(SHIELDBLOCK cd=40)
SpellInfo(LASTSTAND cd=180)
SpellInfo(SHIELDWALL cd=300)
SpellInfo(ENRAGEDREGENERATION cd=180)
SpellInfo(HEROICSTRIKE toggle=1)
SpellInfo(CLEAVE toggle=1)
ScoreSpells(WHIRLWIND BLOODTHIRST SLAM REND MORTALSTRIKE EXECUTE SHIELDSLAM REVENGE)

AddIcon help=main
{
	if List(shout command) and SpellKnown(COMMANDSHOUT) and BuffExpires(COMMANDSHOUT 3)
		Spell(COMMANDSHOUT nored=1)

	if List(shout battle) and SpellKnown(BATTLESHOUT) and BuffExpires(BATTLESHOUT 3)
		Spell(BATTLESHOUT nored=1)

	if Stance(2) # Defensive
	{
		if SpellKnown(DEMOSHOUT)
			and CheckBoxOn(demo)
			and { TargetClassification(elite) or TargetClassification(worldboss) }
			and TargetDebuffExpires(DEMOSHOUT 2)
			and TargetDebuffExpires(DEMORALIZINGROAR 0)
			and TargetDebuffExpires(CURSEOFWEAKNESS 0)
			Spell(DEMOSHOUT nored=1)
		if HasShield() and BuffPresent(SHIELDBLOCK) and SpellKnown(SHIELDSLAM) Spell(SHIELDSLAM)
		if SpellKnown(REVENGE) Spell(REVENGE usable=1)
		if HasShield() and SpellKnown(SHIELDSLAM) Spell(SHIELDSLAM)
		if SpellKnown(SHOCKWAVE) Spell(SHOCKWAVE)
		if SpellKnown(CONCUSSIONBLOW) Spell(CONCUSSIONBLOW)
		if SpellKnown(BLOODTHIRST) Spell(BLOODTHIRST)
		if SpellKnown(MORTALSTRIKE) Spell(MORTALSTRIKE)
		if SpellKnown(DEVASTATE) Spell(DEVASTATE)
		if CheckBoxOn(sunder) and SpellKnown(SUNDER) and Mana(more 20) Spell(SUNDER priority=2)
	}

	if Stance(3) # Berserker
	{
		if HasShield() and SpellKnown(SHIELDSLAM) Spell(SHIELDSLAM)
		if SpellKnown(SHOCKWAVE) Spell(SHOCKWAVE)
		if SpellKnown(CONCUSSIONBLOW) Spell(CONCUSSIONBLOW)

		if SpellKnown(BLOODTHIRST) Spell(BLOODTHIRST)
		if CheckBoxOn(whirlwind) and SpellKnown(WHIRLWIND) Spell(WHIRLWIND)
		if SpellKnown(SLAM) and BuffPresent(SLAMBUFF)
		{
			if BuffExpires(SLAMBUFF 2.5)
				Spell(SLAM nored=1)
			Spell(SLAM priority=2 nored=1)
		}
		if SpellKnown(VICTORY) Spell(VICTORY usable=1)
		if SpellKnown(MORTALSTRIKE) Spell(MORTALSTRIKE)
		if SpellKnown(SLAM) and TalentPoints(SLAMTALENT more 1) Spell(SLAM priority=2)
		if SpellKnown(EXECUTE) and TargetLifePercent(less 20) Spell(EXECUTE usable=1)
	}

	if Stance(1) # Battle
	{
		if SpellKnown(REND) and TargetDebuffExpires(REND 0 mine=1) and TargetDeadIn(more 8)
			Spell(REND)
		if SpellKnown(OVERPOWER) and BuffPresent(TASTEFORBLOOD)
			Spell(OVERPOWER usable=1)
		if SpellKnown(OVERPOWER) Spell(OVERPOWER usable=1)

		if SpellKnown(BLADESTORM) Spell(BLADESTORM)
		if SpellKnown(EXECUTE) and { BuffPresent(SUDDENDEATH) or TargetLifePercent(less 20) } Spell(EXECUTE usable=1)
		if SpellKnown(MORTALSTRIKE) and TargetLifePercent(more 20) Spell(MORTALSTRIKE)
		if SpellKnown(OVERPOWER) Spell(OVERPOWER usable=1)
		if SpellKnown(VICTORY) Spell(VICTORY usable=1)

		if SpellKnown(SLAM) and TalentPoints(SLAMTALENT more 1) Spell(SLAM priority=2)
		if SpellKnown(BLOODTHIRST) Spell(BLOODTHIRST)
		if HasShield() and SpellKnown(SHIELDSLAM) Spell(SHIELDSLAM)
		if SpellKnown(SHOCKWAVE) Spell(SHOCKWAVE)
		if SpellKnown(CONCUSSIONBLOW) Spell(CONCUSSIONBLOW)
	}

}

AddIcon help=aoe
{
	if Stance(2) # Defensive
	{
		if SpellKnown(THUNDERCLAP) Spell(THUNDERCLAP)
		if SpellKnown(SHOCKWAVE) Spell(SHOCKWAVE)
		if SpellKnown(REVENGE) Spell(REVENGE usable=1)
		if HasShield() and SpellKnown(SHIELDSLAM) Spell(SHIELDSLAM)
		if SpellKnown(DEVASTATE) Spell(DEVASTATE)
	}
	if Stance(3) # Berserker
	{
		if CheckBoxOn(whirlwind) and SpellKnown(WHIRLWIND) Spell(WHIRLWIND)
		if SpellKnown(CLEAVE) and Mana(more 65) Spell(CLEAVE)
	}
	if Stance(1) # Battle
	{
		if SpellKnown(SWEEPINGSTRIKES) Spell(SWEEPINGSTRIKES)
		if SpellKnown(THUNDERCLAP) Spell(THUNDERCLAP)
		if SpellKnown(BLADESTORM) Spell(BLADESTORM)
		if SpellKnown(CLEAVE) and Mana(more 65) Spell(CLEAVE)
		if BuffPresent(SWEEPINGSTRIKES) and SpellKnown(OVERPOWER) Spell(OVERPOWER usable=1)
		if BuffPresent(SWEEPINGSTRIKES) and SpellKnown(MORTALSTRIKE) Spell(MORTALSTRIKE)
	}
}

AddIcon help=offgcd
{
	if CheckBoxOn(bloodrage) and SpellKnown(BLOODRAGE) and InCombat() and Mana(less 20)
		Spell(BLOODRAGE)

	if CheckBoxOff(multi)
	{
		if SpellKnown(HEROICSTRIKE) and Mana(more 60)
			Spell(HEROICSTRIKE)
	}
	if CheckBoxOn(multi)
	{
		if SpellKnown(CLEAVE) and Mana(more 65) Spell(CLEAVE)
		if SpellKnown(HEROICSTRIKE) and Mana(more 75)
			Spell(HEROICSTRIKE)
	}
}

AddIcon help=mitigation
{
	if Stance(2) and { SpellKnown(SHIELDSLAM) or SpellKnown(DEVASTATE) or SpellKnown(LASTSTAND) } and TargetTargetIsPlayer()
	{
		if HasShield() and LifePercent(less 75) and SpellKnown(SHIELDBLOCK) Spell(SHIELDBLOCK usable=1)
		if LifePercent(less 45) and SpellKnown(LASTSTAND) Spell(LASTSTAND usable=1)
		if LifePercent(less 35) and SpellKnown(SHIELDWALL) Spell(SHIELDWALL usable=1)
		if LifePercent(less 25) and SpellKnown(ENRAGEDREGENERATION) Spell(ENRAGEDREGENERATION usable=1)
	}
}

AddIcon help=cd
{
	if Stance(3) # Berserker
	{
		if SpellKnown(DEATHWISH) Spell(DEATHWISH)
		if SpellKnown(RECKLESSNESS) Spell(RECKLESSNESS)
	}
	if Stance(1) # Battle
	{
		if SpellKnown(BLADESTORM) Spell(BLADESTORM)
		if SpellKnown(SHATTERINGTHROW) Spell(SHATTERINGTHROW)
		if SpellKnown(RETALIATION) Spell(RETALIATION)
	}
	Item(Trinket0Slot usable=1)
	Item(Trinket1Slot usable=1)
}

]]
