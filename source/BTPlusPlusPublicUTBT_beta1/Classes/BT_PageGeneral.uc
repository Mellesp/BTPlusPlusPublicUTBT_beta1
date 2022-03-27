//=============================================================================
// BT_PageGeneral made by OwYeaW
//=============================================================================
class BT_PageGeneral expands UWindowPageWindow;
//-----------------------------------------------------------------------------
var		BT_WRI						BTWRI;
var		ClientData					Config;
var		BTClientSettings			BTCS;
//-----------------------------------------------------------------------------
var		bool						bInitialized;
var		Color						Basecolor;
//-----------------------------------------------------------------------------
//	Objects
//-----------------------------------------------------------------------------
var		UWindowCheckbox				AntiBoostCheck;
var		UWindowCheckbox				TransparentPlayersCheck;
var		UWindowCheckbox				TransparentSelfCheck;
var		UWindowCheckbox				ShowSpeedoMeterHorizontalCheck;
var		UWindowCheckbox				ShowSpeedoMeterVerticalCheck;
var		UWindowCheckbox				MuteAnnouncerAndHUDMessagesCheck;
var		UWindowCheckbox				BehindviewCrosshairCheck;
var		UWindowCheckbox				InstantRespawnCPCheck;
//-----------------------------------------------------------------------------
var float ControlOffset, ControlOffsetSpace;
//-----------------------------------------------------------------------------
function Created()
{
	local int ControlWidth, ControlLeft, ControlRight;
	local int CenterWidth, CenterPos;

	Super.Created();

	ControlWidth = WinWidth/2.5;
	ControlLeft = (WinWidth/2 - ControlWidth)/2;
	ControlRight = WinWidth/2 + ControlLeft;

	CenterWidth = (WinWidth/4)*3;
	CenterPos = (WinWidth - CenterWidth)/2;

//	1	==========================================
	//	AntiBoost
	AntiBoostCheck = UWindowCheckbox(CreateControl(class'UWindowCheckbox', CenterPos, ControlOffset, CenterWidth, 1));
	AntiBoostCheck.SetText("Use AntiBoost");
	AntiBoostCheck.SetTextColor(Basecolor);
	AntiBoostCheck.SetFont(F_Normal);
	AntiBoostCheck.Align = TA_Left;

//	2	==========================================
	ControlOffset += ControlOffsetSpace;
//	2	==========================================
	//	Ghosts
	TransparentPlayersCheck = UWindowCheckbox(CreateControl(class'UWindowCheckbox', CenterPos, ControlOffset, CenterWidth, 1));
	TransparentPlayersCheck.SetText("Transparent Players");
	TransparentPlayersCheck.SetTextColor(Basecolor);
	TransparentPlayersCheck.SetFont(F_Normal);
	TransparentPlayersCheck.Align = TA_Left;

//	3	==========================================
	ControlOffset += ControlOffsetSpace;
//	3	==========================================
	//	Show BrightSkins
	TransparentSelfCheck = UWindowCheckbox(CreateControl(class'UWindowCheckbox', CenterPos, ControlOffset, CenterWidth, 1));
	TransparentSelfCheck.SetText("Transparent Self");
	TransparentSelfCheck.SetTextColor(Basecolor);
	TransparentSelfCheck.SetFont(F_Normal);
	TransparentSelfCheck.Align = TA_Left;

//	4	==========================================
	ControlOffset += ControlOffsetSpace;
//	4	==========================================
	//	SpeedMeter
	ShowSpeedoMeterHorizontalCheck = UWindowCheckbox(CreateControl(class'UWindowCheckbox', CenterPos, ControlOffset, CenterWidth, 1));
	ShowSpeedoMeterHorizontalCheck.SetText("SpeedoMeter - Horizonal");
	ShowSpeedoMeterHorizontalCheck.SetTextColor(Basecolor);
	ShowSpeedoMeterHorizontalCheck.SetFont(F_Normal);
	ShowSpeedoMeterHorizontalCheck.Align = TA_Left;

//	5	==========================================
	ControlOffset += ControlOffsetSpace;
//	5	==========================================
	//	SpeedMeter
	ShowSpeedoMeterVerticalCheck = UWindowCheckbox(CreateControl(class'UWindowCheckbox', CenterPos, ControlOffset, CenterWidth, 1));
	ShowSpeedoMeterVerticalCheck.SetText("SpeedoMeter - Vertical");
	ShowSpeedoMeterVerticalCheck.SetTextColor(Basecolor);
	ShowSpeedoMeterVerticalCheck.SetFont(F_Normal);
	ShowSpeedoMeterVerticalCheck.Align = TA_Left;

//	6	==========================================
	ControlOffset += ControlOffsetSpace;
//	6	==========================================
	//	MuteAnnouncerAndHUDMessages
	MuteAnnouncerAndHUDMessagesCheck = UWindowCheckbox(CreateControl(class'UWindowCheckbox', CenterPos, ControlOffset, CenterWidth, 1));
	MuteAnnouncerAndHUDMessagesCheck.SetText("Mute Announcer and HUD Messages");
	MuteAnnouncerAndHUDMessagesCheck.SetTextColor(Basecolor);
	MuteAnnouncerAndHUDMessagesCheck.SetFont(F_Normal);
	MuteAnnouncerAndHUDMessagesCheck.Align = TA_Left;

//	7	==========================================
	ControlOffset += ControlOffsetSpace;
//	7	==========================================
	//	BehindviewCrosshair
	BehindviewCrosshairCheck = UWindowCheckbox(CreateControl(class'UWindowCheckbox', CenterPos, ControlOffset, CenterWidth, 1));
	BehindviewCrosshairCheck.SetText("Use Behindview Crosshair");
	BehindviewCrosshairCheck.SetTextColor(Basecolor);
	BehindviewCrosshairCheck.SetFont(F_Normal);
	BehindviewCrosshairCheck.Align = TA_Left;

//	8	==========================================
	ControlOffset += ControlOffsetSpace;
//	8	==========================================
	//	BehindviewCrosshair
	InstantRespawnCPCheck = UWindowCheckbox(CreateControl(class'UWindowCheckbox', CenterPos, ControlOffset, CenterWidth, 1));
	InstantRespawnCPCheck.SetText("Instant Respawn Checkpoints");
	InstantRespawnCPCheck.SetTextColor(Basecolor);
	InstantRespawnCPCheck.SetFont(F_Normal);
	InstantRespawnCPCheck.Align = TA_Left;
}

function LoadSettings()
{
	local float S;

	bInitialized = false;

	AntiBoostCheck.bChecked						= Config.bAntiBoost;
	TransparentPlayersCheck.bChecked			= BTCS.TransparentPlayers;
	TransparentSelfCheck.bChecked				= BTCS.TransparentSelf;
	ShowSpeedoMeterHorizontalCheck.bChecked		= BTCS.ShowSpeedoMeterHorizontal;
	ShowSpeedoMeterVerticalCheck.bChecked		= BTCS.ShowSpeedoMeterVertical;
	MuteAnnouncerAndHUDMessagesCheck.bChecked	= BTCS.MuteAnnouncerAndHUDMessages;
	BehindviewCrosshairCheck.bChecked			= BTCS.BehindViewCrosshair;
	InstantRespawnCPCheck.bChecked				= BTCS.InstantRespawnCheckpoint;

	bInitialized = true;
}

function Notify(UWindowDialogControl C, byte E)
{
	Super.Notify(C, E);
	
	if(bInitialized)
	{
		switch(E)
		{
			case DE_Change:
				switch(C)
				{
					case AntiBoostCheck:
						AntiBoostChanged();
					break;

					case TransparentPlayersCheck:
						TransparentPlayersChanged();
					break;

					case TransparentSelfCheck:
						TransparentSelfChanged();
					break;

					case ShowSpeedoMeterHorizontalCheck:
						ShowSpeedoMeterHorizontalChanged();
					break;

					case ShowSpeedoMeterVerticalCheck:
						ShowSpeedoMeterVerticalChanged();
					break;

					case MuteAnnouncerAndHUDMessagesCheck:
						MuteAnnouncerAndHUDMessagesChanged();
					break;
					
					case BehindviewCrosshairCheck:
						BehindviewCrosshairChanged();
					break;

					case InstantRespawnCPCheck:
						InstantRespawnCPChanged();
					break;
				}
			break;
		}
	}
}

function AntiBoostChanged()
{
	BTWRI.AntiBoost(Config, AntiBoostCheck.bChecked);
}

function TransparentPlayersChanged()
{
	local TournamentPlayer TP;

	foreach GetLevel().AllActors(class'TournamentPlayer', TP)
	{
		if(TP == TournamentPlayer(GetPlayerOwner()))
			continue;

		TP.Style = STY_Normal;
		if (TP.Weapon != None)
			TP.Weapon.Style = STY_Normal;
	}
	BTCS.SwitchBool("TransparentPlayers");
}

function TransparentSelfChanged()
{
	local PlayerPawn PP;

	PP = GetPlayerOwner();
	if(TournamentPlayer(PP) != None)
	{
		if(TransparentSelfCheck.bChecked)
		{
			PP.Style = STY_Translucent;
			if(PP.Weapon != None)
				PP.Weapon.Style = STY_Translucent;
		}
		else
		{
			PP.Style = STY_Normal;
			if(PP.Weapon != None)
				PP.Weapon.Style = STY_Normal;
		}
	}
	BTCS.SwitchBool("TransparentSelf");
}

function ShowSpeedoMeterHorizontalChanged()
{
	BTCS.SwitchBool("ShowSpeedoMeterHorizontal");
}

function ShowSpeedoMeterVerticalChanged()
{
	BTCS.SwitchBool("ShowSpeedoMeterVertical");
}

function MuteAnnouncerAndHUDMessagesChanged()
{
	BTCS.SwitchBool("MuteAnnouncerAndHUDMessages");
}

function BehindviewCrosshairChanged()
{
	BTCS.SwitchBool("BehindviewCrosshair");
}

function InstantRespawnCPChanged()
{
	BTCS.SwitchBool("InstantRespawnCheckpoint");
}

defaultproperties
{
	ControlOffset=8
	ControlOffsetSpace=22
	Basecolor=(R=0,G=0,B=0)
}