/*
	Author: 7erra
	Description:
		Get the absolute bounding box real of an object

	Params:
		1 - OBJECT: Object of which the bounding box should be returned
		or
		1 - ARRAY: Bounding box of an object in format [[x1,y1,z1],[x2,y2,z2]]

	Returns: ARRAY
*/
params ["_bbr"];
if (typeName _bbr == "OBJECT") then {_bbr = boundingBoxReal _bbr};
_bbr = _bbr apply {_x apply {abs _x}};
_absBBR = (_bbr select 0) vectorAdd (_bbr select 1);
_absBBR