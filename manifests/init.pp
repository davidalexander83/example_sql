# NOT FOR PRODUCTION USE
#
# Example SQL server installation and instantiation
#
# C:\ProgramData\Puppetlabs\code\environments\production\modules\example_sql\manifests\init.pp
#
# puppet apply <modulepath>\modules\example_sql\examples\init.pp


class example_sql {
  #file { 'C:/sql_server_2012':
  #  ensure => directory,
  #}
  #include '::archive'
  #archive { 'SQLInstall':
  #  path         => 'C:\\Windows\\Temp\\sql_server_2012.zip',
  #  source       => 'https://s3-ap-southeast-2.amazonaws.com/da-sydney/sql_server_2012.zip',
  #  extract      => true,
  #  extract_path => 'C:\\sql_server_2012\\',
  #  creates      => 'C:\\sql_server_2012\\setup.exe',
  #}->

  # Copy the contents of the SQL Server 2012 iso to C:\sql_server_2012

  sqlserver_instance { 'MSSQLSERVER':
    source                => 'C:/sql_server_2012',
    features              => ['SQL'],
    security_mode         => 'SQL',
    sa_pwd                => 'p@ssw0rd!!',
    sql_sysadmin_accounts => ['administrator'],
    install_switches      => {
      'TCPENABLED'          => 1,
      'SQLBACKUPDIR'        => 'C:\\MSSQLSERVER\\backupdir',
      'SQLTEMPDBDIR'        => 'C:\\MSSQLSERVER\\tempdbdir',
      'INSTALLSQLDATADIR'   => 'C:\\MSSQLSERVER\\datadir',
      'INSTANCEDIR'         => 'C:\\Program Files\\Microsoft SQL Server',
      'INSTALLSHAREDDIR'    => 'C:\\Program Files\\Microsoft SQL Server',
      'INSTALLSHAREDWOWDIR' => 'C:\\Program Files (x86)\\Microsoft SQL Server',
    },
    notify                => Reboot['after'],
  }->
  sqlserver_features { 'Generic Features':
    source   => 'C:/sql_server_2012',
    features => ['ADV_SSMS', 'SSMS'],
    notify   => Reboot['after'],
  }
  reboot { 'after':
    apply => finished,
  }
}
