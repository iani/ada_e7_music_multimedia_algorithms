//:Simplest example of recursion. Counting.
f = { | n = 1 |
	if (n > 0) {
		postln("Current count:" + n);
		thisFunction.(n - 1);
	}{
		postln("count finished");
	};
};
//:
f.value;
//:
f.(5);
//:Pass a data structure as argument.
g = { | n = 1, counts |
	counts = counts add: n;
	postln("counts are:" + counts);
	if (n > 0) {
		postln("Current count:" + n);
		thisFunction.(n - 1, counts);
	}{
		postln("count finished");
		counts;
	};
};
//:Without postlin
g = { | n = 1, counts |
	if (n > 0) {
		counts = counts add: n;
		thisFunction.(n - 1, counts);
	}{
		counts;
	};
};
//:
g.value;
//:
g.(5);