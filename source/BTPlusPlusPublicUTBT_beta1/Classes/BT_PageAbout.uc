//=============================================================================
// BT_PageAbout made by OwYeaW
//=============================================================================
class BT_PageAbout expands UWindowPageWindow;
//-----------------------------------------------------------------------------
#exec TEXTURE IMPORT NAME=Discord_logo		FILE=Textures\Discord.pcx FLAGS=2 MIPS=ON
//-----------------------------------------------------------------------------
var		Color						Basecolor;
var		bool						bInitialized;
//-----------------------------------------------------------------------------
//	objects
//-----------------------------------------------------------------------------
var		BT_PlayerModelWindow		FlagMeshes;
var		UWindowLabelControl			TitleLabel;
var		UWindowLabelControl			Text1Label;
var		UWindowLabelControl			Text2Label;
var		UWindowLabelControl			Text3Label;
var		UWindowLabelControl			Text4Label;
var		UWindowLabelControl			Text5Label;
var		BT_HyperlinkLabel			Text6Label;
//-----------------------------------------------------------------------------
var float ControlOffset, ControlOffsetSpace;
//-----------------------------------------------------------------------------
function Created()
{
	local int ControlWidth, ControlLeft, ControlRight;
	local int CenterWidth, CenterPos, splitWinWidth, splitCenterWidth;

	Super.Created();

	splitWinWidth = WinWidth/2;
	ControlWidth = splitWinWidth/2.5;
	ControlLeft = (splitWinWidth/2 - ControlWidth)/2;
	ControlRight = splitWinWidth/2 + ControlLeft;

	CenterWidth = (splitWinWidth/4)*3;
	CenterPos = (splitWinWidth - CenterWidth)/2;

	//	FlagMeshes
	FlagMeshes = BT_PlayerModelWindow(CreateWindow(Class'BT_PlayerModelWindow', splitWinWidth, 0, splitWinWidth, WinHeight));

	//	TitleLabel
	TitleLabel = UWindowLabelControl(CreateControl(class'UWindowLabelControl', CenterPos+40, ControlOffset+2, CenterWidth, 1));
	TitleLabel.SetText("UTBT");
	TitleLabel.SetFont(F_Large);
	TitleLabel.SetTextColor(Basecolor);

	ControlOffset += ControlOffsetSpace;
	ControlOffset += 12;

	//	XXXXXXXXXXXXXXXXXXX
	Text1Label = UWindowLabelControl(CreateControl(class'UWindowLabelControl', CenterPos, ControlOffset+2, CenterWidth, 1));
	Text1Label.SetText("BT++ UTBT Public Edition 1.0");
	Text1Label.SetFont(F_Normal);
	Text1Label.SetTextColor(Basecolor);

	ControlOffset += ControlOffsetSpace;
	ControlOffset += 8;

	//	XXXXXXXXXXXXXXXXXXX
	Text2Label = UWindowLabelControl(CreateControl(class'UWindowLabelControl', CenterPos-16, ControlOffset+2, CenterWidth, 1));
	Text2Label.SetText("This BT mod is meant as a Placeholder");
	Text2Label.SetFont(F_Normal);
	Text2Label.SetTextColor(Basecolor);
	Text2Label.WinWidth = 180;

	ControlOffset += 16;

	//	XXXXXXXXXXXXXXXXXXX
	Text3Label = UWindowLabelControl(CreateControl(class'UWindowLabelControl', CenterPos, ControlOffset+2, CenterWidth, 1));
	Text3Label.SetText("A new BT mod is in the works!");
	Text3Label.SetFont(F_Normal);
	Text3Label.SetTextColor(Basecolor);

	ControlOffset += ControlOffsetSpace;
	ControlOffset += 4;

	//	XXXXXXXXXXXXXXXXXXX
	Text4Label = UWindowLabelControl(CreateControl(class'UWindowLabelControl', CenterPos-4, ControlOffset+2, CenterWidth, 1));
	Text4Label.SetText("New Rush servers & Public servers");
	Text4Label.SetFont(F_Normal);
	Text4Label.SetTextColor(Basecolor);
	Text4Label.WinWidth = 180;

	ControlOffset += 16;

	//	XXXXXXXXXXXXXXXXXXX
	Text5Label = UWindowLabelControl(CreateControl(class'UWindowLabelControl', CenterPos+40, ControlOffset+2, CenterWidth, 1));
	Text5Label.SetText("Coming soon!");
	Text5Label.SetFont(F_Normal);
	Text5Label.SetTextColor(Basecolor);

	ControlOffset += ControlOffsetSpace;
	ControlOffset += 8;

	//	XXXXXXXXXXXXXXXXXXX
	Text6Label = BT_HyperlinkLabel(CreateControl(class'BT_HyperlinkLabel', CenterPos+20, ControlOffset+2, CenterWidth, 1));
	Text6Label.SetText("Join us: www.UTBT.net");
	Text6Label.SetFont(F_Normal);
	Text6Label.SetTextColor(Basecolor);
	Text6Label.WinWidth = 110;
}

function Paint(Canvas C, float MouseX, float MouseY)
{
	Super.Paint(C,MouseX,MouseY);
	DrawStretchedTexture(C, 12, ControlOffset-4, 28, 28, Texture'Discord_logo');
}

defaultproperties
{
	ControlOffset=12.000000
	ControlOffsetSpace=20
	Basecolor=(R=0,G=0,B=0)
}