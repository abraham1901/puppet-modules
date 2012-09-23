define ucarp::host($node_id, $interface, $vip_address, $password="", $ensure=present ) {

	# Enabled or disabled ?
	if($ensure == present) {
		$present = file
	} else {
		$present = absent
	}
	
	# Get IP address from facter
	$ip_address = inline_template("<%= ipaddress_${interface} %>")

	# autogenerate password if it's not specified
	if ($password == "") {
		$node_pass = md5("${vip_address}${node_id}")
	} else {
		$node_pass = $password
	}

	notify { "Node password ${node_pass}": }

	file { "/etc/ucarp/vip-${node_id}.conf":
		ensure => $present,
		content => template("ucarp/vp-00x.erb"),
		mode => 600,
		owner => "root",
		group => "root",
		require => File["/etc/ucarp/vip-common.conf"],
		notify => Service["ucarp"],
	}

}
