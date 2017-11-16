Scriptname P7FixHealthQuestScript Extends Quest

Actor Property PlayerRef Auto

Float health
Float sleepStart

Event OnInit()
	Debug.Notification("OnInit()")
	RegisterForSleep()
EndEvent

Event OnSleepStart(Float afSleepStartTime, Float afDesiredSleepEndTime)
	; NOTE: notifications here are never shown
	Log("OnSleepStart()")
	Log("PlayerRef.GetAV('Health')=" + PlayerRef.GetAV("Health"))
	Log("PlayerRef.GetAV('HealRate')=" + PlayerRef.GetAV("HealRate"))
	Log("PlayerRef.GetAV('HealRateMult')=" + PlayerRef.GetAV("HealRateMult"))
	sleepStart = afSleepStartTime
	health = PlayerRef.GetAV("Health")
EndEvent

Event OnSleepStop(Bool abInterrupted)
	Log("OnSleepStop(" + abInterrupted + ")")
	Int hours = ((Utility.GetCurrentGameTime() - sleepStart) * 24) as Int
	Log("hours=" + hours)
	Log("PlayerRef.GetAV('Health')=" + PlayerRef.GetAV("Health"))
	Log("PlayerRef.GetAV('HealRate')=" + PlayerRef.GetAV("HealRate"))
	Log("PlayerRef.GetAV('HealRateMult')=" + PlayerRef.GetAV("HealRateMult"))
	; NOTE: it is necessary to divide the final calculation by 10
	Float newHealth = health + 60 * 60 * hours * PlayerRef.GetAV("HealRate") * \
		PlayerRef.GetAV("HealRateMult") / 100 / 10
	Float damage = PlayerRef.GetAV("Health") - newHealth
	If damage > 0
		PlayerRef.DamageAV("Health", damage)
		Log("PlayerRef.GetAV('Health')=" + PlayerRef.GetAV("Health"))
	EndIf
EndEvent

Function Log(String text)
	Debug.Trace("[P7FixHealthQuestScript] " + text)
EndFunction
