//=============================================================================
// BT_PageTimer made by OwYeaW
//=============================================================================
class BT_PageTimer expands UWindowPageWindow;
//-----------------------------------------------------------------------------
var		BTClientSettings			BTCS;
//-----------------------------------------------------------------------------
var		bool						bInitialized;
var		Color						Basecolor;
//-----------------------------------------------------------------------------
//	Objects
//-----------------------------------------------------------------------------
var 	UWindowSmallButton 			ResetCustomSettingsButton;
var		UWindowCheckbox				CustomTimerCheck;
var		UWindowLabelControl			TimerSizeLabel;
var		BT_SliderControl			TimerSizeSlider;
var		BT_SliderControl			TimerLocationXSlider;
var		BT_SliderControl			TimerLocationYSlider;
var		UWindowLabelControl			TimerColorRLabel;
var		BT_SliderControl			TimerColorRSlider;
var		UWindowLabelControl			TimerColorGLabel;
var		BT_SliderControl			TimerColorGSlider;
var		UWindowLabelControl			TimerColorBLabel;
var		BT_SliderControl			TimerColorBSlider;
//-----------------------------------------------------------------------------
var		int							TimerOffsetX, TimerOffsetY;
//-----------------------------------------------------------------------------
var		float						ControlOffset, ControlOffsetSpace;
//-----------------------------------------------------------------------------
function Created()
{
	local int ControlWidth, ControlLeft, ControlRight;
	local int CenterWidth, CenterPos, newWidth;

	Super.Created();

	ControlWidth = WinWidth/2.5;
	ControlLeft = (WinWidth/2 - ControlWidth)/2;
	ControlRight = WinWidth/2 + ControlLeft;

	CenterWidth = (WinWidth/4)*3;
	CenterPos = (WinWidth - CenterWidth)/2;

	newWidth = CenterWidth - (ControlRight - CenterPos);

	// ResetCustomSettingsButton
	ResetCustomSettingsButton = UWindowSmallButton(CreateControl(class'UWindowSmallButton', CenterPos, ControlOffset, newWidth, 20));
	ResetCustomSettingsButton.DownSound = Sound'Botpack.Click';
	ResetCustomSettingsButton.Text = "Reset Custom Timer";

	// CustomTimer
	CustomTimerCheck = UWindowCheckbox(CreateControl(class'UWindowCheckbox', ControlRight, ControlOffset, newWidth, 1));
	CustomTimerCheck.SetText("Use Custom Timer");
	CustomTimerCheck.SetTextColor(Basecolor);
	CustomTimerCheck.SetFont(F_Normal);
	CustomTimerCheck.Align = TA_Left;

	ControlOffset += ControlOffsetSpace;
	ControlOffset += 13;

	// TimerSizeLabel
	TimerSizeLabel = UWindowLabelControl(CreateControl(class'UWindowLabelControl', CenterPos, ControlOffset, CenterWidth, 1));
	TimerSizeLabel.SetText("Size");
	TimerSizeLabel.SetFont(F_Normal);
	TimerSizeLabel.SetTextColor(Basecolor);

	// TimerSize
	TimerSizeSlider = BT_SliderControl(CreateControl(class'BT_SliderControl', CenterPos, ControlOffset, CenterWidth, 1));
	TimerSizeSlider.SetRange(0, 5, 0);
	TimerSizeSlider.SetTextColor(Basecolor);
	TimerSizeSlider.SetFont(F_Normal);
	TimerSizeSlider.Align = TA_Right;

	ControlOffset += ControlOffsetSpace;

	// TimerLocationX
	TimerLocationXSlider = BT_SliderControl(CreateControl(class'BT_SliderControl', CenterPos, ControlOffset, CenterWidth, 1));
	TimerLocationXSlider.SetText("X Position");
	TimerLocationXSlider.SetTextColor(Basecolor);
	TimerLocationXSlider.SetFont(F_Normal);
	TimerLocationXSlider.Align = TA_Left;

	ControlOffset += ControlOffsetSpace;

	// TimerLocationY
	TimerLocationYSlider = BT_SliderControl(CreateControl(class'BT_SliderControl', CenterPos, ControlOffset, CenterWidth, 1));
	TimerLocationYSlider.SetText("Y Position");
	TimerLocationYSlider.SetTextColor(Basecolor);
	TimerLocationYSlider.SetFont(F_Normal);
	TimerLocationYSlider.Align = TA_Left;

	ControlOffset += ControlOffsetSpace;
	ControlOffset += 13;

	// TimerColorRLabel
	TimerColorRLabel = UWindowLabelControl(CreateControl(class'UWindowLabelControl', CenterPos, ControlOffset, CenterWidth, 1));
	TimerColorRLabel.SetText("Red");
	TimerColorRLabel.SetFont(F_Normal);
	TimerColorRLabel.SetTextColor(Basecolor);

	// TimerColorR
	TimerColorRSlider = BT_SliderControl(CreateControl(class'BT_SliderControl', CenterPos, ControlOffset, CenterWidth, 1));
	TimerColorRSlider.SetRange(0, 255, 1);
	TimerColorRSlider.SetTextColor(Basecolor);
	TimerColorRSlider.SetFont(F_Normal);
	TimerColorRSlider.Align = TA_Right;

	ControlOffset += ControlOffsetSpace;

	// TimerColorGLabel
	TimerColorGLabel = UWindowLabelControl(CreateControl(class'UWindowLabelControl', CenterPos, ControlOffset, CenterWidth, 1));
	TimerColorGLabel.SetText("Green");
	TimerColorGLabel.SetFont(F_Normal);
	TimerColorGLabel.SetTextColor(Basecolor);

	// TimerColorG
	TimerColorGSlider = BT_SliderControl(CreateControl(class'BT_SliderControl', CenterPos, ControlOffset, CenterWidth, 1));
	TimerColorGSlider.SetRange(0, 255, 1);
	TimerColorGSlider.SetTextColor(Basecolor);
	TimerColorGSlider.SetFont(F_Normal);
	TimerColorGSlider.Align = TA_Right;

	ControlOffset += ControlOffsetSpace;

	// TimerColorBLabel
	TimerColorBLabel = UWindowLabelControl(CreateControl(class'UWindowLabelControl', CenterPos, ControlOffset, CenterWidth, 1));
	TimerColorBLabel.SetText("Blue");
	TimerColorBLabel.SetFont(F_Normal);
	TimerColorBLabel.SetTextColor(Basecolor);

	// TimerColorB
	TimerColorBSlider = BT_SliderControl(CreateControl(class'BT_SliderControl', CenterPos, ControlOffset, CenterWidth, 1));
	TimerColorBSlider.SetRange(0, 255, 1);
	TimerColorBSlider.SetTextColor(Basecolor);
	TimerColorBSlider.SetFont(F_Normal);
	TimerColorBSlider.Align = TA_Right;
}

function LoadSettings()
{
	local float S;

	bInitialized = false;

	CustomTimerCheck.bChecked = BTCS.CustomTimer;

	TimerColorRSlider.SetValue(BTCS.TimerRed);
	S = TimerColorRSlider.Value;
	TimerColorRSlider.SetText("[" $ int(S) $ "]");

	TimerColorGSlider.SetValue(BTCS.TimerGreen);
	S = TimerColorGSlider.Value;
	TimerColorGSlider.SetText("[" $ int(S) $ "]");

	TimerColorBSlider.SetValue(BTCS.TimerBlue);
	S = TimerColorBSlider.Value;
	TimerColorBSlider.SetText("[" $ int(S) $ "]");

	bInitialized = true;

	InitTimerSliders();
}

function InitTimerSliders()
{
	local float S, MaximumLocationX, MaximumLocationY;

	bInitialized = false;

	TimerSizeSlider.SetValue(BTCS.TimerScale);
	S = (TimerSizeSlider.Value / 1) * 100;
	TimerSizeSlider.SetText("[" $ int(S) $ "%]");

	MaximumLocationX = (Root.WinWidth / 2) - (TimerOffsetX * BTCS.TimerScale);
	MaximumLocationY = Root.WinHeight - (TimerOffsetY * BTCS.TimerScale);

	TimerLocationXSlider.SetRange(-MaximumLocationX, MaximumLocationX, 0);
	TimerLocationXSlider.SetValue(BTCS.TimerLocationX);

	TimerLocationYSlider.SetRange(0, MaximumLocationY, 0);
	TimerLocationYSlider.SetValue(BTCS.TimerLocationY);

	bInitialized = true;
}

function Notify(UWindowDialogControl C, byte E)
{
	local float S;

	Super.Notify(C, E);
	switch(E)
	{
		case DE_Click:
		    switch(C)
            {
				case ResetCustomSettingsButton:
					ResetTimerSettings();
				break;
			}
		break;

		case DE_Change:
			switch(C)
			{
				case CustomTimerCheck:
					BTCS.SwitchBool("CustomTimer");
				break;

				case TimerSizeSlider:
					if(bInitialized)
					{
						S = (TimerSizeSlider.Value / 1) * 100;
						TimerSizeSlider.SetText("[" $ int(S) $ "%]");
						BTCS.FloatSetting("TimerScale", TimerSizeSlider.Value);
						SetTimerLocationSliders();
					}
				break;

				case TimerLocationXSlider:
					if(bInitialized)
						BTCS.FloatSetting("X", int(TimerLocationXSlider.Value));
				break;

				case TimerLocationYSlider:
					if(bInitialized)
						BTCS.FloatSetting("Y", int(TimerLocationYSlider.Value));
				break;

				case TimerColorRSlider:
					S = TimerColorRSlider.Value;
					TimerColorRSlider.SetText("[" $ int(S) $ "]");
					BTCS.FloatSetting("Red", byte(TimerColorRSlider.Value));
				break;

				case TimerColorGSlider:
					S = TimerColorGSlider.Value;
					TimerColorGSlider.SetText("[" $ int(S) $ "]");
					BTCS.FloatSetting("Green", byte(TimerColorGSlider.Value));
				break;

				case TimerColorBSlider:
					S = TimerColorBSlider.Value;
					TimerColorBSlider.SetText("[" $ int(S) $ "]");
					BTCS.FloatSetting("Blue", byte(TimerColorBSlider.Value));
				break;
			}
		break;
	}
}

function ResetTimerSettings()
{
	local float MaximumLocationX, MaximumLocationY;

	bInitialized = false;

	BTCS.FloatSetting("TimerScale", 1);
	TimerSizeSlider.SetValue(1);
	TimerSizeSlider.SetText("[100%]");

	MaximumLocationX = (Root.WinWidth / 2) - TimerOffsetX;
	MaximumLocationY = Root.WinHeight - TimerOffsetY;

	BTCS.FloatSetting("X", 0);
	TimerLocationXSlider.SetValue(0);
	TimerLocationXSlider.SetRange(-MaximumLocationX, MaximumLocationX, 0);

	BTCS.FloatSetting("Y", 0);
	TimerLocationYSlider.SetValue(0);
	TimerLocationYSlider.SetRange(0, MaximumLocationY, 0);

	TimerColorRSlider.SetValue(255);
	TimerColorRSlider.SetText("[255]");
	BTCS.FloatSetting("Red", 255);

	TimerColorGSlider.SetValue(88);
	TimerColorGSlider.SetText("[88]");
	BTCS.FloatSetting("Green", 88);

	TimerColorBSlider.SetValue(0);
	TimerColorBSlider.SetText("[0]");
	BTCS.FloatSetting("Blue", 0);

	bInitialized = true;
}

function SetTimerLocationSliders()
{
	local float Xcalc, YCalc, MaximumLocationX, MaximumLocationY;

	MaximumLocationX = (Root.WinWidth / 2) - (TimerOffsetX * TimerSizeSlider.Value);
	MaximumLocationY = Root.WinHeight - (TimerOffsetY * TimerSizeSlider.Value);

	Xcalc = MaximumLocationX * ((TimerLocationXSlider.Value / (TimerLocationXSlider.MaxValue * 2)) * 2);
	YCalc = MaximumLocationY * (TimerLocationYSlider.Value / TimerLocationYSlider.MaxValue);

	TimerLocationXSlider.SetRange(-MaximumLocationX, MaximumLocationX, 0);
	TimerLocationYSlider.SetRange(0, MaximumLocationY, 0);

	BTCS.FloatSetting("X", int(Xcalc));
	TimerLocationXSlider.SetValue(Xcalc);

	BTCS.FloatSetting("Y", int(YCalc));
	TimerLocationYSlider.SetValue(YCalc);
}

defaultproperties
{
	TimerOffsetX=102
	TimerOffsetY=44
	ControlOffset=8
	ControlOffsetSpace=22
	Basecolor=(R=0,G=0,B=0)
}