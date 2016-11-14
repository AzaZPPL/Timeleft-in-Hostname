#pragma semicolon 1

#include <sourcemod>

public Plugin myinfo = 
{
	name = "Timeleft-in-Hostname", 
	author = "AzaZPPL", 
	description = "Timeleft in server title or hostname", 
	version = "1.3", 
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
	gCV_UpdateTime = CreateConVar("tih_update", "5.0", "Updates the hostname every x.x seconds.", 0, true, 1.0);
	
	AutoExecConfig(true);
}

public void OnMapStart()
{
	// Check if its empty.
	if(!gC_OldHostname[0]) {
		CreateTimer(1.0, GetHostname);
	}
}

public Action SetHostnameTime(Handle h_timer)
{
	GetMapTimeLeft(gI_Timeleft);
	
	// Check if the time isnt going into minus. This can happen when the map has yet to change and the timeleft keeps counting down
	if (gI_Timeleft <= -1) {
		gC_Minutes = "00";
		gC_Seconds = "00";
	} else {
		// Set time. If time is less than 10 add a 0.
		FormatEx(gC_Minutes, sizeof(gC_Minutes), "%s%i", ((gI_Timeleft / 60) < 10)? "0" : "", gI_Timeleft / 60);
		FormatEx(gC_Seconds, sizeof(gC_Seconds), "%s%i", ((gI_Timeleft % 60) < 10)? "0" : "", gI_Timeleft % 60);
	}
	

	
	// Check if {{timeleft}} is filled in and replace it with time
	if (StrContains(gC_OldHostname, "{{timeleft}}") >= 0) {
		char C_Time[10];
		
		FormatEx(C_Time, sizeof(C_Time), "%s:%s", gC_Minutes, gC_Seconds);
		gC_NewHostname = gC_OldHostname;
		
		ReplaceString(gC_NewHostname, sizeof(gC_NewHostname), "{{timeleft}}", C_Time);
	} else {
		// Making the new hostname
		FormatEx(gC_NewHostname, sizeof(gC_NewHostname), "%s %s:%s", gC_OldHostname, gC_Minutes, gC_Seconds);
	}
	
	// Set the new hostname
	gCV_Hostname.SetString(gC_NewHostname);
	
	return Plugin_Continue;
}

public Action GetHostname (Handle h_timer)
{
	gCV_Hostname = FindConVar("hostname");
	gCV_Hostname.GetString(gC_OldHostname, 250);
	
	CreateTimer(gCV_UpdateTime.FloatValue, SetHostnameTime, INVALID_HANDLE, TIMER_REPEAT);
}

public void OnMapEnd()
{
	// Set the old hostname without anything in the title.
	gCV_Hostname.SetString(gC_OldHostname);
	gCV_Hostname.Close();
}

public void OnPluginEnd()
{
	gCV_Hostname.SetString(gC_OldHostname);
	gCV_Hostname.Close();
} 