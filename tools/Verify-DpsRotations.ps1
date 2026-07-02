param(
    [switch]$SkipLuaParse
)

$ErrorActionPreference = "Stop"

$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
Set-Location $RepoRoot

function Assert-Match {
    param(
        [string]$File,
        [string]$Pattern,
        [string]$Message
    )

    $text = Get-Content -LiteralPath $File -Raw
    if ($text -notmatch $Pattern) {
        throw $Message
    }
}

function Assert-Order {
    param(
        [string]$Name,
        [string]$File,
        [string]$Before,
        [string]$After,
        [int]$BeforeMin = 0,
        [int]$AfterMin = 0
    )

    $lines = Get-Content -LiteralPath $File
    $beforeMatches = $lines | Select-String -Pattern $Before
    if ($BeforeMin -gt 0) {
        $beforeMatches = $beforeMatches | Where-Object { $_.LineNumber -ge $BeforeMin }
    }

    $afterMatches = $lines | Select-String -Pattern $After
    if ($AfterMin -gt 0) {
        $afterMatches = $afterMatches | Where-Object { $_.LineNumber -ge $AfterMin }
    }

    $beforeLine = ($beforeMatches | Select-Object -First 1).LineNumber
    $afterLine = ($afterMatches | Select-Object -First 1).LineNumber

    if (-not $beforeLine -or -not $afterLine) {
        throw "MISS $Name`: before=$beforeLine after=$afterLine"
    }

    if ($beforeLine -gt $afterLine) {
        throw "ORDER $Name`: before line $beforeLine > after line $afterLine"
    }
}

function Get-IconBlockLines {
    param(
        [string]$File,
        [string]$Help
    )

    $lines = Get-Content -LiteralPath $File
    $start = ($lines | Select-String -Pattern "AddIcon help=$Help" | Select-Object -First 1).LineNumber
    if (-not $start) {
        throw "MISS AddIcon help=$Help in $File"
    }

    $next = ($lines | Select-String -Pattern "AddIcon " |
        Where-Object { $_.LineNumber -gt $start } |
        Select-Object -First 1).LineNumber
    if (-not $next) {
        $next = $lines.Count + 1
    }

    return $lines[($start - 1)..($next - 2)]
}

[xml](Get-Content -Path "embeds.xml" -Raw) | Out-Null
[xml](Get-Content -Path "OvaleIcone.xml" -Raw) | Out-Null

$toc = Get-Content "Ovale.toc"
$defaultFiles = Get-ChildItem "defaut" -Filter "*.lua" | ForEach-Object { "defaut\" + $_.Name }
$missingFromToc = $defaultFiles | Where-Object { $toc -notcontains $_ }
if ($missingFromToc) {
    throw "Missing from Ovale.toc: $($missingFromToc -join ', ')"
}

$allowedFunctions = @(
    "AddCheckBox",
    "AddIcon",
    "AddListItem",
    "BuffExpires",
    "BuffPresent",
    "CheckBoxOff",
    "CheckBoxOn",
    "ComboPoints",
    "Define",
    "Glyph",
    "HasShield",
    "InCombat",
    "Item",
    "L",
    "LifePercent",
    "List",
    "Mana",
    "ManaPercent",
    "PetPresent",
    "ScoreSpells",
    "Spell",
    "SpellAddBuff",
    "SpellAddTargetDebuff",
    "SpellInfo",
    "SpellKnown",
    "SpellName",
    "Stance",
    "TalentPoints",
    "TargetClassification",
    "TargetDeadIn",
    "TargetDebuffExpires",
    "TargetDebuffPresent",
    "TargetInRange",
    "TargetLifePercent",
    "TargetTargetIsPlayer",
    "TotemExpires",
    "Tracking",
    "WeaponEnchantExpires"
)
$functionCalls = Get-ChildItem "defaut" -Filter "*.lua" |
    ForEach-Object { Select-String -LiteralPath $_.FullName -Pattern "\b[A-Za-z][A-Za-z0-9]*\(" -AllMatches } |
    ForEach-Object { $_.Matches.Value.TrimEnd("(") } |
    Sort-Object -Unique
$unknownFunctions = $functionCalls | Where-Object { $allowedFunctions -notcontains $_ }
if ($unknownFunctions) {
    throw "Unknown Ovale script functions: $($unknownFunctions -join ', ')"
}

$coverageChecks = @(
    @{ Spec = "Warrior Arms"; File = "defaut/Guerrier.lua"; Patterns = @("REND", "TASTEFORBLOOD", "OVERPOWER", "MORTALSTRIKE", "SUDDENDEATH", "SLAMTALENT") },
    @{ Spec = "Warrior Fury"; File = "defaut/Guerrier.lua"; Patterns = @("SLAMBUFF", "BLOODTHIRST", "WHIRLWIND", "EXECUTE", "BLOODRAGE") },
    @{ Spec = "Paladin Retribution"; File = "defaut/Paladin.lua"; Patterns = @("JUDGELIGHT", "JUDGEWISDOM", "CRUSADERSTRIKE", "DIVINESTORM", "THEARTOFWAR", "EXORCISM", "DIVINEPLEA") },
    @{ Spec = "Hunter Beast Mastery"; File = "defaut/Chasseur.lua"; Patterns = @("KILLCOMMAND", "KILLSHOT", "SERPENTSTING", "ARCANESHOT", "STEADYSHOT", "RAPTORSTRIKE", "MONGOOSEBITE", "BESTIALWRATH") },
    @{ Spec = "Hunter Marksmanship"; File = "defaut/Chasseur.lua"; Patterns = @("CHIMERASHOT", "SERPENTSTING", "AIMEDSHOT", "STEADYSHOT", "READINESS") },
    @{ Spec = "Hunter Survival"; File = "defaut/Chasseur.lua"; Patterns = @("EXPLOSIVESHOT", "BLACKARROW", "SERPENTSTING", "AIMEDSHOT", "STEADYSHOT") },
    @{ Spec = "Rogue Assassination"; File = "defaut/Voleur.lua"; Patterns = @("HUNGERFORBLOOD", "SLICEANDDICE", "RUPTURE", "MUTILATE", "ENVENOM") },
    @{ Spec = "Rogue Combat"; File = "defaut/Voleur.lua"; Patterns = @("SLICEANDDICE", "RUPTURE", "EVISCERATE", "SINISTERSTRIKE", "KILLINGSPREE", "ADRENALINERUSH") },
    @{ Spec = "Rogue Subtlety"; File = "defaut/Voleur.lua"; Patterns = @("HEMORRHAGE", "SHADOWSTEP", "SHADOWDANCE", "AMBUSH", "EVISCERATE") },
    @{ Spec = "Death Knight Blood"; File = "defaut/Chevalier.lua"; Patterns = @("HEARTSTRIKE", "DEATHSTRIKE", "DEATHCOIL", "FROSTFEVER", "BLOODPLAGUE") },
    @{ Spec = "Death Knight Frost"; File = "defaut/Chevalier.lua"; Patterns = @("FREEZINGFOG", "HOWLINGBLAST", "OBLITERATE", "FROSTSTRIKE", "BLOODSTRIKE", "FROSTFEVER", "BLOODPLAGUE") },
    @{ Spec = "Death Knight Unholy"; File = "defaut/Chevalier.lua"; Patterns = @("BONESHIELD", "SCOURGESTRIKE", "DEATHANDECAY", "BLOODBOIL", "DEATHCOIL", "GHOULFRENZY", "SUMMONGARGOYLE") },
    @{ Spec = "Druid Feral Cat"; File = "defaut/Druide.lua"; Patterns = @("SAVAGEROAR", "MANGLECAT", "RAKE", "RIP", "SHRED", "FEROCIOUSBITE") },
    @{ Spec = "Druid Balance"; File = "defaut/Druide.lua"; Patterns = @("INSECTSWARM", "MOONFIRE", "ECLIPSEWRATH", "ECLIPSESTARFIRE", "STARFALL", "FORCEOFNATURE") },
    @{ Spec = "Shaman Enhancement"; File = "defaut/Chaman.lua"; Patterns = @("STORMSTRIKE", "MAELSTROMWEAPON", "LAVALASH", "EARTHSHOCK", "MAGMATOTEM", "FERALSPIRIT") },
    @{ Spec = "Shaman Elemental"; File = "defaut/Chaman.lua"; Patterns = @("FLAMESHOCK", "LAVABURST", "LIGHTNINGBOLT", "CHAINLIGHTNING", "TOTEMOFWRATH", "THUNDERSTORM") },
    @{ Spec = "Mage Arcane"; File = "defaut/Mage.lua"; Patterns = @("ARCANEBLAST", "MISSILEBARRAGE", "ARCANEMISSILES", "ARCANEBARRAGE", "ARCANEPOWER") },
    @{ Spec = "Mage Fire"; File = "defaut/Mage.lua"; Patterns = @("LIVINGBOMB", "HOTSTREAK", "PYROBLAST", "SCORCH", "FIREBALL") },
    @{ Spec = "Mage Frost"; File = "defaut/Mage.lua"; Patterns = @("DEEPFREEZE", "FINGERFROST", "BRAINFREEZE", "FROSTFIREBOLT", "FROSTBOLT") },
    @{ Spec = "Warlock Affliction"; File = "defaut/Demoniste.lua"; Patterns = @("HAUNT", "UNSTABLEAFFLICTION", "CORRUPTION", "CURSEAGONY", "DRAINSOUL", "SHADOWBOLT", "LIFETAP") },
    @{ Spec = "Warlock Demonology"; File = "defaut/Demoniste.lua"; Patterns = @("METAMORPHOSIS", "DECIMATION", "SOULFIRE", "IMMOLATE", "MOLTENCORE", "DEMONICEMPOWERMENT") },
    @{ Spec = "Warlock Destruction"; File = "defaut/Demoniste.lua"; Patterns = @("IMMOLATE", "CONFLAGRATE", "CHAOSBOLT", "INCINERATE", "CURSEDOOM") },
    @{ Spec = "Priest Shadow"; File = "defaut/Pretre.lua"; Patterns = @("VT", "DP", "SWP", "SHADOWWEAVING", "MB", "MF", "SWD") }
)

foreach ($check in $coverageChecks) {
    foreach ($pattern in $check.Patterns) {
        Assert-Match -File $check.File -Pattern ([regex]::Escape($pattern)) -Message "MISS $($check.Spec): $pattern"
    }
}

Assert-Order "Ret Judgement before Crusader Strike" "defaut/Paladin.lua" "List\(jugement lumiere\).*JUDGELIGHT" "Spell\(CRUSADERSTRIKE\)" 70 70
Assert-Order "Ret Exorcism is Art of War gated" "defaut/Paladin.lua" "BuffPresent\(THEARTOFWAR\).*Spell\(EXORCISM\)" "CheckBoxOn\(coleredivine\)" 70 70
Assert-Order "Ret Holy Wrath optional" "defaut/Paladin.lua" "AddCheckBox\(coleredivine" "CheckBoxOn\(coleredivine\).*Spell\(HOLYWRATH\)"

$paladinLines = Get-Content -LiteralPath "defaut/Paladin.lua"
for ($i = 0; $i -lt $paladinLines.Count; $i++) {
    if ($paladinLines[$i] -match "Spell\(EXORCISM\)" -and $paladinLines[$i] -notmatch "BuffPresent\(THEARTOFWAR\)") {
        throw "FAIL Ret Exorcism gate: line $($i + 1) can cast Exorcism without The Art of War"
    }
}
Assert-Order "Fury Bloodthirst before Bloodsurge Slam" "defaut/Guerrier.lua" "^\s*if SpellKnown\(BLOODTHIRST\) Spell\(BLOODTHIRST\)$" "BuffPresent\(SLAMBUFF\)" 96 96
Assert-Order "Fury Whirlwind before Bloodsurge Slam" "defaut/Guerrier.lua" "WHIRLWIND\) Spell\(WHIRLWIND\)" "BuffPresent\(SLAMBUFF\)" 96 96
Assert-Order "Arms Rend before Mortal Strike" "defaut/Guerrier.lua" "^\s*Spell\(REND\)$" "MORTALSTRIKE\).*TargetLifePercent\(more 20\)" 0 116
Assert-Order "Arms Taste for Blood condition before Overpower" "defaut/Guerrier.lua" "BuffPresent\(TASTEFORBLOOD\)" "Spell\(OVERPOWER usable=1\)" 0 116
Assert-Order "Arms Taste for Blood Overpower before Mortal Strike" "defaut/Guerrier.lua" "Spell\(OVERPOWER usable=1\)" "MORTALSTRIKE\).*TargetLifePercent\(more 20\)" 116 116
Assert-Order "Arms Taste for Blood Overpower before Bladestorm" "defaut/Guerrier.lua" "Spell\(OVERPOWER usable=1\)" "Spell\(BLADESTORM\)" 116 116
Assert-Order "Warrior Cleave is high rage dump" "defaut/Guerrier.lua" "Mana\(more 65\).*Spell\(CLEAVE\)" "Spell\(HEROICSTRIKE\)" 0 180
Assert-Order "Warrior AoE Sweeping Strikes before single-target cleaves" "defaut/Guerrier.lua" "Spell\(SWEEPINGSTRIKES\)" "BuffPresent\(SWEEPINGSTRIKES\).*Spell\(OVERPOWER usable=1\)" 140 140
Assert-Order "Ret AoE Divine Storm before Consecration" "defaut/Paladin.lua" "Spell\(DIVINESTORM\)" "Spell\(CONSECRATE\)" 98 98
Assert-Order "Ret AoE Exorcism after Consecration and gated" "defaut/Paladin.lua" "Spell\(CONSECRATE\)" "BuffPresent\(THEARTOFWAR\).*Spell\(EXORCISM\)" 98 98
Assert-Order "BM Kill Command before fallback Serpent Sting" "defaut/Chasseur.lua" "Spell\(KILLCOMMAND usable=1\)" "Spell\(SERPENTSTING\)" 88 88
Assert-Order "Hunter trap weaving optional" "defaut/Chasseur.lua" "AddCheckBox\(trapweave" "CheckBoxOn\(trapweave\).*Spell\(EXPLOSIVETRAP"
Assert-Order "Hunter melee fallback before ranged execute" "defaut/Chasseur.lua" "TargetInRange\(RAPTORSTRIKE\)" "Spell\(KILLSHOT\)"
Assert-Order "Hunter Mongoose before Raptor in melee fallback" "defaut/Chasseur.lua" "Spell\(MONGOOSEBITE usable=1\)" "Spell\(RAPTORSTRIKE\)" 0 75
Assert-Order "Hunter Chimera uses own Serpent Sting" "defaut/Chasseur.lua" "TargetDebuffPresent\(SERPENTSTING mine=1\).*Spell\(CHIMERASHOT\)" "Spell\(AIMEDSHOT\)" 79 79
Assert-Order "Frost DK Rime before Obliterate" "defaut/Chevalier.lua" "FREEZINGFOG.*Spell\(HOWLINGBLAST" "Spell\(OBLITERATE\)"
Assert-Order "Frost DK Killing Machine before Obliterate" "defaut/Chevalier.lua" "KILLINGMACHINE.*Spell\(FROSTSTRIKE" "Spell\(OBLITERATE\)"
Assert-Order "Frost DK disease roll before Obliterate" "defaut/Chevalier.lua" "TargetDebuffExpires\(BLOODPLAGUE 4\).*Spell\(PESTILENCE\)" "Spell\(OBLITERATE\)"
Assert-Order "Blood DK Heart Strike before Death Strike" "defaut/Chevalier.lua" "Spell\(HEARTSTRIKE\)" "Spell\(DEATHSTRIKE\)" 83 83
Assert-Order "Unholy DK DnD optional before Scourge Strike" "defaut/Chevalier.lua" "CheckBoxOn\(dnd\).*Spell\(DEATHANDECAY" "Spell\(SCOURGESTRIKE\)"
Assert-Order "Demo Warlock dots before Decimation Soul Fire" "defaut/Demoniste.lua" "Spell\(CORRUPTION" "DECIMATION.*Spell\(SOULFIRE" 86 0
Assert-Order "Destro Warlock Immolate before Conflagrate" "defaut/Demoniste.lua" "Spell\(IMMOLATE" "Spell\(CONFLAGRATE" 96 0
Assert-Order "Feral Rake before Rip" "defaut/Druide.lua" "Spell\(RAKE" "Spell\(RIP priority=4\)"
Assert-Order "Balance Moonfire optional" "defaut/Druide.lua" "AddCheckBox\(moonfire" "CheckBoxOn\(moonfire\).*Spell\(MOONFIRE"
Assert-Order "Balance Eclipse Starfire buff casts Starfire" "defaut/Druide.lua" "BuffPresent\(ECLIPSESTARFIRE\).*Spell\(STARFIRE\)" "BuffPresent\(ECLIPSEWRATH\).*Spell\(WRATH\)"
Assert-Order "Balance Wrath default filler before generic Starfire" "defaut/Druide.lua" "CheckBoxOn\(wrathfiller\).*Spell\(WRATH\)" "^\s*if SpellKnown\(STARFIRE\) Spell\(STARFIRE\)$" 0 90
Assert-Order "Elemental Flame Shock before Lava Burst" "defaut/Chaman.lua" "Spell\(FLAMESHOCK" "Spell\(LAVABURST" 73 0
Assert-Order "Fire Mage Living Bomb before Hot Streak" "defaut/Mage.lua" "Spell\(LIVINGBOMB" "HOTSTREAK.*Spell\(PYROBLAST"
Assert-Order "Arcane Barrage optional" "defaut/Mage.lua" "AddCheckBox\(abarr" "CheckBoxOn\(abarr\).*Spell\(ARCANEBARRAGE"
Assert-Order "Shadow SWP after Shadow Weaving before SWD" "defaut/Pretre.lua" "SHADOWWEAVING.*Spell\(SWP" "Spell\(SWD priority=2\)"
Assert-Order "Shadow Word Death optional" "defaut/Pretre.lua" "AddCheckBox\(swd" "CheckBoxOn\(swd\).*Spell\(SWD priority=2\)"
Assert-Order "Sub Rogue Ambush before Hemorrhage" "defaut/Voleur.lua" "Spell\(AMBUSH" "^\s*Spell\(HEMORRHAGE\)$"
Assert-Order "Assassination Hunger for Blood before Envenom" "defaut/Voleur.lua" "Spell\(HUNGERFORBLOOD\)" "Spell\(ENVENOM\)"

$tankMitigationChecks = @(
    @{ Class = "Warrior"; File = "defaut/Guerrier.lua"; Patterns = @("AddIcon help=mitigation", "SpellKnown(SHIELDSLAM) or SpellKnown(DEVASTATE) or SpellKnown(LASTSTAND)", "TargetTargetIsPlayer", "LifePercent(less 75)", "SHIELDBLOCK", "LifePercent(less 45)", "LASTSTAND", "LifePercent(less 35)", "SHIELDWALL", "LifePercent(less 25)", "ENRAGEDREGENERATION") },
    @{ Class = "Paladin"; File = "defaut/Paladin.lua"; Patterns = @("AddIcon help=mitigation", "SpellKnown(HAMMEROFTHERIGHTEOUS) or TalentPoints(TALENTGUARDEDBYTHELIGHT more 0)", "TargetTargetIsPlayer", "LifePercent(less 90)", "SACREDSHIELD", "LifePercent(less 45)", "DIVINEPROTECTION", "LifePercent(less 20)", "LAYONHANDS") },
    @{ Class = "Death Knight"; File = "defaut/Chevalier.lua"; Patterns = @("AddIcon help=mitigation", "FROSTPRESENCE", "SpellKnown(BONESHIELD) or SpellKnown(UNBREAKABLEARMOR) or SpellKnown(VAMPIRICBLOOD) or SpellKnown(RUNETAP)", "TargetTargetIsPlayer", "BONESHIELD", "LifePercent(less 70)", "ANTIMAGICSHELL", "LifePercent(less 60)", "UNBREAKABLEARMOR", "LifePercent(less 55)", "RUNETAP", "LifePercent(less 45)", "VAMPIRICBLOOD", "LifePercent(less 35)", "ICEBOUNDFORTITUDE", "LifePercent(less 25)", "DEATHPACT") },
    @{ Class = "Druid"; File = "defaut/Druide.lua"; Patterns = @("AddIcon help=mitigation", "SpellKnown(SURVIVALINSTINCTS) or SpellKnown(MANGLEBEAR)", "TargetTargetIsPlayer", "LifePercent(less 75)", "BARKSKIN", "LifePercent(less 45)", "SURVIVALINSTINCTS", "LifePercent(less 30)", "FRENZIEDREGENERATION") }
)
foreach ($check in $tankMitigationChecks) {
    foreach ($pattern in $check.Patterns) {
        Assert-Match -File $check.File -Pattern ([regex]::Escape($pattern)) -Message "MISS $($check.Class) tank mitigation: $pattern"
    }
}

$cleaveLines = Get-Content -LiteralPath "defaut/Guerrier.lua" |
    Select-String -Pattern "Spell\(CLEAVE\)"
foreach ($line in $cleaveLines) {
    if ($line.Line -notmatch "Mana\(more 65\)") {
        throw "Warrior Cleave is not high-rage gated at line $($line.LineNumber)"
    }
}

$warriorLines = Get-Content -LiteralPath "defaut/Guerrier.lua"
$aoeStart = ($warriorLines | Select-String -Pattern "AddIcon help=aoe" | Select-Object -First 1).LineNumber
$offgcdStart = ($warriorLines | Select-String -Pattern "AddIcon help=offgcd" | Select-Object -First 1).LineNumber
$warriorAoeLines = $warriorLines[($aoeStart - 1)..($offgcdStart - 2)]
$singleTargetAoeSpells = @("BLOODTHIRST", "SLAM", "OVERPOWER", "MORTALSTRIKE")
for ($i = 0; $i -lt $warriorAoeLines.Count; $i++) {
    foreach ($spell in $singleTargetAoeSpells) {
        if ($warriorAoeLines[$i] -match "Spell\($spell" -and $warriorAoeLines[$i] -notmatch "BuffPresent\(SWEEPINGSTRIKES\)") {
            throw "Warrior AoE $spell is not Sweeping Strikes-gated at line $($aoeStart + $i)"
        }
    }
    if ($warriorAoeLines[$i] -match "Spell\(REND\)") {
        throw "Warrior AoE should not propose Rend at line $($aoeStart + $i)"
    }
}

$aoeForbiddenSpells = @(
    @{ File = "defaut/Druide.lua"; Help = "aoe"; Spells = @("MANGLECAT", "RAKE", "CLAW", "INSECTSWARM", "MOONFIRE", "STARFIRE", "WRATH") },
    @{ File = "defaut/Chasseur.lua"; Help = "aoe"; Spells = @("EXPLOSIVESHOT", "STEADYSHOT") },
    @{ File = "defaut/Mage.lua"; Help = "aoe"; Spells = @("ARCANEBLAST", "FROSTBOLT", "FIREBALL") },
    @{ File = "defaut/Pretre.lua"; Help = "aoe"; Spells = @("MF", "HOLYFIRE", "SMITE") },
    @{ File = "defaut/Voleur.lua"; Help = "aoe"; Spells = @("MUTILATE", "SINISTERSTRIKE", "HEMORRHAGE") },
    @{ File = "defaut/Demoniste.lua"; Help = "aoe"; Spells = @("INCINERATE", "SHADOWBOLT") },
    @{ File = "defaut/Chaman.lua"; Help = "aoe"; Spells = @("LIGHTNINGBOLT") }
)
foreach ($check in $aoeForbiddenSpells) {
    $blockLines = Get-IconBlockLines -File $check.File -Help $check.Help
    for ($i = 0; $i -lt $blockLines.Count; $i++) {
        foreach ($spell in $check.Spells) {
            if ($blockLines[$i] -match "Spell\($spell") {
                throw "$($check.File) AoE should not propose $spell at block line $($i + 1)"
            }
        }
    }
}

$shadowPainLines = Get-Content -LiteralPath "defaut/Pretre.lua" |
    Select-String -Pattern "Spell\(SWP\)" |
    Where-Object { $_.Line -notmatch "AddIcon size=small" }
foreach ($line in $shadowPainLines) {
    if ($line.Line -notmatch "CheckBoxOff\(swpweaving\)" -and $line.Line -notmatch "SHADOWWEAVING stacks=5") {
        throw "Shadow Word: Pain is not weaving-gated at line $($line.LineNumber)"
    }
}

$mainDeathKnightLines = Get-Content -LiteralPath "defaut/Chevalier.lua" |
    Select-String -Pattern "Spell\(PESTILENCE\)" |
    Where-Object { $_.Line -notmatch "usable=1" }
foreach ($line in $mainDeathKnightLines) {
    if ($line.Line -notmatch "TargetDebuffExpires\(BLOODPLAGUE 4\)" -or $line.Line -notmatch "TargetDebuffExpires\(FROSTFEVER 4\)") {
        throw "Death Knight Glyph of Disease Pestilence is not expiry-gated at line $($line.LineNumber)"
    }
}

$holyWrathLines = Get-Content -LiteralPath "defaut/Paladin.lua" |
    Select-String -Pattern "Spell\(HOLYWRATH\)"
foreach ($line in $holyWrathLines) {
    if ($line.Line -notmatch "CheckBoxOn\(coleredivine\)") {
        throw "Holy Wrath is not option-gated at line $($line.LineNumber)"
    }
}

if (-not $SkipLuaParse) {
    $tmp = Join-Path $env:TEMP "ovale-luaparse-check"
    New-Item -ItemType Directory -Force -Path $tmp | Out-Null
    if (-not (Test-Path (Join-Path $tmp "node_modules\luaparse"))) {
        npm install --silent --prefix $tmp luaparse@0.3.1
    }

    $script = @'
const fs = require('fs');
const path = require('path');
const luaparse = require(process.env.LUAPARSE_PATH);
function walk(dir) {
  return fs.readdirSync(dir, { withFileTypes: true }).flatMap((d) => {
    const p = path.join(dir, d.name);
    return d.isDirectory() ? walk(p) : p;
  });
}
const files = walk('.').filter((f) => f.endsWith('.lua') && !f.includes(path.sep + '.git' + path.sep));
const bad = [];
for (const f of files) {
  const src = fs.readFileSync(f, 'utf8').replace(/^\uFEFF/, '');
  try {
    luaparse.parse(src, { luaVersion: '5.1', locations: false, ranges: false, comments: false });
  } catch (e) {
    bad.push(`${f}: ${e.message || e}`);
  }
}
if (bad.length) {
  console.error(bad.join('\n'));
  process.exit(1);
}
console.log(`OK: parsed ${files.length} Lua files with luaparse after BOM normalization`);
'@

    $env:LUAPARSE_PATH = Join-Path $tmp "node_modules\luaparse"
    $script | node
}

Write-Host "OK: XML, TOC, function allow-list, $($coverageChecks.Count) DPS specs, priority/guide-alignment rules, 4 tank mitigation icons verified"
