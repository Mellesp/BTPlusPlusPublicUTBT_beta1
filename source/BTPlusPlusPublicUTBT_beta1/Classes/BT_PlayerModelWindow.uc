//=============================================================================
// BT_PlayerModelWindow made by OwYeaW
//=============================================================================
class BT_PlayerModelWindow extends UMenuDialogClientWindow;

#exec TEXTURE IMPORT NAME=UTBT_Flag_blue2		FILE=Textures\JpflagBUTBT_wood.bmp
#exec TEXTURE IMPORT NAME=UTBT_Flag_red2		FILE=Textures\JpflagRUTBT_wood.bmp

var UWindowButton LeftButton, RightButton;
var MeshActor Flag1;
var MeshActor Flag2;

var rotator ViewRotatorFlag1, ViewRotatorFlag2;
var bool bRotate;

function Created()
{
	Super.Created();

	Flag1 = GetEntryLevel().Spawn(class'MeshActor', GetEntryLevel());
	Flag1.Mesh = LodMesh'Botpack.newflag';
	Flag1.DrawScale = 0.05;
	Flag1.Skin = texture'UTBT_Flag_red2';
	Flag1.LoopAnim('newflag');
	ViewRotatorFlag1 = rot(-5120, 32768, 2560);

	Flag2 = GetEntryLevel().Spawn(class'MeshActor', GetEntryLevel());
	Flag2.Mesh = LodMesh'Botpack.newflag';
	Flag2.DrawScale = 0.05;
	Flag2.Skin = texture'UTBT_Flag_blue2';
	Flag2.LoopAnim('newflag');
	ViewRotatorFlag2 = rot(-5120, 0, 2560);

	LeftButton = UWindowButton(CreateControl(class'UWindowButton', 0, 0, WinWidth/2, WinHeight));
	LeftButton.bIgnoreLDoubleclick = True;

	RightButton = UWindowButton(CreateControl(class'UWindowButton', WinWidth/2, 0, WinWidth/2, WinHeight));
	RightButton.bIgnoreLDoubleclick = True;
}

function BeforePaint(Canvas C, float X, float Y)
{
	if(LeftButton.bMouseDown)
	{
		ViewRotatorFlag1.Yaw += 512;
		ViewRotatorFlag2.Yaw += 512;
	}
	else if(RightButton.bMouseDown)
	{
		ViewRotatorFlag1.Yaw -= 512;
		ViewRotatorFlag2.Yaw -= 512;
	}
}

function Paint(Canvas C, float X, float Y) 
{
	local float OldFov;

	if(Flag1 != None)
	{
		OldFov = GetPlayerOwner().FOVAngle;
		GetPlayerOwner().SetFOVAngle(30);
		DrawClippedActor( C, WinWidth/2, WinHeight/2, Flag1, False, ViewRotatorFlag1, vect(0, 0, 0) );
		GetPlayerOwner().SetFOVAngle(OldFov);
	}
	if(Flag2 != None)
	{
		OldFov = GetPlayerOwner().FOVAngle;
		GetPlayerOwner().SetFOVAngle(30);
		DrawClippedActor( C, WinWidth/2, WinHeight/2, Flag2, False, ViewRotatorFlag2, vect(0, 0, 0) );
		GetPlayerOwner().SetFOVAngle(OldFov);
	}
}

function Tick(float Delta)
{
	if(bRotate)
	{
		ViewRotatorFlag1.Yaw += 64;
		ViewRotatorFlag2.Yaw += 64;
	}
}

function Close(optional bool bByParent)
{
	Super.Close(bByParent);
	if(Flag1 != None)
	{
		Flag1.Destroy();
		Flag1 = None;
	}
	if(Flag2 != None)
	{
		Flag2.Destroy();
		Flag2 = None;
	}
}

defaultproperties
{
	bRotate=true
}