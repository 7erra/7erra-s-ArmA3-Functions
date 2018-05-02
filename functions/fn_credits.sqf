/*
	Author: Terra

	Description:
	Credit screen

	Parameter(s):
	0: Structured text (STRING)
	1 (optional): Speed multiplier, determines how fast the text will scroll through (NUMBER)
		Default: 1

	Example:
	_text = "";
	for "_i" from 1 to 10 do {
		_text = _text +format ["Line %1<br/>",_i];
	};
	[_text] call TER_fnc_credits;
*/
disableserialization;
params [
	"_text",
	["_speedMultiplier",1]
];

// Create cutRsc
("TER_creditsLayer" call BIS_fnc_rscLayer) cutrsc ["rscDynamicText","BLACK FADED",5];
_display = uinamespace getvariable "BIS_dynamicText";
_control = _display displayctrl 9999;
_control ctrlSetStructuredText parseText "Line 0";
_oneLine = ctrlTextHeight _control;
// Set text and position
_text = parseText format ["<t align='center'>%1</t>",_text];
_control ctrlSetStructuredText _text;
_tHeight = ctrlTextHeight _control;
_control ctrlSetPosition [
	0 * safezoneW + safezoneX,
	(1 * safezoneH + safezoneY)+(3*_oneLine),
	1 * safezoneW,
	_tHeight
];
_control ctrlCommit 0;
// Move control
_control ctrlSetPosition [
	0 * safezoneW + safezoneX,
	-_tHeight + (0 * safezoneH + safezoneY)-(3*_oneLine),
	1 * safezoneW,
	_tHeight
];
_addSleep = safeZoneH/_oneLine;
_commitTime = ((_tHeight/_oneLine)+_addSleep)/_speedMultiplier;
_control ctrlCommit _commitTime;
waitUntil {ctrlCommitted _control};
"TER_creditsLayer" cuttext ["","plain"];