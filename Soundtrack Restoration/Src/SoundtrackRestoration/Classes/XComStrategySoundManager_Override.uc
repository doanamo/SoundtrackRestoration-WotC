class XComStrategySoundManager_Override extends XComStrategySoundManager config(GameData);

function PlayBaseViewMusic()
{
	local XComGameState_HeadquartersXCom XComHQ;
	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

	SetSwitch('StrategyScreen', 'Avenger');

	if (XComHQ.IsObjectiveCompleted('T3_M2_BuildShadowChamber'))
	{
		SetSwitch('HQChapter', 'Chapter03');
	}
	else if (XComHQ.IsTechResearched('MagnetizedWeapons') && XComHQ.IsTechResearched('PlatedArmor'))
	{
		SetSwitch('HQChapter', 'Chapter02');
	}
	else
	{
		SetSwitch('HQChapter', 'Chapter01');
	}
}
