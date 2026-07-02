Ovale.defaut["ROGUE"] =
[[
Define(ENVENOM 32645)
Define(TALENTVILEPOISONS 682)
Define(TALENTCUTTOTHECHASE 2070)
Define(SLICEANDDICE 5171)
Define(RUPTURE 1943)
Define(DEEPWOUNDS 12721)
Define(GARROTE 703)
Define(REND 772)
Define(RIP 1079)
Define(HUNGERFORBLOOD 51662)
Define(EVISCERATE 2098)
Define(MUTILATE 1329)
Define(SINISTERSTRIKE 1752)
Define(HEMORRHAGE 16511)
Define(BACKSTAB 53)
Define(ADRENALINERUSH 13750)
Define(KILLINGSPREE 51690)
Define(BLADEFLURRY 13877)
Define(COLDBLOOD 14177)
Define(PREPARATION 14185)
Define(PREMEDITATION 14183)
Define(VANISH 1856)
Define(TRICKSOFTHETRADE 57934)
Define(CLOAKOFSHADOWS 31224)
Define(FANOFKNIVES 51723)
Define(EXPOSEARMOR 8647)
Define(GHOSTLYSTRIKE 14278)
Define(SHADOWSTEP 36554)
Define(SHADOWDANCE 51713)
Define(AMBUSH 8676)

AddCheckBox(expose SpellName(EXPOSEARMOR))
AddCheckBox(selfbleed SpellName(RUPTURE) checked)

SpellAddBuff(SLICEANDDICE SLICEANDDICE=21)
SpellAddBuff(HUNGERFORBLOOD HUNGERFORBLOOD=60)
SpellAddTargetDebuff(RUPTURE RUPTURE=16)
SpellAddTargetDebuff(GARROTE GARROTE=18)
SpellAddTargetDebuff(EXPOSEARMOR EXPOSEARMOR=30)

AddIcon help=main
{
	if SpellKnown(HUNGERFORBLOOD)
	{
		if CheckBoxOn(selfbleed)
			and BuffExpires(HUNGERFORBLOOD 2)
			and TargetDebuffExpires(RUPTURE 0)
			and TargetDebuffExpires(DEEPWOUNDS 0)
			and TargetDebuffExpires(REND 0)
			and TargetDebuffExpires(RIP 0)
			and TargetDebuffExpires(GARROTE 0)
		{
			if SpellKnown(GARROTE) Spell(GARROTE usable=1)
			if ComboPoints(more 0) and SpellKnown(RUPTURE) Spell(RUPTURE)
		}
		if { TargetDebuffPresent(RUPTURE) or TargetDebuffPresent(DEEPWOUNDS) or TargetDebuffPresent(REND) or TargetDebuffPresent(RIP) or TargetDebuffPresent(GARROTE) } and BuffExpires(HUNGERFORBLOOD 2) Spell(HUNGERFORBLOOD)
		if ComboPoints(more 0) and BuffExpires(SLICEANDDICE 2) Spell(SLICEANDDICE)
		if CheckBoxOn(expose) and ComboPoints(more 3) and SpellKnown(EXPOSEARMOR) and TargetDebuffExpires(EXPOSEARMOR 2) Spell(EXPOSEARMOR)
		if ComboPoints(more 4)
		{
			if SpellKnown(ENVENOM) Spell(ENVENOM)
			Spell(EVISCERATE)
		}
		if SpellKnown(MUTILATE) Spell(MUTILATE)
	}

	if SpellKnown(KILLINGSPREE) or SpellKnown(ADRENALINERUSH)
	{
		if CheckBoxOn(expose) and ComboPoints(more 3) and SpellKnown(EXPOSEARMOR) and TargetDebuffExpires(EXPOSEARMOR 2) Spell(EXPOSEARMOR)
		if ComboPoints(more 0) and BuffExpires(SLICEANDDICE 2) Spell(SLICEANDDICE)
		if ComboPoints(more 4) and TargetDeadIn(more 10) and TargetDebuffExpires(RUPTURE 0 mine=1) Spell(RUPTURE)
		if ComboPoints(more 4) Spell(EVISCERATE)
		if SpellKnown(SINISTERSTRIKE) Spell(SINISTERSTRIKE)
	}

	if SpellKnown(HEMORRHAGE)
	{
		if CheckBoxOn(expose) and ComboPoints(more 3) and SpellKnown(EXPOSEARMOR) and TargetDebuffExpires(EXPOSEARMOR 2) Spell(EXPOSEARMOR)
		if SpellKnown(PREMEDITATION) Spell(PREMEDITATION usable=1)
		if ComboPoints(more 0) and BuffExpires(SLICEANDDICE 2) Spell(SLICEANDDICE)
		if BuffPresent(SHADOWDANCE)
		{
			if SpellKnown(GARROTE) and TargetDebuffExpires(GARROTE 0 mine=1) Spell(GARROTE usable=1)
			if SpellKnown(SHADOWSTEP) Spell(SHADOWSTEP)
			if ComboPoints(less 5) and SpellKnown(AMBUSH) Spell(AMBUSH usable=1)
		}
		if ComboPoints(more 4) and TargetDeadIn(more 10) and TargetDebuffExpires(RUPTURE 0 mine=1)
		{
			Spell(RUPTURE)
		}
		if ComboPoints(more 4) Spell(EVISCERATE)
		if SpellKnown(BACKSTAB) Spell(BACKSTAB)
		if SpellKnown(GHOSTLYSTRIKE) Spell(GHOSTLYSTRIKE)
		Spell(HEMORRHAGE)
	}

	if ComboPoints(more 0) and BuffExpires(SLICEANDDICE 2) Spell(SLICEANDDICE)
	if ComboPoints(more 4) Spell(EVISCERATE)
	if SpellKnown(SINISTERSTRIKE) Spell(SINISTERSTRIKE)
	if SpellKnown(BACKSTAB) Spell(BACKSTAB)
}

AddIcon help=aoe
{
	if ComboPoints(more 0) and BuffExpires(SLICEANDDICE 2) Spell(SLICEANDDICE)
	if SpellKnown(BLADEFLURRY) Spell(BLADEFLURRY)
	if SpellKnown(FANOFKNIVES) Spell(FANOFKNIVES)
	if ComboPoints(more 4)
	{
		if SpellKnown(ENVENOM) Spell(ENVENOM)
		Spell(EVISCERATE)
	}
}

AddIcon help=cd
{
	if SpellKnown(COLDBLOOD) Spell(COLDBLOOD)
	if SpellKnown(SHADOWDANCE) Spell(SHADOWDANCE)
	if SpellKnown(BLADEFLURRY) Spell(BLADEFLURRY)
	if SpellKnown(ADRENALINERUSH) Spell(ADRENALINERUSH)
	if SpellKnown(KILLINGSPREE) Spell(KILLINGSPREE)
	if SpellKnown(VANISH) Spell(VANISH)
	if SpellKnown(PREPARATION) Spell(PREPARATION)
}

AddIcon size=small
{
	if SpellKnown(TRICKSOFTHETRADE) Spell(TRICKSOFTHETRADE)
}

AddIcon size=small
{
	if SpellKnown(CLOAKOFSHADOWS) Spell(CLOAKOFSHADOWS)
}
]]
