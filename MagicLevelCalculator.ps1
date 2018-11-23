# Variables
$All = @()
$AdvExerDummy			= $True
$Level 					= 1						# Magic level to start at
[Decimal]$Mana 			= 1600					# Mana required for magic level 1
$UltManaPotsPerWand 	= 610					# (1 Exercise Wand == 600 Ultimate mana pots)
$UltManaRegen 			= 500					# Average mana an Ultimate Mana pot regens
$Bonus					= ((610 * 500) * .1)	# If you are using an advanded exercise dummy
$WandCost 				= 262500				# Gold coins per wand
$TibiaCoin 				= 12500					# Price per 25 TCs
$TibiaCoinUSD			= 9.50 					# USD per 250 TCs

Do
{
	If ( $AdvExerDummy ) { $Wands = [Math]::Round(($Mana / (( $UltManaPotsPerWand  * $UltManaRegen ) + $Bonus)), 4) }
	Else { $Wands = [Math]::Round(($Mana / ( $UltManaPotsPerWand  * $UltManaRegen )), 4) }
	$Gold = [Math]::Ceiling($Wands) * $WandCost
	$CalcMana = [Math]::Round($Mana)
	$TotalTibiaCoin = [Math]::Round($Gold / $TibiaCoin, 4)
	$Hours = $([Math]::Round((($Wands * 16.5) / 60), 2)).ToString()
	$Days = $([Math]::Round((($Wands * 16.5) / 60 / 24), 2)).ToString()

	# Stores the calculations in a PSCustomObject
	$ThisTime = [PSCustomObject]@{
		'Level'		= $Level
		'Mana'		= [string]::Format('{0:N0}',$CalcMana)
		'Wands'		= $Wands
		'Hours'		= "$Hours hours"
		'Days'		= "$Days days"
		'Gold'		= [string]::Format('{0:N0}',$Gold)
		'TibiaCoin'	= $TotalTibiaCoin
		'USD'		= [Math]::Round((($TotalTibiaCoin / 250) * 9.5), 2)
	}
	$All += $ThisTime

	$Level++
	[Decimal]$Mana = [Decimal]($Mana * 1.1)
	Write-Host "Level: $($ThisTime.Level)`tMana: $($ThisTime.Mana)`tWands: $($ThisTime.Wands)`tDays: $($ThisTime.Days)`tHours: $($ThisTime.Hours)`tGold: $($ThisTime.Gold)`tTC: $($ThisTime.TibiaCoin)`tUSD: $($ThisTime.USD)"
}
Until( $Level -eq 151 )