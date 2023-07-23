node slave1.puppet {
	include role::slave1_machine
}

node slave2.puppet {
	include role::slave2_machine
}

node master.puppet {
	include role::master_machine
}