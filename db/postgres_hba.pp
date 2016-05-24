# Re-initialize the postgres instance with access rules
class { 'postgresql::globals':
	postgis_version =>'2.1',
}->
class { 'postgresql::server':
	ip_mask_allow_all_users    => '*',
	listen_addresses           => '*',
	postgres_password          => 'sos2016',
	pg_hba_conf_defaults			 => false
}
class { 'postgresql::server::postgis': }

# Create a rule to allow the postgres user access to all databases locally
postgresql::server::pg_hba_rule { 'allow all directly local access':
	description => "allow all directly local access",
	type        => 'local',
	database    => 'all',
	user        => 'postgres',
	auth_method => 'trust',
}

# Create a rule to allow all users access to the postgres database with a user and password locally
postgresql::server::pg_hba_rule { 'allow localhost to access app database':
	description => "Open up PostgreSQL for access from localhost",
	type        => 'host',
	database    => 'postgres',
	user        => 'all',
	address     => '127.0.0.1/32',
	auth_method => 'md5',
}

# Create a rule to allow the postgres user access to the postgres database with a user and password on the designated IP address
postgresql::server::pg_hba_rule { 'allow application network to access app database':
	description => "Open up PostgreSQL for access from 192.168.56.0/24",
	type        => 'host',
	database    => 'postgres',
	user        => 'postgres',
	address     => '192.168.20.0/24',
	auth_method => 'md5',
}
