function createUUID() {
	var dg = new Date(1582, 10, 15, 0, 0, 0, 0);
	var dc = new Date();
	var t = dc.getTime() - dg.getTime();
	// var h = '-';
	var tl = _getIntegerBits(t, 0, 31);
	var tm = _getIntegerBits(t, 32, 47);
	var thv = _getIntegerBits(t, 48, 59) + '1'; // version 1,
	// security
	// version is 2
	var csar = _getIntegerBits(_rand(4095), 0, 7);
	var csl = _getIntegerBits(_rand(4095), 0, 7);

	var n = _getIntegerBits(_rand(8191), 0, 7)
			+ _getIntegerBits(_rand(8191), 8, 15)
			+ _getIntegerBits(_rand(8191), 0, 7)
			+ _getIntegerBits(_rand(8191), 8, 15)
			+ _getIntegerBits(_rand(8191), 0, 15); // this
	// last
	// number
	// is two octets
	// long
	// return tl + h + tm + h + thv + h + csar + csl + h + n;
	return tl + tm + thv + csar + csl + n;
};

function _getIntegerBits(val, start, end) {
	var base16 = _returnBase(val, 16);
	var quadArray = [];
	var quadString = '';
	var i = 0;
	for (i = 0; i < base16.length; i++) {
		quadArray.push(base16.substring(i, i + 1));
	}
	for (i = Math.floor(start / 4); i <= Math.floor(end / 4); i++) {
		if (!quadArray[i] || quadArray[i] === '')
			quadString += '0';
		else
			quadString += quadArray[i];
	}
	return quadString;
};

function _returnBase(number, base) {
	return (number).toString(base).toUpperCase();
};

function _rand(max) {
	return Math.floor(Math.random() * (max + 1));
};
