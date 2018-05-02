/*
	Author: Terra
	Description:
		Determines wether water is between the two positions. Only takes water in consideration which is deeper than 1.3m (soldiers don't start swimming)
	Params:
		0 - ARRAY: Position 1
		1 - ARRAY: Position 2
		(Optional) 2 - NUMBER: Distance between checks, make smaller to find rivers

	Returns: BOOLEAN
		true - Water found
		false - No water between the two positions
*/
params ["_startPos", "_endPos", ["_step",100,[123]]];
_ret = false;
_distance = _startPos distance2D _endPos;
_relDir = _startPos getDir _endPos;
_nextPos = _startPos;
for "_i" from 0 to _distance step _step do {
	if (getTerrainHeightASL _nextPos < -1.3) exitWith {_ret = true};
	_nextPos = [(_nextPos select 0) +sin _relDir *_step,(_nextPos select 1) +cos _relDir *_step,0];
};
_ret