// 23  3 2025 13:50
//: Build the fibonacci series using recursion.
f = { | n = 1, nums = #[1, 1] |
	if (n < 3) {
		nums.reverse; // return initial array in reverse order
	}{
		thisFunction.(n - 1, (nums[0] + nums[1]).asArray ++ nums)
	}
}
//:
f.(15)
//:Variant accumulating arrays - for hemachandra.
f = { | n = 1, nums = #[1, 1] |
	if (n < 3) {
		nums
	}{
		thisFunction.(n - 1, (nums.copy) add: nums)
	}
}
//:
f.(5)
