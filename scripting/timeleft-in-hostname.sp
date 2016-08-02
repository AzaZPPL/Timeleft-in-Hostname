#pragma semicolon 1

#include <sourcemod>

public Plugin myinfo = 
{
	name = "KZC_TimeName",
	author = "AzaZPPL",
	description = "Timeleft in server title for KZ-Climb",
	version = "1.2",
	url = "http://kz-climb.com"
};

Handle h_convHostname;
char c_oldHostname[250];
char c_newHostname[250];
int i_timeleft;
char c_minutes[5];
char c_seconds[5];

public void OnPluginStart()
{
	h_convHostname = FindConVar("hostname");
}

public void OnMapStart()
{
	GetConVarString(h_convHostname, c_oldHostname, 250);
	CreateTimer(1.0, SetHostnameTime, INVALID_HANDLE, TIMER_REPEAT);
}

public Action SetHostnameTime(Handle h_timer)
{
	GetMapTimeLeft(i_timeleft);
	
	// Check if the time isnt going into minus. This can happen when the map has yet to change and the timeleft keeps counting down
	if(i_timeleft <= -1) {
		return Plugin_Handled;
	}
	
	// Set the times
	Format(c_minutes, sizeof(c_minutes), "%i", i_timeleft / 60);
	Format(c_seconds, sizeof(c_seconds), "%i", i_timeleft % 60);
	
	// Check if the time is less than 10. If so add a 0 to the time strings.
	if((i_timeleft / 60) < 10)
		Format(c_minutes, sizeof(c_minutes), "0%i", i_timeleft / 60);
	if((i_timeleft % 60) < 10)
		Format(c_seconds, sizeof(c_seconds), "0%i", i_timeleft % 60);
	
	// Making the new hostname
	Format(c_newHostname, sizeof(c_newHostname), "%s || %s:%s", c_oldHostname, c_minutes, c_seconds);
	
	// Set the new hostname
	SetConVarString(h_convHostname, c_newHostname);
	
	return Plugin_Continue;
}

public void OnMapEnd()
{
	SetConVarString(h_convHostname, c_oldHostname);
	h_convHostname.Close();
}

public void OnPluginEnd()
{
	SetConVarString(h_convHostname, c_oldHostname);
	h_convHostname.Close();
}