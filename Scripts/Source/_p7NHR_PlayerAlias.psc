Scriptname _p7NHR_PlayerAlias extends ReferenceAlias

_p7NHR_Quest Property PlayerQuest Auto

Event OnPlayerLoadGame()
	PlayerQuest.RefreshRegistrations()
EndEvent
