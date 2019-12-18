Scriptname _p7NHR_Quest extends Quest

Actor Property PlayerRef Auto

Float controlHealth
Float controlBaseHealth
Float sleepStart

Event OnInit()
	RegisterForSleep()
	; requires SKSE >= 1.06.00
	RegisterForMenu("LevelUp Menu")
EndEvent

Event OnSleepStart(Float afSleepStartTime, Float afDesiredSleepEndTime)
	; NOTE: notifications here are never shown
	Log("OnSleepStart()")
	Log("PlayerRef.GetAV(\"Health\")=" + PlayerRef.GetAV("Health"))
	Log("PlayerRef.GetAV(\"HealRate\")=" + PlayerRef.GetAV("HealRate"))
	Log("PlayerRef.GetAV(\"HealRateMult\")=" + PlayerRef.GetAV("HealRateMult"))
	sleepStart = afSleepStartTime
	controlHealth = PlayerRef.GetAV("Health")
EndEvent

Event OnSleepStop(Bool abInterrupted)
	Log("OnSleepStop(" + abInterrupted + ")")
	Int hours = ((Utility.GetCurrentGameTime() - sleepStart) * 24) as Int
	Log("hours = " + hours)
	Log("PlayerRef.GetAV(\"Health\") == " + PlayerRef.GetAV("Health"))
	Log("PlayerRef.GetAV(\"HealRate\") == " + PlayerRef.GetAV("HealRate"))
	Log("PlayerRef.GetAV(\"HealRateMult\") == " + PlayerRef.GetAV("HealRateMult"))
	; NOTE: it is necessary to divide the final calculation by 10
	Float newHealth = controlHealth + 60 * 60 * hours * \
		PlayerRef.GetAV("HealRate") * PlayerRef.GetAV("HealRateMult") / 100 / 10
	Float damage = PlayerRef.GetAV("Health") - newHealth
	If damage > 0
		Log("PlayerRef.DamageAV(\"Health\", " + damage + ")")
		PlayerRef.DamageAV("Health", damage)
		Log("PlayerRef.GetAV(\"Health\") == " + PlayerRef.GetAV("Health"))
	EndIf
EndEvent

Event OnMenuOpen(String MenuName)
	If MenuName == "LevelUp Menu"
		controlHealth = PlayerRef.GetAV("Health")
		controlBaseHealth = PlayerRef.GetBaseAV("Health")
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
		If damage > 0
			PlayerRef.DamageAV("Health", damage)
		EndIf
	EndIf
EndEvent

Function Log(String text)
	Debug.Trace("[No Health Reset] _p7NHR_Quest: " + text)
EndFunction
