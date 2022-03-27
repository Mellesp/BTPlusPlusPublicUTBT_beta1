//=============================================================================
// BT_PageBinds made by OwYeaW
//=============================================================================
class BT_PageBinds expands UWindowPageWindow;
//-----------------------------------------------------------------------------
var		Color						Basecolor;
//-----------------------------------------------------------------------------
//	Objects
//-----------------------------------------------------------------------------
var		UMenuLabelControl			SetCheckPointLabel;
var		UMenuRaisedButton			SetCheckPointButton;
var		UMenuLabelControl			NoCheckPointLabel;
var		UMenuRaisedButton			NoCheckPointButton;
var		UMenuLabelControl			SuicideLabel;
var		UMenuRaisedButton			SuicideButton;
var		UMenuLabelControl			WalkjumpLabel;
var		UMenuRaisedButton			WalkjumpButton;
var		UMenuLabelControl			BehindviewToggleLabel;
var		UMenuRaisedButton			BehindviewToggleButton;
var		UMenuLabelControl			ResetViewLabel;
var		UMenuRaisedButton			ResetViewButton;
var		UMenuLabelControl			OpenMapVoteLabel;
var		UMenuRaisedButton			OpenMapVoteButton;
var		UMenuLabelControl			OpenBTELabel;
var		UMenuRaisedButton			OpenBTEButton;
//-----------------------------------------------------------------------------
var 	UWindowSmallButton 			ResetSetCheckPointButton;
var 	UWindowSmallButton 			ResetNoCheckPointButton;
var 	UWindowSmallButton 			ResetSuicideButton;
var 	UWindowSmallButton 			ResetWalkjumpButton;
var 	UWindowSmallButton 			ResetBehindviewToggleButton;
var 	UWindowSmallButton 			ResetResetViewButton;
var 	UWindowSmallButton 			ResetOpenMapVoteButton;
var 	UWindowSmallButton 			ResetOpenBTEButton;
//-----------------------------------------------------------------------------
//	HotKey stuff
//-----------------------------------------------------------------------------
var 	bool 						bPolling;
var 	UMenuRaisedButton 			SelectedButton;
var 	string 						RealKeyName[255];
//-----------------------------------------------------------------------------
var float ControlOffset, ControlOffsetSpace;
//-----------------------------------------------------------------------------
function Created()
{
	local int ButtonWidth, ButtonLeft, ResetLeft;
	local int LabelWidth, LabelLeft;
	local int calc, CenterWidth;

	CenterWidth = (WinWidth/4)*3;
	LabelLeft = (WinWidth - CenterWidth)/2;

	calc =  WinWidth - LabelLeft*2;

	LabelWidth = calc * 0.35;
	ButtonWidth = calc * 0.25;
	ButtonLeft =  LabelLeft + LabelWidth;
	ResetLeft = ButtonLeft + LabelWidth + 16;

	bIgnoreLDoubleClick = True;
	bIgnoreMDoubleClick = True;
	bIgnoreRDoubleClick = True;

	Super.Created();

//	1	==========================================
	ControlOffset += 2;
//	1	==========================================
	SetCheckPointLabel = UMenuLabelControl(CreateControl(class'UMenuLabelControl', LabelLeft, ControlOffset, LabelWidth, 1));
	SetCheckPointLabel.SetText("Set Checkpoint");
	SetCheckPointLabel.SetTextColor(Basecolor);
	SetCheckPointLabel.SetFont(F_Normal);

	SetCheckPointButton = UMenuRaisedButton(CreateControl(class'UMenuRaisedButton', ButtonLeft, ControlOffset-3, LabelWidth, 1));
	SetCheckPointButton.bAcceptsFocus = False;
	SetCheckPointButton.bIgnoreLDoubleClick = True;
	SetCheckPointButton.bIgnoreMDoubleClick = True;
	SetCheckPointButton.bIgnoreRDoubleClick = True;

	ResetSetCheckPointButton = UWindowSmallButton(CreateControl(class'UWindowSmallButton', ResetLeft, ControlOffset-2, ButtonWidth, 20));
	ResetSetCheckPointButton.DownSound = Sound'Botpack.Click';
	ResetSetCheckPointButton.Text = "Remove";

//	2	==========================================
	ControlOffset += ControlOffsetSpace;
//	2	==========================================
	NoCheckPointLabel = UMenuLabelControl(CreateControl(class'UMenuLabelControl', LabelLeft, ControlOffset, LabelWidth, 1));
	NoCheckPointLabel.SetText("Remove Checkpoints");
	NoCheckPointLabel.SetTextColor(Basecolor);
	NoCheckPointLabel.SetFont(F_Normal);

	NoCheckPointButton = UMenuRaisedButton(CreateControl(class'UMenuRaisedButton', ButtonLeft, ControlOffset-3, LabelWidth, 1));
	NoCheckPointButton.bAcceptsFocus = False;
	NoCheckPointButton.bIgnoreLDoubleClick = True;
	NoCheckPointButton.bIgnoreMDoubleClick = True;
	NoCheckPointButton.bIgnoreRDoubleClick = True;

	ResetNoCheckPointButton = UWindowSmallButton(CreateControl(class'UWindowSmallButton', ResetLeft, ControlOffset-2, ButtonWidth, 20));
	ResetNoCheckPointButton.DownSound = Sound'Botpack.Click';
	ResetNoCheckPointButton.Text = "Remove";

//	3	==========================================
	ControlOffset += ControlOffsetSpace;
//	3	==========================================
	SuicideLabel = UMenuLabelControl(CreateControl(class'UMenuLabelControl', LabelLeft, ControlOffset, LabelWidth, 1));
	SuicideLabel.SetText("Suicide");
	SuicideLabel.SetTextColor(Basecolor);
	SuicideLabel.SetFont(F_Normal);

	SuicideButton = UMenuRaisedButton(CreateControl(class'UMenuRaisedButton', ButtonLeft, ControlOffset-3, LabelWidth, 1));
	SuicideButton.bAcceptsFocus = False;
	SuicideButton.bIgnoreLDoubleClick = True;
	SuicideButton.bIgnoreMDoubleClick = True;
	SuicideButton.bIgnoreRDoubleClick = True;

	ResetSuicideButton = UWindowSmallButton(CreateControl(class'UWindowSmallButton', ResetLeft, ControlOffset-2, ButtonWidth, 20));
	ResetSuicideButton.DownSound = Sound'Botpack.Click';
	ResetSuicideButton.Text = "Remove";

//	4	==========================================
	ControlOffset += ControlOffsetSpace;
//	4	==========================================
	WalkjumpLabel = UMenuLabelControl(CreateControl(class'UMenuLabelControl', LabelLeft, ControlOffset, LabelWidth, 1));
	WalkjumpLabel.SetText("Walkjump");
	WalkjumpLabel.SetTextColor(Basecolor);
	WalkjumpLabel.SetFont(F_Normal);

	WalkjumpButton = UMenuRaisedButton(CreateControl(class'UMenuRaisedButton', ButtonLeft, ControlOffset-3, LabelWidth, 1));
	WalkjumpButton.bAcceptsFocus = False;
	WalkjumpButton.bIgnoreLDoubleClick = True;
	WalkjumpButton.bIgnoreMDoubleClick = True;
	WalkjumpButton.bIgnoreRDoubleClick = True;

	ResetWalkjumpButton = UWindowSmallButton(CreateControl(class'UWindowSmallButton', ResetLeft, ControlOffset-2, ButtonWidth, 20));
	ResetWalkjumpButton.DownSound = Sound'Botpack.Click';
	ResetWalkjumpButton.Text = "Remove";

//	5	==========================================
	ControlOffset += ControlOffsetSpace;
//	5	==========================================
	BehindviewToggleLabel = UMenuLabelControl(CreateControl(class'UMenuLabelControl', LabelLeft, ControlOffset, LabelWidth, 1));
	BehindviewToggleLabel.SetText("Behindview Toggle");
	BehindviewToggleLabel.SetTextColor(Basecolor);
	BehindviewToggleLabel.SetFont(F_Normal);

	BehindviewToggleButton = UMenuRaisedButton(CreateControl(class'UMenuRaisedButton', ButtonLeft, ControlOffset-3, LabelWidth, 1));
	BehindviewToggleButton.bAcceptsFocus = False;
	BehindviewToggleButton.bIgnoreLDoubleClick = True;
	BehindviewToggleButton.bIgnoreMDoubleClick = True;
	BehindviewToggleButton.bIgnoreRDoubleClick = True;

	ResetBehindviewToggleButton = UWindowSmallButton(CreateControl(class'UWindowSmallButton', ResetLeft, ControlOffset-2, ButtonWidth, 20));
	ResetBehindviewToggleButton.DownSound = Sound'Botpack.Click';
	ResetBehindviewToggleButton.Text = "Remove";

//	6	==========================================
	ControlOffset += ControlOffsetSpace;
//	6	==========================================
	ResetviewLabel = UMenuLabelControl(CreateControl(class'UMenuLabelControl', LabelLeft, ControlOffset, LabelWidth, 1));
	ResetviewLabel.SetText("Resetview");
	ResetviewLabel.SetTextColor(Basecolor);
	ResetviewLabel.SetFont(F_Normal);

	ResetviewButton = UMenuRaisedButton(CreateControl(class'UMenuRaisedButton', ButtonLeft, ControlOffset-3, LabelWidth, 1));
	ResetviewButton.bAcceptsFocus = False;
	ResetviewButton.bIgnoreLDoubleClick = True;
	ResetviewButton.bIgnoreMDoubleClick = True;
	ResetviewButton.bIgnoreRDoubleClick = True;

	ResetResetviewButton = UWindowSmallButton(CreateControl(class'UWindowSmallButton', ResetLeft, ControlOffset-2, ButtonWidth, 20));
	ResetResetviewButton.DownSound = Sound'Botpack.Click';
	ResetResetviewButton.Text = "Remove";

//	7	==========================================
	ControlOffset += ControlOffsetSpace;
//	7	==========================================
	OpenMapVoteLabel = UMenuLabelControl(CreateControl(class'UMenuLabelControl', LabelLeft, ControlOffset, LabelWidth, 1));
	OpenMapVoteLabel.SetText("Open Mapvote");
	OpenMapVoteLabel.SetTextColor(Basecolor);
	OpenMapVoteLabel.SetFont(F_Normal);

	OpenMapVoteButton = UMenuRaisedButton(CreateControl(class'UMenuRaisedButton', ButtonLeft, ControlOffset-3, LabelWidth, 1));
	OpenMapVoteButton.bAcceptsFocus = False;
	OpenMapVoteButton.bIgnoreLDoubleClick = True;
	OpenMapVoteButton.bIgnoreMDoubleClick = True;
	OpenMapVoteButton.bIgnoreRDoubleClick = True;

	ResetOpenMapVoteButton = UWindowSmallButton(CreateControl(class'UWindowSmallButton', ResetLeft, ControlOffset-2, ButtonWidth, 20));
	ResetOpenMapVoteButton.DownSound = Sound'Botpack.Click';
	ResetOpenMapVoteButton.Text = "Remove";

//	8	==========================================
	ControlOffset += ControlOffsetSpace;
//	8	==========================================
	OpenBTELabel = UMenuLabelControl(CreateControl(class'UMenuLabelControl', LabelLeft, ControlOffset, LabelWidth, 1));
	OpenBTELabel.SetText("Open BT Settings");
	OpenBTELabel.SetTextColor(Basecolor);
	OpenBTELabel.SetFont(F_Normal);

	OpenBTEButton = UMenuRaisedButton(CreateControl(class'UMenuRaisedButton', ButtonLeft, ControlOffset-3, LabelWidth, 1));
	OpenBTEButton.bAcceptsFocus = False;
	OpenBTEButton.bIgnoreLDoubleClick = True;
	OpenBTEButton.bIgnoreMDoubleClick = True;
	OpenBTEButton.bIgnoreRDoubleClick = True;

	ResetOpenBTEButton = UWindowSmallButton(CreateControl(class'UWindowSmallButton', ResetLeft, ControlOffset-2, ButtonWidth, 20));
	ResetOpenBTEButton.DownSound = Sound'Botpack.Click';
	ResetOpenBTEButton.Text = "Remove";

	LoadExistingKeys();
}

function LoadExistingKeys()
{
	local int i;
	local string KeyName, Alias;

	for(i = 0; i < 255; i++)
	{
		KeyName = GetPlayerOwner().ConsoleCommand("KEYNAME " $ i);
		RealKeyName[i] = KeyName;

		if(KeyName != "")
		{
			Alias = Caps(GetPlayerOwner().ConsoleCommand("KEYBINDING " $ KeyName));

			switch(Alias)
			{
				case "MUTATE CHECKPOINT":
					SetCheckPointButton.SetText(KeyName);
				break;

				case "MUTATE NOCHECKPOINT":
					NoCheckPointButton.SetText(KeyName);
				break;

				case "SUICIDE":
					SuicideButton.SetText(KeyName);
				break;

				case "WALKING|JUMP":
					WalkJumpButton.SetText(KeyName);
				break;

				case "MUTATE BEHINDVIEWTOGGLE":
					BehindviewToggleButton.SetText(KeyName);
				break;

				case "MUTATE RESETVIEW":
					ResetviewButton.SetText(KeyName);
				break;

				case "MUTATE BDBMAPVOTE VOTEMENU":
					OpenMapVoteButton.SetText(KeyName);
				break;

				case "MUTATE BTE":
					OpenBTEButton.SetText(KeyName);
				break;
			}
		}
	}
}

function KeyDown(int Key, float X, float Y)
{
	if(bPolling)
	{
		ProcessMenuKey(Key, RealKeyName[Key]);
		bPolling = False;
		SelectedButton.bDisabled = False;
	}
}

function ProcessMenuKey(int KeyNo, string KeyName)
{
	if ( (KeyName == "") || (KeyName == "Escape")  
		|| ((KeyNo >= 0x70 ) && (KeyNo <= 0x79)) // function keys
		|| ((KeyNo >= 0x30 ) && (KeyNo <= 0x39))) // number keys
		return;

	if(SetCheckPointButton.bDisabled)
	{
		GetPlayerOwner().ConsoleCommand("SET INPUT " $ SetCheckPointButton.Text);
		GetPlayerOwner().ConsoleCommand("SET INPUT " $ KeyName $ " MUTATE CHECKPOINT");
		SelectedButton.SetText(KeyName);
	}
	else if(NoCheckPointButton.bDisabled)
	{
		GetPlayerOwner().ConsoleCommand("SET INPUT " $ NoCheckPointButton.Text);
		GetPlayerOwner().ConsoleCommand("SET INPUT " $ KeyName $ " MUTATE NOCHECKPOINT");
		SelectedButton.SetText(KeyName);
	}
	else if(SuicideButton.bDisabled)
	{
		GetPlayerOwner().ConsoleCommand("SET INPUT " $ SuicideButton.Text);
		GetPlayerOwner().ConsoleCommand("SET INPUT " $ KeyName $ " SUICIDE");
		SelectedButton.SetText(KeyName);
	}
	else if(WalkJumpButton.bDisabled)
	{
		GetPlayerOwner().ConsoleCommand("SET INPUT " $ WalkJumpButton.Text);
		GetPlayerOwner().ConsoleCommand("SET INPUT " $ KeyName $ " WALKING|JUMP");
		SelectedButton.SetText(KeyName);
	}
	else if(BehindviewToggleButton.bDisabled)
	{
		GetPlayerOwner().ConsoleCommand("SET INPUT " $ BehindviewToggleButton.Text);
		GetPlayerOwner().ConsoleCommand("SET INPUT " $ KeyName $ " MUTATE BEHINDVIEWTOGGLE");
		SelectedButton.SetText(KeyName);
	}
	else if(ResetViewButton.bDisabled)
	{
		GetPlayerOwner().ConsoleCommand("SET INPUT " $ ResetViewButton.Text);
		GetPlayerOwner().ConsoleCommand("SET INPUT " $ KeyName $ " MUTATE RESETVIEW");
		SelectedButton.SetText(KeyName);
	}
	else if(OpenMapVoteButton.bDisabled)
	{
		GetPlayerOwner().ConsoleCommand("SET INPUT " $ OpenMapVoteButton.Text);
		GetPlayerOwner().ConsoleCommand("SET INPUT " $ KeyName $ " MUTATE BDBMAPVOTE VOTEMENU");
		SelectedButton.SetText(KeyName);
	}
	else if(OpenBTEButton.bDisabled)
	{
		GetPlayerOwner().ConsoleCommand("SET INPUT " $ OpenBTEButton.Text);
		GetPlayerOwner().ConsoleCommand("SET INPUT " $ KeyName $ " MUTATE BTE");
		SelectedButton.SetText(KeyName);
	}
}

function Notify(UWindowDialogControl C, byte E)
{
	super.Notify(C, E);

	switch(E)
	{
		case DE_RClick:
			if(bPolling)
			{
				if(C == SelectedButton)
				{
					ProcessMenuKey(2, "RightMouse");
					bPolling = False;
					SelectedButton.bDisabled = False;
					return;
				}
			}
		break;
		case DE_MClick:
			if(bPolling)
			{
				if(C == SelectedButton)
				{
					ProcessMenuKey(4, "MiddleMouse");
					bPolling = False;
					SelectedButton.bDisabled = False;
					return;
				}
			}
		break;
		case DE_Click:
			if(bPolling)
			{
				if(C == SelectedButton)
				{
					ProcessMenuKey(1, "LeftMouse");
					bPolling = False;
					SelectedButton.bDisabled = False;
					return;
				}
			}
			switch(C)
			{
				case ResetSetCheckPointButton:
					GetPlayerOwner().ConsoleCommand("SET INPUT " $ SetCheckPointButton.Text);
					SetCheckPointButton.SetText("");
					LoadExistingKeys();
				break;
				case ResetNoCheckPointButton:
					GetPlayerOwner().ConsoleCommand("SET INPUT " $ NoCheckPointButton.Text);
					NoCheckPointButton.SetText("");
					LoadExistingKeys();
				break;
				case ResetSuicideButton:
					GetPlayerOwner().ConsoleCommand("SET INPUT " $ SuicideButton.Text);
					SuicideButton.SetText("");
					LoadExistingKeys();
				break;
				case ResetWalkjumpButton:
					GetPlayerOwner().ConsoleCommand("SET INPUT " $ WalkJumpButton.Text);
					WalkJumpButton.SetText("");
					LoadExistingKeys();
				break;
				case ResetBehindviewToggleButton:
					GetPlayerOwner().ConsoleCommand("SET INPUT " $ BehindviewToggleButton.Text);
					BehindviewToggleButton.SetText("");
					LoadExistingKeys();
				break;
				case ResetResetViewButton:
					GetPlayerOwner().ConsoleCommand("SET INPUT " $ ResetViewButton.Text);
					ResetViewButton.SetText("");
					LoadExistingKeys();
				break;
				case ResetOpenMapVoteButton:
					GetPlayerOwner().ConsoleCommand("SET INPUT " $ OpenMapvoteButton.Text);
					OpenMapvoteButton.SetText("");
					LoadExistingKeys();
				break;
				case ResetOpenBTEButton:
					GetPlayerOwner().ConsoleCommand("SET INPUT " $ OpenBTEButton.Text);
					OpenBTEButton.SetText("");
					LoadExistingKeys();
				break;

				case SetCheckPointButton:
				case NoCheckPointButton:
				case SuicideButton:
				case WalkJumpButton:
				case BehindviewToggleButton:
				case ResetViewButton:
				case OpenMapvoteButton:
				case OpenBTEButton:
					if(UMenuRaisedButton(C) != None)
					{
						SelectedButton = UMenuRaisedButton(C);
						if(SelectedButton != None)
						{
							bPolling = True;
							SelectedButton.bDisabled = True;
						}
					}
				break;
			}
		break;
    }
}

defaultproperties
{
	ControlOffset=8
	ControlOffsetSpace=22
	Basecolor=(R=0,G=0,B=0)
}