/*
	Author: Terra

	Params: (all optional, standard: [0,{},{},true])
	1: seconds between execution of script and search of display (uisleep)
	2: Command which is executed beforehand
	3: Command which is executed after the script
	4: Exclude standard displays (Map, Mission display, Editor display) or your own displays

	Returns:
	List of displays, systemchat

	Example:
		0 = [] execVM "iddFinder.sqf";
		0 = [5, {hint "start"}, {hint "end"}, false] execVM "iddFinder.sqf";

*/

params [
	["_timer", 0, [123]],
	["_preCommand", {},[{}]],
	["_postCommand", {},[{}]],
	["_exclude", true, [true, []]]
];
disableSerialization;
call _preCommand;
_displayArray = [];
uisleep _timer;
_displayArray = allDisplays;
if (typeName _exclude == typeName true) then {
	if (_exclude) then {
		_displayArray = _displayArray - [findDisplay 0, findDisplay 12, findDisplay 46, findDisplay 313];
	};
} else {
	_displayArray = _displayArray - _exclude;
};
systemChat str _displayArray;
call _postCommand;