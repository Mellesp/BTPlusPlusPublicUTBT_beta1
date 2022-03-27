//=============================================================================
// BTClientSettings made by OwYeaW
//=============================================================================
class BTClientSettings expands Info config(BTPlusPlusPublic);
//=============================================================================
// Config Variables
//=============================================================================
var config bool		bBehindviewFollow;
var config int		BehindviewSmoothing;
var config int		BehindviewDistance;
var config int		SpectatorFlySpeed;
var config bool		bHideArmor;
var config bool		bGhostSpectator;
//=============================================================================
var config bool		CustomTimer;
var config int		TimerLocationX;
var config int		TimerLocationY;
var config float	TimerScale;
var config byte		TimerRed;
var config byte		TimerGreen;
var config byte		TimerBlue;
//=============================================================================
var config bool		TransparentPlayers;
var config bool		TransparentSelf;
var config bool		ShowSpeedoMeterHorizontal;
var config bool		ShowSpeedoMeterVertical;
var config bool		MuteAnnouncerAndHUDMessages;
var config bool		BehindViewCrosshair;
var config bool		InstantRespawnCheckpoint;
//=============================================================================
var config string	Mystart[1024];
//=============================================================================
// Server Variables
//=============================================================================
var bool	Server_bBehindviewFollow;
var int		Server_BehindviewSmoothing;
var int		Server_BehindviewDistance;
var int		Server_SpectatorFlySpeed;
var bool	Server_bHideArmor;
var bool	Server_bGhostSpectator;
var string	Server_MyStart;
var bool	Server_InstantCP;
//=============================================================================
// Other Variables
//=============================================================================
var string Client_MyStart;
var BTPlusPlus Controller;
//=============================================================================
// Replication and Tick
//=============================================================================
replication
{
	reliable if (Role < ROLE_Authority)
		SetServerVars;

	reliable if(Role == ROLE_Authority)
		GetClientVars, saveMyStart, SwitchBool, TransparentSelf;
}
function Tick(float DeltaTime)
{
	if(Owner == None)
		Destroy();
}
//=============================================================================
// Initialize
//=============================================================================
event Spawned()
{
	GetClientVars();
}
simulated function GetClientVars()
{
	Client_MyStart = getMystart();
	SetServerVars(bBehindviewFollow, BehindviewSmoothing, BehindviewDistance, SpectatorFlySpeed, bHideArmor, bGhostSpectator, Client_MyStart, InstantRespawnCheckpoint);

	if(TransparentSelf)
	{
		TournamentPlayer(Owner).Style = STY_Translucent;
		if(TournamentPlayer(Owner).Weapon != None)
			TournamentPlayer(Owner).Weapon.Style = STY_Translucent;
	}

	TournamentPlayer(Owner).Deaths[0] = None;
	TournamentPlayer(Owner).Deaths[1] = None;
	TournamentPlayer(Owner).Deaths[2] = None;
	TournamentPlayer(Owner).Deaths[3] = None;
	TournamentPlayer(Owner).Deaths[4] = None;
	TournamentPlayer(Owner).Deaths[5] = None;
}
function SetServerVars(bool BF, int BIS, int BVD, int SFS, bool HA, bool GS, string MS, bool IRCP)
{
	Server_bBehindviewFollow	= BF;
	Server_BehindviewSmoothing	= BIS;
	Server_BehindviewDistance	= BVD;
	Server_SpectatorFlySpeed	= SFS;
	Server_bHideArmor			= HA;
	Server_bHideArmor			= HA;
	Server_bGhostSpectator		= GS;
	Server_MyStart				= MS;
	Server_InstantCP			= IRCP;

	if(BTSpectator(Owner) != None)
		BTSpectator(Owner).Grab();
	else
		Controller.extractMystart(Server_MyStart, PlayerPawn(Owner));
}
//=============================================================================
// Mystart stuff
//=============================================================================
simulated function string getMystart()
{
	local int i, l;
	local string mapname;

	mapname = GetLevelName();
	l = Len(mapname);

	for(i = 0; i < 1024; i++)
		if(Left(mystart[i], l) == mapname)
			return(Right(mystart[i], len(mystart[i]) - l - 1));
	return("X");
}
simulated function string GetLevelName()
{
	local string Str;
	local int Pos;

	Str = string(Level);
	Pos = InStr(Str, ".");
	if(Pos != -1)
		return Left(Str, Pos);
	else
		return Str;
}
//=============================================================================
// Settings Stuff
//=============================================================================
simulated function SwitchBool(string BoolName)
{
	switch(BoolName)
	{
		case "bBehindviewFollow": bBehindviewFollow = !bBehindviewFollow; break;
		case "bHideArmor": bHideArmor = !bHideArmor; break;
		case "bGhostSpectator": bGhostSpectator = !bGhostSpectator; break;
		case "CustomTimer": CustomTimer = !CustomTimer; break;

		case "TransparentPlayers": TransparentPlayers = !TransparentPlayers; break;
		case "TransparentSelf": TransparentSelf = !TransparentSelf; break;
		case "ShowSpeedoMeterHorizontal": ShowSpeedoMeterHorizontal = !ShowSpeedoMeterHorizontal; break;
		case "ShowSpeedoMeterVertical": ShowSpeedoMeterVertical = !ShowSpeedoMeterVertical; break;
		case "MuteAnnouncerAndHUDMessages": MuteAnnouncerAndHUDMessages = !MuteAnnouncerAndHUDMessages; break;
		case "BehindViewCrosshair": BehindViewCrosshair = !BehindViewCrosshair; break;
		case "InstantRespawnCheckpoint": InstantRespawnCheckpoint = !InstantRespawnCheckpoint; break;
	}
	SetServerVars(bBehindviewFollow, BehindviewSmoothing, BehindviewDistance, SpectatorFlySpeed, bHideArmor, bGhostSpectator, Client_MyStart, InstantRespawnCheckpoint);
	SaveConfig();
}
simulated function FloatSetting(string Setting, float Number)
{
	switch(Setting)
	{
		case "TimerScale": TimerScale = Number; break;
		case "Red":		TimerRed = Number; break;
		case "Green":	TimerGreen = Number; break;
		case "Blue":	TimerBlue = Number; break;
		case "X":		TimerLocationX = Number; break;
		case "Y":		TimerLocationY = Number; break;
	}
	SaveConfig();
}
simulated function IntSetting(string Setting, int Number)
{
	switch(Setting)
	{
		case "BehindviewSmoothing": BehindviewSmoothing = Number; break;
		case "BehindviewDistance": BehindviewDistance = Number; break;
		case "SpectatorFlySpeed": SpectatorFlySpeed = Number; break;
	}
	SetServerVars(bBehindviewFollow, BehindviewSmoothing, BehindviewDistance, SpectatorFlySpeed, bHideArmor, bGhostSpectator, Client_MyStart, InstantRespawnCheckpoint);
	SaveConfig();
}
simulated function saveMyStart(string text)
{
	local int i, l, x;
	local string mapname;
	local bool bFound;

	mapname = GetLevelName();
	l = Len(mapname);

	for(i = 0; i < 1024; i++)
	{
		if(mystart[i] != "")
			x = i + 1;

		if(Left(mystart[i], l) == mapname)
		{
			bFound = true;
			break;
		}
	}

	if(bFound)
		mystart[i] = mapname $ "," $ text;
	else if(x >= 1024)
		PlayerPawn(Owner).ClientMessage("Your mystart list is full, check your BTPlusPlusPublic.ini file in System folder");
	else
		mystart[x] = mapname $ "," $ text;

	SaveConfig();
}
//=============================================================================
// Default Properties
//=============================================================================
defaultproperties
{
	bBehindviewFollow=false
	BehindviewSmoothing=100
	BehindviewDistance=180
	SpectatorFlySpeed=450
	bHideArmor=false
	bGhostSpectator=false
	CustomTimer=false
	TimerLocationX=0
	TimerLocationY=0
	TimerScale=1
	TimerRed=255
	TimerGreen=88
	TimerBlue=0
	TransparentPlayers=false
	TransparentSelf=false
	ShowSpeedoMeterHorizontal=false
	ShowSpeedoMeterVertical=false
	MuteAnnouncerAndHUDMessages=false
	BehindViewCrosshair=false
	InstantRespawnCheckpoint=false
	Mystart(0)=""
}