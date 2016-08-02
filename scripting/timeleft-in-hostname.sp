#pragma semicolon 1

#include <sourcemod>

public Plugin myinfo = 
{
	name = "Timeleft-in-Hostname", 
	author = "AzaZPPL", 
	description = "Timeleft in server title or hostname", 
	version = "1.0", 
	url = "https://github.com/AzaZPPL/Timeleft-in-Hostname"
};

ConVar gCV_Hostname;
ConVar gCV_UpdateTime;

char gC_OldHostname[250];
char gC_NewHostname[250];

int gI_Timeleft;
char gC_Minutes[5];
char gC_Seconds[5];

public void OnPluginStart()
{
	gCV_Hostname = FindConVar("hostname");
	
	gCV_UpdateTime = CreateConVar("tih_update", "5.0", "Value: Float\nMin: 1.0\nUpdates the hostname every x.x seconds.", 0, true, 1.0);
	
	AutoExecConfig(true);
}

public void OnMapStart()
{
	GetConVarString(gCV_Hostname, gC_OldHostname, 250);
	
	CreateTimer(gCV_UpdateTime.FloatValue, SetHostnameTime, INVALID_HANDLE, TIMER_REPEAT);
}

public Action SetHostnameTime(Handle h_timer)
{
	GetMapTimeLeft(gI_Timeleft);
	
	// Check if the time isnt going into minus. This can happen when the map has yet to change and the timeleft keeps counting down
	if (gI_Timeleft <= -1) {
		return Plugin_Handled;
	}
	
	// Check if the time is less than 10. If so add a 0 to the time strings. Else just set the times
	if ((gI_Timeleft / 60) < 10)
		Format(gC_Minutes, sizeof(gC_Minutes), "0%i", gI_Timeleft / 60);
	else
		Format(gC_Minutes, sizeof(gC_Minutes), "%i", gI_Timeleft / 60);
	
	if ((gI_Timeleft % 60) < 10)
		Format(gC_Seconds, sizeof(gC_Seconds), "0%i", gI_Timeleft % 60);
	else
		Format(gC_Seconds, sizeof(gC_Seconds), "%i", gI_Timeleft % 60);
	
	// Check if {{timeleft}} is filled in and replace it with time
	if (StrContains(gC_OldHostname, "{{timeleft}}") > 0) {
		char C_Time[10];
		
		Format(C_Time, sizeof(C_Time), "%s:%s", gC_Minutes, gC_Seconds);
		gC_NewHostname = gC_OldHostname;
		
		ReplaceString(gC_NewHostname, sizeof(gC_NewHostname), "{{timeleft}}", C_Time);
	} else {
		// Making the new hostname
		Format(gC_NewHostname, sizeof(gC_NewHostname), "%s %s:%s", gC_OldHostname, gC_Minutes, gC_Seconds);
	}
	
	// Set the new hostname
	gCV_Hostname.SetString(gC_NewHostname);
	
	return Plugin_Continue;
}

public void OnMapEnd()
{
	// Set the old hostname without anything in the title.
	gCV_Hostname.SetString(gC_OldHostname);
	gCV_Hostname.Close();
}

public void OnPluginEnd()
{
	// Set the old hostname without anything in the title.
	gCV_Hostname.SetString(gC_OldHostname);
	gCV_Hostname.Close();
} 