/*
	Author: Terra

	Description:
	Execute the script and wait for the message "IDC finder initialized on displays:
	[display array]". Then you can hover above any button and see the IDC of the control.
	The tooltip might not be accurate everytime because of control groups. Systemchat
	 output is more reliable.

	Parameters:
	0 - Delay between execution of the function and activation (NUMBER)
		Default: 5
	1 - exclude displays. (ARRAY OF IDDs)
		Default: Standard displays 0, 46 (Game display), 12 (Map), 49 (Escape menu)

	Example: [] spawn TER_fnc_findIDC;
*/
disableSerialization;
params [
	["_delay",0,[123]],
	["_exclude",[0,12,46,49],[[]]]
];
_exclude = _exclude apply {findDisplay _x};
uisleep _delay;
_displays = allDisplays -_exclude;
{
	{
		_x ctrlAddEventHandler ["MouseEnter",{systemChat format ["IDC: %1",ctrlIDC (_this select 0)]}];
		_x ctrlSetTooltip format ["IDC: %1",ctrlIDC _x];
	} forEach allControls _x;
} forEach _displays;
systemChat format ["IDC finder initialized on displays: %1",_displays];