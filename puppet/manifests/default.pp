include application

$ROOT_PASSWORD = 'g0t_r00t'
$CTF_PASSWORD = 'qwer1234'

class { 'mysql::server':
  root_password           => $ROOT_PASSWORD,
  remove_default_accounts => true,
  override_options        => {
    'mysqld' => {
      'bind_address' => '0.0.0.0'
    }
  }
}

mysql::db { 'ctf':
  user      => 'ctf',
  password  => $CTF_PASSWORD,
  host      => 'localhost',
  grant     => ['SELECT', 'UPDATE', 'INSERT', 'DELETE'],
}

exec { 'create-tables':
  command   => "mysql -u root --password='${ROOT_PASSWORD}' < /vagrant/schema.sql",
  path      => '/usr/bin/',
  require   => Mysql_database['ctf'],
}

exec { 'create-admin':
  command   => "mysql -u root --password='${ROOT_PASSWORD}' < /vagrant/admin.sql",
  path      => '/usr/bin/',
  require   => Exec['create-tables'],
}
