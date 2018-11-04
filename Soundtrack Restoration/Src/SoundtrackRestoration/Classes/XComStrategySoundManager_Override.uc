class XComStrategySoundManager_Override extends XComStrategySoundManager config(SoundtrackRestoration);

var config bool Debug;

var config array<string> GeoscapeOST;
var config array<string> Chapter01OST;
var config array<string> Chapter02OST;
var config array<string> Chapter03OST;
var config array<string> SquadSelectOST;
var config array<string> MissionSuccessOST;
var config array<string> MissionFlawlessOST;
var config array<string> MissionFailureOST;

function SetDefaultSoundtrack()
{
	local XComOnlineProfileSettings ProfileSettings;
	ProfileSettings = `XPROFILESETTINGS;
	
	switch (ProfileSettings.Data.m_iSoundtrackChoice)
	{
		case 0: `SOUNDMGR.SetState('SoundtrackGame', 'XComUFO'); break;
		case 1: `SOUNDMGR.SetState('SoundtrackGame', 'XCom1'); break;
		case 2: `SOUNDMGR.SetState('SoundtrackGame', 'XCom2'); break;
	}

	if(Debug == true)
	{
		`LOG("XComStrategySoundManager - SetDefaultSoundtrack() has been called (Soundtrack settings = " $ ProfileSettings.Data.m_iSoundtrackChoice $ ").");
	}
}

function SetCustomSoundtrack(string SelectSet)
{
	if(Debug == true)
	{
		`LOG("XComStrategySoundManager - SetCustomSoundtrack() has been called (SelectSet argument = " $ SelectSet $ ").");
	}

	if(InStr(SelectSet, "_TLE") != -1)
	{
		`SOUNDMGR.SetState('SoundtrackGame', 'XComUFO');
	}
	else if(InStr(SelectSet, "_XCOM1") != -1)
	{
		`SOUNDMGR.SetState('SoundtrackGame', 'XCom1');
	}
	else if(InStr(SelectSet, "_XCOM2") != -1)
	{
		`SOUNDMGR.SetState('SoundtrackGame', 'XCom2');
	}
	else
	{
		SetDefaultSoundtrack();
	}
}

function PlayBaseViewMusic()
{
	local int RandomIndex;

	local XComGameState_HeadquartersXCom XComHQ;
	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

	if(Debug == true)
	{
		`LOG("XComStrategySoundManager - PlayBaseViewMusic() has been called.");
	}

	SetSwitch('StrategyScreen', 'Avenger');

	if (XComHQ.IsObjectiveCompleted('T1_M6_KillAvatar'))
	{
		if(Chapter03OST.Length > 0)
		{
			RandomIndex = `SYNC_RAND(Chapter03OST.Length);
			SetCustomSoundtrack(Chapter03OST[RandomIndex]);
		}
		else
		{
			SetDefaultSoundtrack();
		}
		
		SetSwitch('HQChapter', 'Chapter03');
	}
	else if (XComHQ.IsTechResearched('MagnetizedWeapons') && XComHQ.IsTechResearched('PlatedArmor'))
	{
		if(Chapter02OST.Length > 0)
		{
			RandomIndex = `SYNC_RAND(Chapter02OST.Length);
			SetCustomSoundtrack(Chapter02OST[RandomIndex]);
		}
		else
		{
			SetDefaultSoundtrack();
		}
	
		SetSwitch('HQChapter', 'Chapter02');
	}
	else
	{
		if(Chapter01OST.Length > 0)
		{
			RandomIndex = `SYNC_RAND(Chapter01OST.Length);
			SetCustomSoundtrack(Chapter01OST[RandomIndex]);
		}
		else
		{
			SetDefaultSoundtrack();
		}
	
		SetSwitch('HQChapter', 'Chapter01');
	}
}

function PlayGeoscapeMusic()
{
	local int RandomIndex;

	if(Debug == true)
	{
		`LOG("XComStrategySoundManager - PlayGeoscapeMusic() has been called.");
	}

	if(GeoscapeOST.Length > 0)
	{
		RandomIndex = `SYNC_RAND(GeoscapeOST.Length);
		SetCustomSoundtrack(GeoscapeOST[RandomIndex]);
	}
	else
	{
		SetDefaultSoundtrack();
	}

	SetSwitch('StrategyScreen', 'Geoscape');
}

function PlaySquadSelectMusic()
{
	local int RandomIndex;

	if(Debug == true)
	{
		`LOG("XComStrategySoundManager - PlaySquadSelectMusic() has been called.");
	}

	if(SquadSelectOST.Length > 0)
	{
		RandomIndex = `SYNC_RAND(SquadSelectOST.Length);
		SetCustomSoundtrack(SquadSelectOST[RandomIndex]);
	}
	else
	{
		SetDefaultSoundtrack();
	}

	SetSwitch('StrategyScreen', 'ChooseSquad');
}

function PlayCreditsMusic()
{
	local int RandomIndex;

	if(Debug == true)
	{
		`LOG("XComStrategySoundManager - PlayCreditsMusic() has been called.");
	}

	if(MissionFlawlessOST.Length > 0)
	{
		RandomIndex = `SYNC_RAND(MissionFlawlessOST.Length);
		SetCustomSoundtrack(MissionFlawlessOST[RandomIndex]);
	}
	else
	{
		SetDefaultSoundtrack();
	}

	SetSwitch('StrategyScreen', 'PostMissionFlow_FlawlessVictory');
}

function PlayLossMusic()
{
	local int RandomIndex;

	if(Debug == true)
	{
		`LOG("XComStrategySoundManager - PlayLossMusic() has been called.");
	}

	if(MissionFailureOST.Length > 0)
	{
		RandomIndex = `SYNC_RAND(MissionFailureOST.Length);
		SetCustomSoundtrack(MissionFailureOST[RandomIndex]);
	}
	else
	{
		SetDefaultSoundtrack();
	}

	SetSwitch('StrategyScreen', 'PostMissionFlow_Fail');
}

function PlayAfterActionMusic()
{
	local int RandomIndex;

	local XComGameStateHistory History;
	local XComGameState_BattleData BattleData;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_Unit UnitState;
	local bool bCasualties, bVictory;
	local int idx;

	if(Debug == true)
	{
		`LOG("XComStrategySoundManager - PlayAfterActionMusic() has been called.");
	}

	History = `XCOMHISTORY;
	BattleData = XComGameState_BattleData(History.GetSingleGameStateObjectForClass(class'XComGameState_BattleData', true));
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	bCasualties = false;

	if(BattleData != none)
	{
		bVictory = BattleData.bLocalPlayerWon;
	}
	else
	{
		bVictory = XComHQ.bSimCombatVictory;
	}

	if(!bVictory)
	{
		if(MissionFailureOST.Length > 0)
		{
			RandomIndex = `SYNC_RAND(MissionFailureOST.Length);
			SetCustomSoundtrack(MissionFailureOST[RandomIndex]);
		}
		else
		{
			SetDefaultSoundtrack();
		}
	
		SetSwitch('StrategyScreen', 'PostMissionFlow_Fail');
		//PlaySoundEvent("PlayPostMissionFlowMusic_Failure");
	}
	else
	{
		for(idx = 0; idx < XComHQ.Squad.Length; idx++)
		{
			UnitState = XComGameState_Unit(History.GetGameStateForObjectID(XComHQ.Squad[idx].ObjectID));

			if(UnitState != none && UnitState.IsDead())
			{
				bCasualties = true;
				break;
			}
		}

		if(bCasualties)
		{
			if(MissionSuccessOST.Length > 0)
			{
				RandomIndex = `SYNC_RAND(MissionSuccessOST.Length);
				SetCustomSoundtrack(MissionSuccessOST[RandomIndex]);
			}
			else
			{
				SetDefaultSoundtrack();
			}
		
			SetSwitch('StrategyScreen', 'PostMissionFlow_Pass');
			//PlaySoundEvent("PlayPostMissionFlowMusic_VictoryWithCasualties");
		}
		else
		{
			if(MissionFlawlessOST.Length > 0)
			{
				RandomIndex = `SYNC_RAND(MissionFlawlessOST.Length);
				SetCustomSoundtrack(MissionFlawlessOST[RandomIndex]);
			}
			else
			{
				SetDefaultSoundtrack();
			}
		
			SetSwitch('StrategyScreen', 'PostMissionFlow_FlawlessVictory');
			//PlaySoundEvent("PlayPostMissionFlowMusic_FlawlessVictory");
		}
	}
}
