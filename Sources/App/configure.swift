import Vapor
import Fluent
import FluentPostgresDriver
import GraphQLKit
import GraphiQLVapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

	// Database
	app.databases.use(
		.postgres(
			hostname: "localhost",
			username: "postgres",
			password: "",
			database: "todo_graphql_app"
		),
		as: .psql
	)

	app.migrations.add(CreateTodoTableMigration())
	app.migrations.add(TodoAddCompletedMigration())

	// GraphQL

	app.register(graphQLSchema: todoSchema, withResolver: TodoResolver())

	app.enableGraphiQL()
}
