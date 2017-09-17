class XComTacticalSoundManager_Override extends XComTacticalSoundManager config(GameData);

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
			MissionState.GetMissionSource().CustomMusicSet = 'Tutorial';
		}

		// Retaliation missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.Retaliation")
		{
			MissionState.GetMissionSource().CustomMusicSet = 'Tutorial';
		}

		// Supply raid missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.SupplyRaid_AdvConvoy")
		{
			MissionState.GetMissionSource().CustomMusicSet = 'LostTowerA';
		}

		// Facility missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.AlienFacility")
		{
			MissionState.GetMissionSource().CustomMusicSet = 'LostTowerB_GasOn';
		}

		// Landed UFO missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.Landed_UFO")
		{
			MissionState.GetMissionSource().CustomMusicSet = 'DerelictFacility';
		}

		// Rescue Soldier missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "StaticMesh'UI_3D.Overwold_Final.RescueOps'")
		{
			MissionState.GetMissionSource().CustomMusicSet = 'LostTower_BossFight';
		}

		// Escape Ambush missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.EscapeAmbush")
		{
			MissionState.GetMissionSource().CustomMusicSet = 'LostTower_BossFight';
		}

		// Lost sitreps and abandoned city maps.
		if (BattleData.ActiveSitReps.Find('TheLost') != INDEX_NONE || BattleData.ActiveSitReps.Find('TheHorde') != INDEX_NONE || PlotDef.strType == "Abandoned")
		{
			MissionState.GetMissionSource().CustomMusicSet = 'LostAndAbandoned';
		}

		// Chosen Stronghold missions.
		if (MissionState.GetMissionSource().OverworldMeshPath == "StaticMesh'UI_3D.Overwold_Final.Chosen_Sarcophagus")
		{
			MissionState.GetMissionSource().CustomMusicSet = 'AlienFortress';
		}

		// Blacksite mission.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.Blacksite")
		{
			MissionState.GetMissionSource().CustomMusicSet = 'Tutorial';
		}

		// Forge mission.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.Forge")
		{
			MissionState.GetMissionSource().CustomMusicSet = 'Tutorial';
		}

		// Psi Gate mission.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.Forge")
		{
			MissionState.GetMissionSource().CustomMusicSet = 'Tutorial';
		}

		// Broadcast Tower mission.
		if (MissionState.GetMissionSource().OverworldMeshPath == "UI_3D.Overwold_Final.GP_BroadcastOfTruth")
		{
			MissionState.GetMissionSource().CustomMusicSet = 'LostTower_BossFight';
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
		// Template.CustomMusicSet = '??';
		// Template.CustomMusicSet = '??';
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
