Scriptname _p7NHR_PlayerAlias extends ReferenceAlias

_p7NHR_Quest Property PlayerQuest Auto

Event OnInit()
	; if the alias is empty, the quest was started before the alias existed:
	; this means the mod was updated since last game: let's fill the alias
	; and refresh registrations manually
	If !Self.GetReference()
		Self.ForceRefTo(Game.GetPlayer())
		PlayerQuest.RefreshRegistrations()
	EndIf
EndEvent

Event OnPlayerLoadGame()
	PlayerQuest.RefreshRegistrations()
EndEvent
