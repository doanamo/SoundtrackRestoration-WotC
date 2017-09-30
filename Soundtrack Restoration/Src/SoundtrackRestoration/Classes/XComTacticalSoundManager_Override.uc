class XComTacticalSoundManager_Override extends XComTacticalSoundManager config(SoundtrackRestoration);

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

var config array<string> RandomTacticalCombatOST;

function EvaluateTacticalMusicState()
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

	// Debug logging.
	`LOG("XComTacticalSoundManager - TacticalMusicSetOverride = \"" $ CheatState.TacticalMusicSetOverride $ "\"");
	`LOG("XComTacticalSoundManager - MissionCustomMusicSet = \"" $ MissionState.GetMissionSource().CustomMusicSet $ "\"");
	`LOG("XComTacticalSoundManager - PlotMapName = \"" $ BattleData.MapData.PlotMapName $ "\"");
	`LOG("XComTacticalSoundManager - PlotDef = \"" $ PlotDef.strType $ "\"");

	// Set custom music sets.
	if (MissionState.GetMissionSource().CustomMusicSet == '')
	{
		// Gatecrasher and tutorial missions.
		if (MissionState.GetMissionSource().bStart == true)
		{
			`LOG("XComTacticalSoundManager - Gatecrasher mission detected!");

			if(GatecrasherMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = GatecrasherMissionOST;
			}
		}

		// Retaliation missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.Retaliation")
		{
			`LOG("XComTacticalSoundManager - Retaliation mission detected!");

			if(RetaliationMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = RetaliationMissionOST;
			}
		}

		// Supply raid missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.SupplyRaid_AdvConvoy")
		{
			`LOG("XComTacticalSoundManager - Supply raid mission detected!");

			if(SupplyRaidMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = SupplyRaidMissionOST;
			}
		}

		// Facility missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.AlienFacility")
		{
			`LOG("XComTacticalSoundManager - Facility mission detected!");

			if(FacilityMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = FacilityMissionOST;
			}
			
		}

		// Landed UFO missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.Landed_UFO")
		{
			`LOG("XComTacticalSoundManager - Landed UFO mission detected!");

			if(LandedUFOMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = LandedUFOMissionOST;
			}
			
		}

		// Rescue missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "StaticMesh'UI_3D.Overwold_Final.RescueOps'")
		{
			`LOG("XComTacticalSoundManager - Rescue mission detected!");

			if(RescueMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = RescueMissionOST;
			}
		}

		// Ambush missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.EscapeAmbush")
		{
			`LOG("XComTacticalSoundManager - Ambush mission detected!");

			if(AmbushMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = AmbushMissionOST;
			}
		}

		// Chosen Fortress missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "StaticMesh'UI_3D.Overwold_Final.Chosen_Sarcophagus")
		{
			`LOG("XComTacticalSoundManager - Chosen stronghold mission detected!");

			if(ChosenFortressMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = ChosenFortressMissionOST;
			}
		}

		// Blacksite mission.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.Blacksite")
		{
			`LOG("XComTacticalSoundManager - Blacksite mission detected!");

			if(BlacksiteMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = BlacksiteMissionOST;
			}
		}

		// Forge mission.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.Forge")
		{
			`LOG("XComTacticalSoundManager - Forge mission detected!");

			if(ForgeMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = ForgeMissionOST;
			}
		}

		// Psi Gate mission.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.Forge")
		{
			`LOG("XComTacticalSoundManager - Psi gate mission detected!");

			if(PsiGateMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = PsiGateMissionOST;
			}
		}

		// Broadcast Tower mission.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.GP_BroadcastOfTruth")
		{
			`LOG("XComTacticalSoundManager - Broadcast tower mission detected!");

			if(BroadcastTowerMissionOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = BroadcastTowerMissionOST;
			}
		}

		// Lost sitreps.
		if (BattleData.ActiveSitReps.Find('TheLost') != INDEX_NONE || BattleData.ActiveSitReps.Find('TheHorde') != INDEX_NONE)
		{
			`LOG("XComTacticalSoundManager - Lost mission detected!");

			if(LostSitrepOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = LostSitrepOST;
			}
		}

		// Abandoned city maps.
		if (PlotDef.strType == "Abandoned")
		{
			`LOG("XComTacticalSoundManager - Lost mission detected!");

			if(AbandonedCityOST != '')
			{
				MissionState.GetMissionSource().CustomMusicSet = AbandonedCityOST;
			}
		}

		// Flight Device mission.
		// Template.CustomMusicSet = ''; << Default
		// Template.MissionImage = "img:///UILibrary_StrategyImages.X2StrategyMap.Alert_Flight_Device";

		// Guerilla missions.
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
	}

	// Call overritten method.
	super.EvaluateTacticalMusicState();
	`LOG("XComTacticalSoundManager::EvaluateTacticalMusicState() has been called.");
}

function SelectRandomTacticalMusicSet()
{
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_MissionSite MissionState;
	local XComGameState_Cheats CheatState;
	local int RandomIndex;
	local name SelectSet;

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
				`LOG("XComTacticalSoundManager - RandomTacticalCombatOST.Length = " $ RandomTacticalCombatOST.Length);

				RandomIndex = `SYNC_RAND(RandomTacticalCombatOST.Length);
				SelectSet = name(RandomTacticalCombatOST[RandomIndex]);

				if(`REPLAY.bInTutorial)
				{
					SetSwitch('TacticalCombatMusicSet', 'Tutorial');
					`LOG("XComTacticalSoundManager - TacticalCombatMusicSet = \"" $ 'Tutorial' $ "\"");
				}
				else
				{
					SetSwitch('TacticalCombatMusicSet', SelectSet);
					`LOG("XComTacticalSoundManager - TacticalCombatMusicSet = \"" $ SelectSet $ "\"");
				}
			}
		}
		else
		{		
			SetSwitch('TacticalCombatMusicSet', MissionState.GetMissionSource().CustomMusicSet);
			`LOG("XComTacticalSoundManager - TacticalCombatMusicSet = \"" $ MissionState.GetMissionSource().CustomMusicSet $ "\"");
		}
	}

	`LOG("XComTacticalSoundManager::SelectRandomTacticalMusicSet() has been called.");
}
