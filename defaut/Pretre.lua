Ovale.defaut["PRIEST"]=
[[
Define(SWP 589)
Define(VT 34916)
Define(VE 15286)
Define(SF 15473)
Define(MF 15407)
Define(MB 8092)
Define(DP 2944)
Define(SWD 32379)
Define(SW 15257)
Define(IF 48168)
Define(Focus 14751)
Define(Dispersion 47585)
Define(Shadowfiend 34433)
Define(SMITE 585)
Define(HOLYFIRE 14914)
Define(MINDSEAR 48045)
Define(HOLYNOVA 15237)
Define(Heroism 32182)
Define(Bloodlust 2825)
Define(SHADOWWEAVING 15332)

AddCheckBox(swd SpellName(SWD))
AddCheckBox(swpweaving SpellName(SWP) checked)

SpellAddTargetDebuff(SWP SWP=18)
SpellAddTargetDebuff(VT VT=15)
SpellAddTargetDebuff(DP DP=24)
SpellAddBuff(IF IF=1800)
SpellAddBuff(SF SF=-1)
SpellInfo(MB cd=5.5)

AddIcon help=main
{
	unless InCombat()
	{
		if SpellKnown(SF) and BuffExpires(SF 2) Spell(SF)
		if SpellKnown(IF) and BuffExpires(IF 400) Spell(IF)
		if SpellKnown(VE) and BuffExpires(VE 2) Spell(VE)
	}

	if SpellKnown(VT) or SpellKnown(MF)
	{
		if SpellKnown(VT) and TargetDebuffExpires(VT 1.4 mine=1 haste=spell) and TargetDeadIn(more 8) Spell(VT)
		if SpellKnown(DP) and TargetDebuffExpires(DP 1 mine=1) and TargetDeadIn(more 8) Spell(DP)
		if CheckBoxOff(swpweaving) and SpellKnown(SWP) and TargetDebuffExpires(SWP 1 mine=1) and TargetDeadIn(more 8) Spell(SWP)
		if CheckBoxOn(swpweaving) and BuffPresent(SHADOWWEAVING stacks=5) and SpellKnown(SWP) and TargetDebuffExpires(SWP 1 mine=1) and TargetDeadIn(more 8) Spell(SWP)
		if SpellKnown(MB) Spell(MB)
		if CheckBoxOn(swd) and SpellKnown(SWD) Spell(SWD priority=2)
		if SpellKnown(MF) Spell(MF priority=2)
	}

	if SpellKnown(DP) and TargetDebuffExpires(DP 1 mine=1) and TargetDeadIn(more 8) Spell(DP)
	if CheckBoxOff(swpweaving) and SpellKnown(SWP) and TargetDebuffExpires(SWP 1 mine=1) and TargetDeadIn(more 8) Spell(SWP)
	if CheckBoxOn(swpweaving) and BuffPresent(SHADOWWEAVING stacks=5) and SpellKnown(SWP) and TargetDebuffExpires(SWP 1 mine=1) and TargetDeadIn(more 8) Spell(SWP)
	if SpellKnown(HOLYFIRE) Spell(HOLYFIRE)
	if SpellKnown(MB) Spell(MB)
	if SpellKnown(SMITE) Spell(SMITE)
}

AddIcon help=aoe
{
	if SpellKnown(MINDSEAR) Spell(MINDSEAR)
	if SpellKnown(HOLYNOVA) Spell(HOLYNOVA)
	if SpellKnown(VT) and TargetDebuffExpires(VT 1.4 mine=1 haste=spell) and TargetDeadIn(more 24) Spell(VT)
	if SpellKnown(DP) and TargetDebuffExpires(DP 1 mine=1) and TargetDeadIn(more 8) Spell(DP)
	if CheckBoxOff(swpweaving) and SpellKnown(SWP) and TargetDebuffExpires(SWP 1 mine=1) and TargetDeadIn(more 8) Spell(SWP)
	if CheckBoxOn(swpweaving) and BuffPresent(SHADOWWEAVING stacks=5) and SpellKnown(SWP) and TargetDebuffExpires(SWP 1 mine=1) and TargetDeadIn(more 8) Spell(SWP)
}

AddIcon help=cd
{
	if SpellKnown(Focus) Spell(Focus usable=1)
	if SpellKnown(Shadowfiend) and Mana(less 4000) and PetPresent(no) Spell(Shadowfiend usable=1)
	if SpellKnown(Dispersion) and ManaPercent(less 25) Spell(Dispersion usable=1)
}

AddIcon size=small nocd=1 { if SpellKnown(VT) and TargetDebuffExpires(VT 1.4 mine=1 haste=spell) Spell(VT) }
AddIcon size=small nocd=1 { if SpellKnown(SWP) and TargetDebuffExpires(SWP 1 mine=1) Spell(SWP) }
AddIcon size=small nocd=1 { if SpellKnown(DP) and TargetDebuffExpires(DP 1 mine=1) Spell(DP) }
]]
