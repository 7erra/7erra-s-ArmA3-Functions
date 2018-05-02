params ["_types"];
_centerPos = [worldSize/2,worldSize/2,0];
if !(_types isEqualType []) then {_types = [_types]};
{
	_curType = _x;
	_buildings = _centerPos nearObjects [_curType, worldSize*1.5];
	{
		_mrk = createMarker [str _x, getPos _x];
		_mrk setMarkerShape "ICON";
		_mrk setMarkerType "mil_dot";
		_mrk setMarkerText _curType;
	} forEach _buildings;
} forEach _types;