class XComTacticalSoundManager_Override extends XComTacticalSoundManager config(SoundtrackRestoration);

var config bool Debug;

var config name GatecrasherMissionOST;
var config name RetaliationMissionOST;
var config name SupplyRaidMissionOST;
var config name FacilityMissionOST;
var config name LandedUFOMissionOST;
var config name RescueMissionOST;
var config name AmbushMissionOST;
var config name ChosenFortressMissionOST;
var config name BlacksiteMissionOST;
var config name ForgeMissionOST;
var config name PsiGateMissionOST;
var config name BroadcastTowerMissionOST;
var config name LostSitrepOST;
var config name AbandonedCityOST;

var config array<string> ExplorationOST;
var config array<string> RandomTacticalCombatOST;
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
		`LOG("XComTacticalSoundManager::SetDefaultSoundtrack() has been called (Soundtrack settings = " $ ProfileSettings.Data.m_iSoundtrackChoice $ ").");
	}
}

function SetCustomSoundtrack(string SelectSet)
{
	if(Debug == true)
	{
		`LOG("XComTacticalSoundManager::SetCustomSoundtrack() has been called (SelectSet argument = " $ SelectSet $ ").");
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

function OverrideMusicState()
{
	local XComGameStateHistory History;
	local XComGameState_Cheats CheatState;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_BattleData BattleData;
	local XComGameState_MissionSite MissionState;
	local PlotDefinition PlotDef;

	// Get needed objects.
	History = `XCOMHISTORY;
	CheatState = class'XComGameState_Cheats'.static.GetVisualizedCheatsObject();
	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	BattleData = XComGameState_BattleData(History.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
	MissionState = XComGameState_MissionSite(`XCOMHISTORY.GetGameStateForObjectID(XComHQ.MissionRef.ObjectID));
	PlotDef = `PARCELMGR.GetPlotDefinition(BattleData.MapData.PlotMapName);

	if(Debug == true)
	{
		`LOG("XComTacticalSoundManager::OverrideMusicState() has been called (Version 4.0).");

		// Debug logging.
		`LOG("XComTacticalSoundManager - TacticalMusicSetOverride = \"" $ CheatState.TacticalMusicSetOverride $ "\"");
		`LOG("XComTacticalSoundManager - MissionCustomMusicSet = \"" $ MissionState.GetMissionSource().CustomMusicSet $ "\"");
		`LOG("XComTacticalSoundManager - PlotMapName = \"" $ BattleData.MapData.PlotMapName $ "\"");
		`LOG("XComTacticalSoundManager - PlotDef = \"" $ PlotDef.strType $ "\"");
	}
	
	// Change music if the current mission does not have a custom one set already.
	if (MissionState.GetMissionSource().CustomMusicSet == '')
	{
		// Gatecrasher and tutorial missions.
		if (MissionState.GetMissionSource().bStart == true)
		{
			if(Debug == true)
			{
				`LOG("XComTacticalSoundManager - Gatecrasher mission detected!");
			}

			if(GatecrasherMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = GatecrasherMissionOST;
			}
		}

		// Retaliation missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.Retaliation")
		{
			if(Debug == true)
			{
				`LOG("XComTacticalSoundManager - Retaliation mission detected!");
			}

			if(RetaliationMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = RetaliationMissionOST;
			}
		}

		// Supply raid missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.SupplyRaid_AdvConvoy")
		{
			if(Debug == true)
			{
				`LOG("XComTacticalSoundManager - Supply raid mission detected!");
			}

			if(SupplyRaidMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = SupplyRaidMissionOST;
			}
		}

		// Facility missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.AlienFacility")
		{
			if(Debug == true)
			{
				`LOG("XComTacticalSoundManager - Facility mission detected!");
			}

			if(FacilityMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = FacilityMissionOST;
			}
			
		}

		// Landed UFO missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.Landed_UFO")
		{
			if(Debug == true)
			{
				`LOG("XComTacticalSoundManager - Landed UFO mission detected!");
			}

			if(LandedUFOMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = LandedUFOMissionOST;
			}
			
		}

		// Rescue missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "StaticMesh'UI_3D.Overwold_Final.RescueOps'")
		{
			if(Debug == true)
			{
				`LOG("XComTacticalSoundManager - Rescue mission detected!");
			}

			if(RescueMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = RescueMissionOST;
			}
		}

		// Ambush missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.EscapeAmbush")
		{
			if(Debug == true)
			{
				`LOG("XComTacticalSoundManager - Ambush mission detected!");
			}

			if(AmbushMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = AmbushMissionOST;
			}
		}

		// Chosen fortress missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "StaticMesh'UI_3D.Overwold_Final.Chosen_Sarcophagus")
		{
			if(Debug == true)
			{
				`LOG("XComTacticalSoundManager - Chosen stronghold mission detected!");
			}

			if(ChosenFortressMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = ChosenFortressMissionOST;
			}
		}

		// Black site mission.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.Blacksite")
		{
			if(Debug == true)
			{
				`LOG("XComTacticalSoundManager - Black site mission detected!");
			}

			if(BlacksiteMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = BlacksiteMissionOST;
			}
		}

		// Forge mission.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.Forge")
		{
			if(Debug == true)
			{
				`LOG("XComTacticalSoundManager - Forge mission detected!");
			}

			if(ForgeMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = ForgeMissionOST;
			}
		}

		// Psi Gate mission.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.Forge")
		{
			if(Debug == true)
			{
				`LOG("XComTacticalSoundManager - Psi gate mission detected!");
			}

			if(PsiGateMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = PsiGateMissionOST;
			}
		}

		// Broadcast tower mission.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.GP_BroadcastOfTruth")
		{
			if(Debug == true)
			{
				`LOG("XComTacticalSoundManager - Broadcast tower mission detected!");
			}

			if(BroadcastTowerMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = BroadcastTowerMissionOST;
			}
		}

		// Lost missions.
		if (BattleData.ActiveSitReps.Find('TheLost') != INDEX_NONE || BattleData.ActiveSitReps.Find('TheHorde') != INDEX_NONE)
		{
			if(Debug == true)
			{
				`LOG("XComTacticalSoundManager - Lost mission detected!");
			}

			if(LostSitrepOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = LostSitrepOST;
			}
		}

		// Abandoned city maps.
		if (PlotDef.strType == "Abandoned")
		{
			if(Debug == true)
			{
				`LOG("XComTacticalSoundManager - Lost mission detected!");
			}

			if(AbandonedCityOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = AbandonedCityOST;
			}
		}

		// Flight Device mission.
		// Template.CustomMusicSet = ''; << Default
		// Template.MissionImage = "img:///UILibrary_StrategyImages.X2StrategyMap.Alert_Flight_Device";

		// Guerrilla missions.
		// Template.CustomMusicSet = ''; << Default
		// Template.OverworldMeshPath = "UI_3D.Overwold_Final.GorillaOps";

		// Council missions.
		// Template.CustomMusicSet = ''; << Default
		// Template.OverworldMeshPath = "UI_3D.Overwold_Final.Council_VIP";

		// Avenger Defense mission.
		// Template.CustomMusicSet = 'Tutorial';
		// Template.CustomLoadingMovieName_Intro = "1080_LoadingScreen5.bk2";

		// Lost Towers DLC mission.
		// Template.CustomMusicSet = 'LostTowerA';
		// Template.CustomMusicSet = 'LostTowerB_GasOn';
		// Template.CustomMusicSet = 'LostTower_BossFight';
		// Template.OverworldMeshPath = "Materials_DLC3.3DUI.ShenLastGift";

		// Alien Nest DLC mission.
		// Template.CustomMusicSet = 'DerelictFacility';
		// Template.OverworldMeshPath = "Materials_DLC2.3DUI.ViperKingDen";

		// Lost and Abandoned mission.
		// Template.CustomMusicSet = 'LostAndAbandoned';
		// Template.CustomLoadingMovieName_Intro = "CIN_XP_LostAbandoned_01_Loading.bk2";
		
		// Resistance Ops missions.
		// Template.CustomMusicSet = ''; << Always in abandoned cities
		// Template.OverworldMeshPath = "UI_3D.Overwold_Final.ResOps";
		// Template.MissionImage = "img://UILibrary_Common.Councilman_small";

		// Chosen Avenger Assault missions.
		// Template.CustomMusicSet = 'Tutorial';
		// Template.OverworldMeshPath = "StaticMesh'UI_3D.Overwold_Final.Retribution'";

		// Final mission.
		// Template.CustomMusicSet = 'AlienFortress';
		// Template.OverworldMeshPath = "UI_3D.Overwold_Final.AlienFortress";

		// These can only use base XCOM2 tracks.
		if(MissionState.GetMissionSource().CustomMusicSet != '')
		{
			`SOUNDMGR.SetState('SoundtrackGame', 'XCom2');
		}
	}
}

function EvaluateTacticalMusicState()
{
	if(Debug == true)
	{
		`LOG("XComTacticalSoundManager::EvaluateTacticalMusicState() has been called.");
	}

	// Overide music state when combat starts.
	OverrideMusicState();

	// Call overwritten method.
	super.EvaluateTacticalMusicState();
}

function StartAllAmbience(bool bStartMissionSoundtrack=true)
{
	local XComGameState_BattleData BattleData;
	local XComGameState_MissionSite MissionState;
	local XComGameState_HeadquartersXCom XComHQ;

	local string sBiome;
	local string sEnvironmentLightingMapName;
	local PlotDefinition PlotDef;
	local name nBiomeSwitch;
	local name nClimateSwitch;
	local name nLightingSwitch;
	local name nPlotNameSwitch;

	local int RandomIndex;
	local string SelectSetString;

	if(Debug == true)
	{
		`LOG("XComTacticalSoundManager::StartAllAmbience() has been called.");

		// Get the relevant environment ambiance settings.
		BattleData = XComGameState_BattleData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_BattleData', true));
		sBiome = BattleData.MapData.Biome;
		sEnvironmentLightingMapName = BattleData.MapData.EnvironmentLightingMapName;
		PlotDef = `PARCELMGR.GetPlotDefinition(BattleData.MapData.PlotMapName);

		// Convert the ambiance settings to their corresponding AkAudio Switch names.
		nBiomeSwitch = Name(PlotDef.AudioPlotTypeOverride != "" ? PlotDef.AudioPlotTypeOverride : PlotDef.strType);
		nClimateSwitch = Name(sBiome);
		nLightingSwitch = GetSwitchNameFromEnvLightingString(sEnvironmentLightingMapName);

		// Plot-specific non-ambiance overrides
		nPlotNameSwitch = name(PlotDef.MapName);
		if(AudioPlotNames.Find(nPlotNameSwitch) == INDEX_NONE)
		{
			nPlotNameSwitch = 'None';
		}

		// Print to log.
		`LOG("XComTacticalSoundManager - BiomeSwitch = \"" $ nBiomeSwitch $ "\"");
		`LOG("XComTacticalSoundManager - ClimateSwitch = \"" $ nClimateSwitch $ "\"");
		`LOG("XComTacticalSoundManager - LightingSwitch = \"" $ nLightingSwitch $ "\"");
		`LOG("XComTacticalSoundManager - PlotNameSwitch = \"" $ nPlotNameSwitch $ "\"");
	}

	// Set random ambient music at the start of a mission.
	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	MissionState = XComGameState_MissionSite(`XCOMHISTORY.GetGameStateForObjectID(XComHQ.MissionRef.ObjectID));

	if (MissionState.GetMissionSource().CustomMusicSet == '')
	{
		RandomIndex = `SYNC_RAND(ExplorationOST.Length);
		SelectSetString = ExplorationOST[RandomIndex];

		if(InStr(SelectSetString, "_TLE") != -1)
		{
			`SOUNDMGR.SetState('SoundtrackGame', 'XComUFO');
			SelectSetString = Repl(SelectSetString, "_TLE", "");
		}
		else if(InStr(SelectSetString, "_XCOM1") != -1)
		{
			`SOUNDMGR.SetState('SoundtrackGame', 'XCom1');
			SelectSetString = Repl(SelectSetString, "_XCOM1", "");
		}
		else if(InStr(SelectSetString, "_XCOM2") != -1)
		{
			`SOUNDMGR.SetState('SoundtrackGame', 'XCom2');
			SelectSetString = Repl(SelectSetString, "_XCOM2", "");
		}
		else
		{
			SetDefaultSoundtrack();
		}
	}

	// Overide music state when ambient starts.
	OverrideMusicState();

	// Call overwritten method.
	super.StartAllAmbience(bStartMissionSoundtrack);
}

function StopAllAmbience()
{
	if(Debug == true)
	{
		`LOG("XComTacticalSoundManager::StopAllAmbience() has been called.");
	}

	super.StopAllAmbience();
}

function SelectRandomTacticalMusicSet()
{
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_BattleData BattleData;
	local XComGameState_MissionSite MissionState;
	local XComGameState_Cheats CheatState;
	local int RandomIndex;
	local name SelectSet;
	local string SelectSetString;

	if(Debug == true)
	{
		`LOG("XComTacticalSoundManager::SelectRandomTacticalMusicSet() has been called.");
	}

	// first check if a specific music set has been selected from kismet
	CheatState = class'XComGameState_Cheats'.static.GetVisualizedCheatsObject();
	if(CheatState != none && CheatState.TacticalMusicSetOverride != '')
	{
		SetSwitch('TacticalCombatMusicSet', CheatState.TacticalMusicSetOverride);
	}
	else
	{
		// check if this mission requests specific music, otherwise play a random set
		XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		MissionState = XComGameState_MissionSite(`XCOMHISTORY.GetGameStateForObjectID(XComHQ.MissionRef.ObjectID));

		if(MissionState == none || MissionState.GetMissionSource().CustomMusicSet == '')
		{
			if(RandomTacticalCombatOST.Length > 0)
			{
				if(Debug == true)
				{
					`LOG("XComTacticalSoundManager - RandomTacticalCombatOST.Length = " $ RandomTacticalCombatOST.Length);
				}

				RandomIndex = `SYNC_RAND(RandomTacticalCombatOST.Length);
				SelectSet = name(RandomTacticalCombatOST[RandomIndex]);

				if(`REPLAY.bInTutorial)
				{
					`SOUNDMGR.SetState('SoundtrackGame', 'XCom2');
					SetSwitch('TacticalCombatMusicSet', 'Tutorial');

					if(Debug == true)
					{
						`LOG("XComTacticalSoundManager - TacticalCombatMusicSet = \"" $ 'Tutorial' $ "\"");
					}
				}
				else
				{
					SelectSetString = string(SelectSet);
	
					if(InStr(SelectSetString, "_TLE") != -1)
					{
						`SOUNDMGR.SetState('SoundtrackGame', 'XComUFO');
						SelectSetString = Repl(SelectSetString, "_TLE", "");
					}
					else if(InStr(SelectSetString, "_XCOM1") != -1)
					{
						`SOUNDMGR.SetState('SoundtrackGame', 'XCom1');
						SelectSetString = Repl(SelectSetString, "_XCOM1", "");
					}
					else if(InStr(SelectSetString, "_XCOM2") != -1)
					{
						`SOUNDMGR.SetState('SoundtrackGame', 'XCom2');
						SelectSetString = Repl(SelectSetString, "_XCOM2", "");
					}
					else
					{
						SetDefaultSoundtrack();
					}
					
					SetSwitch('TacticalCombatMusicSet', name(SelectSetString));

					if(Debug == true)
					{
						`LOG("XComTacticalSoundManager - TacticalCombatMusicSet = \"" $ SelectSet $ "\"");
					}
				}
			}
		}
		else
		{
			`SOUNDMGR.SetState('SoundtrackGame', 'XCom2');
			SetSwitch('TacticalCombatMusicSet', MissionState.GetMissionSource().CustomMusicSet);

			if(Debug == true)
			{
				`LOG("XComTacticalSoundManager - TacticalCombatMusicSet = \"" $ MissionState.GetMissionSource().CustomMusicSet $ "\"");
			}
		}
	}

	// Handle two random tracks for Lost and Abandoned OST.
	BattleData = XComGameState_BattleData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_BattleData', true));

	if(SelectSet == 'LostAndAbandoned' || MissionState.GetMissionSource().CustomMusicSet == 'LostAndAbandoned')
	{
		if (BattleData.MapData.PlotMapName != "Plot_ABN_LostAndAbandonedA" && 
			BattleData.MapData.PlotMapName != "Plot_ABN_LostAndAbandonedB" &&
			BattleData.MapData.PlotMapName != "Plot_ABN_LostAndAbandonedC")
		{
			if(`SYNC_RAND(2) == 0)
			{
				SetState('PlotName', 'Plot_ABN_LostAndAbandonedA');
			}
			else
			{
				SetState('PlotName', 'None');
			}

			if(Debug == true)
			{
				`LOG("XComTacticalSoundManager - PlotName for Lost And Abandononed override.");
			}
		}
	}
	else
	{
		SetState('PlotName', 'None');
	}
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
		`LOG("XComTacticalSoundManager::PlayAfterActionMusic() has been called.");
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
