Scriptname _p7NHR_Quest extends Quest

Actor Property PlayerRef Auto

Float controlHealth
Float controlBaseHealth
Float sleepStart

Event OnInit()
	RefreshRegistrations()
EndEvent

Event OnSleepStart(Float afSleepStartTime, Float afDesiredSleepEndTime)
	sleepStart = afSleepStartTime
	controlHealth = PlayerRef.GetAV("Health")

	Log(\
		"In _p7NHR_Quest.OnSleepStart:" \
		+ "\n    controlHealth == " + controlHealth)
EndEvent

Event OnSleepStop(Bool abInterrupted)
	Int hours = ((Utility.GetCurrentGameTime() - sleepStart) * 24) as Int

	; NOTE: it is necessary to divide the final calculation by 10
	Float newHealth = controlHealth + 60 * 60 * hours * \
		PlayerRef.GetAV("HealRate") * PlayerRef.GetAV("HealRateMult") / 100 / 10
	Float damage = PlayerRef.GetAV("Health") - newHealth

	Log(\
		"In _p7NHR_Quest.OnSleepStop:" \
		+ "\n    hours == " + hours \
		+ "\n    damage == " + damage)

	If damage > 0
		PlayerRef.DamageAV("Health", damage)
	EndIf
EndEvent

Event OnMenuOpen(String MenuName)
	If MenuName == "LevelUp Menu"
		controlHealth = PlayerRef.GetAV("Health")
		controlBaseHealth = PlayerRef.GetBaseAV("Health")

		Log(\
			"In _p7NHR_Quest.OnMenuOpen:" \
			+ "\n    controlHealth == " + controlHealth \
			+ "\n    controlBaseHealth == " + controlBaseHealth)
	EndIf
EndEvent

Event OnMenuClose(String MenuName)
	If MenuName == "LevelUp Menu"
		Float baseHealthIncrement = \
			PlayerRef.GetBaseAV("Health") - controlBaseHealth
		Float damage = PlayerRef.GetAV("Health") - controlHealth

		If baseHealthIncrement > 0
			; health was chosen as stat to increment, let's consider it so that
			; such increment is not undone
			; NOTE: the same amount should be also found with
			; Game.GetGameSettingInt("iAVDhmsLevelup")
			; but we don't need it here, because by comparing the actual base
			; values, we can exclude the case another stat was chosen
			damage -= baseHealthIncrement
		EndIf

		Log(\
			"In _p7NHR_Quest.OnMenuClose:" \
			+ "\n    baseHealthIncrement == " + baseHealthIncrement \
			+ "\n    damage == " + damage)

		If damage > 0
			PlayerRef.DamageAV("Health", damage)
		EndIf
	EndIf
EndEvent

Function RefreshRegistrations()
	UnregisterForSleep()
	UnregisterForAllMenus()

	RegisterForSleep()
	; requires SKSE >= 1.6.0
	RegisterForMenu("LevelUp Menu")
EndFunction

Function Log(String text)
	Debug.Trace("[No Health Reset] " + text)
EndFunction
