/*
	Author: Terra

	Parameters:
		0: Number - Minimum
		1: Number - Middle
		2: Number - Maximum
		(Optional) 3: Number - Runs, higher numbers take longer
			*Default: 100000
		(Optional) 4: Number - Return specific element
			*Default: -1 (return all)
		(Optional) 5: String - Round method, can be "round","ceil","floor"
			*Default: "round"

	Return:
	Array of arrays OR with param 4: array
		1: element value
		2: amounts of hits
		3: percentage

	Example:
		0 = [0,5,10] execVM "fn_testRandom.sqf";
		Return:
			[[0,7,0.007],[1,579,0.579],...]
			[1,579,0.579]: [Element value, occurences, %]
*/

params [ "_min","_mid","_max", ["_runs",10^5, [123]], ["_spec",-1,[123]], ["_mode","round", ["string"]]];
private ["_random"];

_minMidMaxArr = [_min,_mid,_max];

_countArray = [];
for "_i" from 1 to _runs do {
	switch _mode do {
		case "round": {_random = round random _minMidMaxArr};
		case "ceil": {_random = ceil random _minMidMaxArr};
		case "floor": {_random = floor random _minMidMaxArr};
	};
	_countArray pushBack _random;
};

_outputArray = [];
_biggest = selectMax _minMidMaxArr;
_smallest = selectMin _minMidMaxArr;
for "_h" from _smallest to _biggest do {
	_count = {_x == _h} count _countArray;
	_outputArray pushBack ([_h,_count, 100*(_count/_runs)]); // Output as [Tested Number, occurences, probability %]
};
if (_spec != -1) exitWith {
	copyToClipboard str _outputArray;
	_output = _outputArray select _spec;
	systemchat str _output;
	_output
};
copyToClipboard str _outputArray;
systemchat str _outputArray;
_outputArray


