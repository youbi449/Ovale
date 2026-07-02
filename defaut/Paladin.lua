Ovale.defaut["PALADIN"] =
[[
Define(SEALRIGHTEOUSNESS 21084)
Define(SEALCOMMAND 20375)
Define(SEALVENGEANCE 31801)
Define(SEALCORRUPTION 53736)
Define(JUDGELIGHT 20271)
Define(JUDGEWISDOM 53408)
Define(CONSECRATE 26573)
Define(DIVINESTORM 53385)
Define(HAMMEROFWRATH 24275)
Define(CRUSADERSTRIKE 35395)
Define(HOLYSHOCK 20473)
Define(THEARTOFWAR 59578)
Define(FLASHOFLIGHT 19750)
Define(EXORCISM 879)
Define(AVENGINGWRATH 31884)
Define(SHIELDOFRIGHTEOUSNESS 53600)
Define(HOLYSHIELD 20925)
Define(HAMMEROFTHERIGHTEOUS 53595)
Define(HOLYWRATH 2812)
Define(AVENGERSSHIELD 31935)
Define(HANDOFRECKONING 62124)
Define(TALENTGUARDEDBYTHELIGHT 2194)
Define(DIVINEPLEA 54428)
Define(SACREDSHIELD 53601)
Define(DIVINEPROTECTION 498)
Define(LAYONHANDS 633)

AddCheckBox(consecration SpellName(CONSECRATE) checked)
AddCheckBox(coleredivine SpellName(HOLYWRATH))
AddCheckBox(reckoning SpellName(HANDOFRECKONING))
AddListItem(sceau piete SpellName(SEALRIGHTEOUSNESS))
AddListItem(sceau autorite SpellName(SEALCOMMAND))
AddListItem(sceau vengeance SpellName(SEALVENGEANCE) default)
AddListItem(jugement lumiere SpellName(JUDGELIGHT) default)
AddListItem(jugement sagesse SpellName(JUDGEWISDOM))

SpellInfo(CONSECRATE cd=8)
SpellInfo(CRUSADERSTRIKE cd=4)
SpellInfo(DIVINESTORM cd=10)
SpellInfo(HAMMEROFTHERIGHTEOUS cd=6)
SpellInfo(SHIELDOFRIGHTEOUSNESS cd=6)
SpellInfo(AVENGERSSHIELD cd=30)
SpellInfo(SACREDSHIELD cd=6)
SpellInfo(DIVINEPROTECTION cd=180)
SpellInfo(LAYONHANDS cd=1200)
SpellAddBuff(SACREDSHIELD SACREDSHIELD=30)

AddIcon help=main
{
	unless InCombat()
	{
		if List(sceau piete) and SpellKnown(SEALRIGHTEOUSNESS) and BuffExpires(SEALRIGHTEOUSNESS 400) Spell(SEALRIGHTEOUSNESS)
		if List(sceau autorite) and SpellKnown(SEALCOMMAND) and BuffExpires(SEALCOMMAND 400) Spell(SEALCOMMAND)
		if List(sceau vengeance)
		{
			if SpellKnown(SEALVENGEANCE) and BuffExpires(SEALVENGEANCE 400) Spell(SEALVENGEANCE)
			if SpellKnown(SEALCORRUPTION) and BuffExpires(SEALCORRUPTION 400) Spell(SEALCORRUPTION)
		}
	}

	if HasShield() and { SpellKnown(HAMMEROFTHERIGHTEOUS) or SpellKnown(SHIELDOFRIGHTEOUSNESS) }
	{
		if SpellKnown(HAMMEROFWRATH) and TargetLifePercent(less 20) Spell(HAMMEROFWRATH usable=1)
		if SpellKnown(HAMMEROFTHERIGHTEOUS) Spell(HAMMEROFTHERIGHTEOUS)
		if List(jugement lumiere) and SpellKnown(JUDGELIGHT) Spell(JUDGELIGHT)
		if List(jugement sagesse) and SpellKnown(JUDGEWISDOM) Spell(JUDGEWISDOM)
		if CheckBoxOn(consecration) and SpellKnown(CONSECRATE) Spell(CONSECRATE)
		if SpellKnown(SHIELDOFRIGHTEOUSNESS) Spell(SHIELDOFRIGHTEOUSNESS)
		if SpellKnown(HOLYSHIELD) Spell(HOLYSHIELD)
		if SpellKnown(AVENGERSSHIELD) Spell(AVENGERSSHIELD)
		if BuffPresent(THEARTOFWAR) and SpellKnown(EXORCISM) Spell(EXORCISM)
		if CheckBoxOn(coleredivine) and SpellKnown(HOLYWRATH) Spell(HOLYWRATH)
	}

	if SpellKnown(DIVINESTORM) or SpellKnown(CRUSADERSTRIKE)
	{
		if List(jugement lumiere) and SpellKnown(JUDGELIGHT) Spell(JUDGELIGHT)
		if List(jugement sagesse) and SpellKnown(JUDGEWISDOM) Spell(JUDGEWISDOM)
		if SpellKnown(CRUSADERSTRIKE) Spell(CRUSADERSTRIKE)
		if CheckBoxOn(reckoning) and SpellKnown(HANDOFRECKONING) Spell(HANDOFRECKONING usable=1)
		if SpellKnown(DIVINESTORM) Spell(DIVINESTORM)
		if SpellKnown(HAMMEROFWRATH) and TargetLifePercent(less 20) Spell(HAMMEROFWRATH usable=1)
		if CheckBoxOn(consecration) and SpellKnown(CONSECRATE) Spell(CONSECRATE)
		if BuffPresent(THEARTOFWAR) and SpellKnown(EXORCISM) Spell(EXORCISM)
		if CheckBoxOn(coleredivine) and SpellKnown(HOLYWRATH) Spell(HOLYWRATH)
	}

	if SpellKnown(HAMMEROFWRATH) and TargetLifePercent(less 20) Spell(HAMMEROFWRATH usable=1)
	if List(jugement lumiere) and SpellKnown(JUDGELIGHT) Spell(JUDGELIGHT)
	if List(jugement sagesse) and SpellKnown(JUDGEWISDOM) Spell(JUDGEWISDOM)
	if SpellKnown(HOLYSHOCK) Spell(HOLYSHOCK)
	if BuffPresent(THEARTOFWAR) and SpellKnown(EXORCISM) Spell(EXORCISM)
	if CheckBoxOn(consecration) and SpellKnown(CONSECRATE) Spell(CONSECRATE)
}

AddIcon help=aoe
{
	if SpellKnown(DIVINESTORM) or SpellKnown(CRUSADERSTRIKE)
	{
		if SpellKnown(DIVINESTORM) Spell(DIVINESTORM)
		if CheckBoxOn(consecration) and SpellKnown(CONSECRATE) Spell(CONSECRATE)
		if BuffPresent(THEARTOFWAR) and SpellKnown(EXORCISM) Spell(EXORCISM)
		if SpellKnown(HAMMEROFWRATH) and TargetLifePercent(less 20) Spell(HAMMEROFWRATH usable=1)
		if CheckBoxOn(coleredivine) and SpellKnown(HOLYWRATH) Spell(HOLYWRATH)
	}
	if HasShield()
	{
		if SpellKnown(HAMMEROFTHERIGHTEOUS) Spell(HAMMEROFTHERIGHTEOUS)
		if CheckBoxOn(consecration) and SpellKnown(CONSECRATE) Spell(CONSECRATE)
		if SpellKnown(AVENGERSSHIELD) Spell(AVENGERSSHIELD)
		if SpellKnown(SHIELDOFRIGHTEOUSNESS) Spell(SHIELDOFRIGHTEOUSNESS)
		if SpellKnown(HOLYSHIELD) Spell(HOLYSHIELD)
	}
}

AddIcon help=mitigation
{
	if HasShield() and { SpellKnown(HAMMEROFTHERIGHTEOUS) or TalentPoints(TALENTGUARDEDBYTHELIGHT more 0) } and TargetTargetIsPlayer()
	{
		if LifePercent(less 90) and SpellKnown(SACREDSHIELD) and BuffExpires(SACREDSHIELD 2) Spell(SACREDSHIELD)
		if LifePercent(less 45) and SpellKnown(DIVINEPROTECTION) Spell(DIVINEPROTECTION usable=1)
		if LifePercent(less 20) and SpellKnown(LAYONHANDS) Spell(LAYONHANDS usable=1)
	}
}

AddIcon help=cd
{
	if SpellKnown(DIVINEPLEA) and ManaPercent(less 35) Spell(DIVINEPLEA)
	if SpellKnown(AVENGINGWRATH) Spell(AVENGINGWRATH)
}
]]
