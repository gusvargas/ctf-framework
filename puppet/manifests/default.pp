include application

$ROOT_PASSWORD = 'g0t_r00t'
$ADMIN_PASSWORD = 'qwer1234'
$USER_PASSWORD = ''

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
  user      => 'admin',
  password  => 'qwer1234',
  host      => 'localhost',
  grant     => ['SELECT', 'UPDATE', 'INSERT', 'DELETE'],
}

exec { 'create_tables':
  command   => "mysql -u root --password='${ROOT_PASSWORD}' < /vagrant/schema.sql",
  path      => '/usr/bin/',
  require   => Mysql_database['ctf'],
}
