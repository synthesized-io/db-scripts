$ServerInstance = 'localhost'
  $Database = 'sakila'
  $UserName = 'SA'
  $Password = 'Secret_password_1'
  $dir = $PSScriptRoot
$ConnectionString = "Server=$ServerInstance;Database=$Database;User Id=$UserName;Password=$Password;TrustServerCertificate=True"
New-Item -ItemType Directory -Force -Path $dir\output
  $TargetScripts = @(
    "check_constraints.sql",
    "columns_data_types_basic.sql",
    "columns_data_types.sql",
    "columns.sql",
    "constraints.sql",
    "databases.sql",
    "foreign_keys.sql",
    "indexes_space_stat.sql",
    "indexes.sql"
    "rules.sql",
    "schemas_relations.sql",
    "schemas.sql",
    "table_data_types.sql",
    "tables.sql",
    "triggers.sql",
    "user_defined_data_types.sql"
  )
  $TargetScripts | ForEach-Object{
    $script = $_
    Write-Host "executing $script";
    [String]$q = Get-Content -Path $script;

    Invoke-Sqlcmd -ConnectionString $ConnectionString -Query "$q" -Verbose -QueryTimeout 0 |
    Export-Csv -Path "$dir\output\$script.csv" -NoTypeInformation
  }
