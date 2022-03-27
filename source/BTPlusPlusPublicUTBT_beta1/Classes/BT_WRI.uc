//=============================================================================
// BT_WRI made by OwYeaW
//=============================================================================
class BT_WRI expands WRI;
//-----------------------------------------------------------------------------
var		ClientData			Config;
var		BTClientSettings	BTCS;
//-----------------------------------------------------------------------------
replication
{
	reliable if(Role == ROLE_Authority)
		BTCS;

	reliable if(Role < ROLE_Authority)
		AntiBoost;
}

simulated function bool SetupWindow()
{
	local ClientData C;

	foreach Level.AllActors(class'ClientData', C)
	{
		if(C.Owner == Owner)
		{
			Config = C;
			break;
		}
	}

	if(Super.SetupWindow())
		SetTimer(0.01, false);
	else
		log("Super.SetupWindow() = false");
}

simulated event Timer()
{
	BT_Window(TheWindow).TabWindow.SpectatorPage.BTCS = BTCS;
	BT_Window(TheWindow).TabWindow.SpectatorPage.LoadSettings();

	BT_Window(TheWindow).TabWindow.TimerPage.BTCS = BTCS;
	BT_Window(TheWindow).TabWindow.TimerPage.LoadSettings();

	BT_Window(TheWindow).TabWindow.GeneralPage.BTWRI = Self;
	BT_Window(TheWindow).TabWindow.GeneralPage.BTCS = BTCS;
	BT_Window(TheWindow).TabWindow.GeneralPage.Config = Config;
	BT_Window(TheWindow).TabWindow.GeneralPage.LoadSettings();
}

simulated function AntiBoost(ClientData C, bool bValue)
{
	C.SetAntiBoost(bValue);
}

defaultproperties
{
    WindowClass=Class'BT_Window'
    WinLeft=50
    WinTop=30
    WinWidth=400
    WinHeight=267
}