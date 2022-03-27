//=============================================================================
// UTBT_Flag made by OwYeaW
//=============================================================================
class UTBT_Flag extends CTFFlag;

function SendHome()
{
	local Pawn aPawn;

	if(Holder != None)
	{
		Holder.AmbientGlow = Holder.Default.AmbientGlow;
		Holder.LightType = LT_None;
		Holder.PlayerReplicationInfo.HasFlag = None;
		if(Holder.Inventory != None)
			Holder.Inventory.SetOwnerDisplay();
		Holder = None;
	}
	GotoState('Home');
	SetPhysics(PHYS_None);
	bCollideWorld = false;
	SetLocation(HomeBase.Location);
	SetRotation(HomeBase.Rotation);
	if(HomeBase.Base != None)
		SetBase(HomeBase.Base);
	else
		SetBase(None);
	SetCollision(true, false, false);
	for(aPawn = Level.PawnList; aPawn != None; aPawn = aPawn.nextPawn)
		if(aPawn.MoveTarget == self)
			aPawn.MoveTimer = -1.0;

	// stijn: wasn't getting reset previously...
	LightType = LT_Steady;
}

function Drop(vector newVel)
{
	BroadcastLocalizedMessage(class'CTFMessage', 2, Holder.PlayerReplicationInfo, None, CTFGame(Level.Game).Teams[Team]);
	RemoveFlag();
}

function RemoveFlag()
{
	local Pawn aPawn;

	if(Holder != None)
	{
		Holder.AmbientGlow = Holder.Default.AmbientGlow;
		Holder.LightType = LT_None;
		Holder.PlayerReplicationInfo.HasFlag = None;
		if(Holder.Inventory != None)
			Holder.Inventory.SetOwnerDisplay();
		Holder = None;
	}
	Destroy();
}

state Held
{
	event FellOutOfWorld()
	{
	}

	function Timer()
	{
		if(Holder == None)
			RemoveFlag();
	}

	function BeginState()
	{
		bHeld = true;
		bCollideWorld = false;
		bKnownLocation = false;
		HomeBase.PlayAlarm();
		SetPhysics(PHYS_None);
		SetCollision(false, false, false);
		SetTimer(10.0, true);
	}

	function EndState()
	{
		bHeld = false;
	}
}	


auto state Home
{
	function Timer()
	{
		if(VSize(Location - HomeBase.Location) > 10)
		{
			SendHome();
		}
	}

	function Touch(Actor Other)
	{
		local UTBT_Flag aFlag, newFlag;
		local TournamentPlayer aTPawn;

		aTPawn = TournamentPlayer(Other);
		if(aTPawn != None && aTPawn.bIsPlayer && aTPawn.Health > 0)
		{
			// check if scored capture
			if(aTPawn.PlayerReplicationInfo.Team == Team)
			{
				if(aTPawn.PlayerReplicationInfo.HasFlag != None)
				{
					//Score!
					aFlag = UTBT_Flag(aTPawn.PlayerReplicationInfo.HasFlag);
					CTFGame(Level.Game).ScoreFlag(aTPawn, aFlag);
					aFlag.SendHome();
				}
			}
			else if(aTPawn.PlayerReplicationInfo.HasFlag == None)
			{
				if(aTPawn.AttitudeToPlayer == ATTITUDE_Follow)
				{
					BroadcastMessage(aTPawn.PlayerReplicationInfo.PlayerName $ " has reached the flag with Checkpoints!", true, 'CriticalEvent');
				}
				else
				{
					newFlag = spawn(class'UTBT_Flag');
					newFlag.Skin		= Skin;
					newFlag.Team		= Team;
					newFlag.HomeBase	= HomeBase;
					newFlag.Holder		= aTPawn;
					newFlag.LightHue	= LightHue;
					
					newFlag.GoToState('Held');
					aTPawn.MoveTimer = -1;
					aTPawn.PlayerReplicationInfo.HasFlag = newFlag;
					aTPawn.MakeNoise(2.0);
					newFlag.SetHolderLighting();

					if ( aTPawn.bAutoTaunt )
						aTPawn.SendTeamMessage(None, 'OTHER', 2, 10);

					if (Level.Game.WorldLog != None)
						Level.Game.WorldLog.LogSpecialEvent("flag_taken", aTPawn.PlayerReplicationInfo.PlayerID, CTFGame(Level.Game).Teams[Team].TeamIndex);
					if (Level.Game.LocalLog != None)
						Level.Game.LocalLog.LogSpecialEvent("flag_taken", aTPawn.PlayerReplicationInfo.PlayerID, CTFGame(Level.Game).Teams[Team].TeamIndex);
					BroadcastLocalizedMessage( class'CTFMessage', 6, aTPawn.PlayerReplicationInfo, None, CTFGame(Level.Game).Teams[Team] );
				}
			}
		}
	}

	function EndState()
	{
		bHome = false;
		SetTimer(0.0, false);
	}
}