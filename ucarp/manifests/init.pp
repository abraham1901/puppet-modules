class ucarp {

	file { "/etc/ucarp/vip-common.conf":
		ensure => file,
		mode => 600,
	}

	service { "ucarp":
		ensure => running,
		enable => true,
	}

}


