/*
	Author: Terra
	Description:
		Replaces the magazine's of a unit with the tracer variant

	Params:
		0 - OBJECT: Unit who will receive tracers

	Return: NONE
*/

params ["_unit"];
_weapons = weapons _unit;

{
	_compMags = getArray (configfile >> "CfgWeapons" >> _x >> "magazines");
	// Determine right tracer color
	_tracerColor = "red";
	switch (side _unit) do
	{
		case east: {_tracerColor = "green"};
		case independent: {_tracerColor = "yellow"};
	};
	// Find correct tracer mag name
	_correctMag = _compMags select {toLower _x find "tracer" > 0};
	if (count _correctMag == 0) exitWith {/*No tracer mags for this weapon*/};
	_correctMag = _compMags select {toLower _x find _tracerColor > 0};
	if (count _correctMag > 0) then {
		_correctMag = _correctMag select 0;
	} else {
		_correctMag = _compMags select {toLower _x find "tracer" > 0};
		_correctMag = _correctMag select {toLower _x find "red" < 0 && toLower _x find "green" < 0 && toLower _x find "yellow" < 0};
		_correctMag = _correctMag select 0;
	};

	// Add magazines and remove non tracer ones
	_currentMags = (magazines _unit) select {_x in _compMags};
	_nonTracerMags = _currentMags select {toLower _x find "tracer" < 0};
	_amount = count _nonTracerMags;
	_tracerMags = _currentMags select {toLower _x find "tracer" > 0};

	{_unit removeMagazines _x} forEach _nonTracerMags;
	_unit addMagazines [_correctMag, _amount];

	switch (_x) do
	{
		case primaryWeapon _unit:
		{
			_unit removePrimaryWeaponItem ((primaryWeaponMagazine _unit) select 0);
			_unit addPrimaryWeaponItem _correctMag;
		};
		case secondaryWeapon _unit:
		{
			_unit removeSecondaryWeaponItem ((secondaryWeaponMagazine _unit) select 0);
			_unit addSecondaryWeaponItem _correctMag;
		};
		case handgunWeapon _unit:
		{
			_unit removeSecondaryWeaponItem ((handgunMagazine _unit) select 0);
			_unit addHandgunItem _correctMag;
		};
		default
		{
			/* maybe lasermarker? */
		};
	};



} forEach _weapons;