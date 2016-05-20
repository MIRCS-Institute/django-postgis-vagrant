# Default a postgress instance with postgis and a default password
class { 'postgresql::globals':
	postgis_version =>'2.1',
}->
class { 'postgresql::server':
	ip_mask_allow_all_users    => '*',
	listen_addresses           => '*',
	postgres_password          => 'sos2016',
}
class { 'postgresql::server::postgis': }
