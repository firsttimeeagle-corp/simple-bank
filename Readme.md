# Simple Bank

## DB Migration

To create a migration files:
```bash
$ migrate create -ext sql -dir db/migration -seq <migration_name>
```

To run a migration:
```bash
$ migrate -path db/migration -database "postgresql://<username>:<password>@<host>:<port>/<db_name>?sslmode=disable" -verbose up
```