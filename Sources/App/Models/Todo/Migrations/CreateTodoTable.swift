//
//  CreateTodoTable.swift
//  
//
//  Created by Jack Moseley on 16 October 2021.
//

import Foundation
import Fluent

struct CreateTodoTableMigration: Migration {

	func prepare(on database: Database) -> EventLoopFuture<Void> {
		return database.schema(Todo.schema)
			.id()
			.field("title", .string, .required)
			.create()
	}

	func revert(on database: Database) -> EventLoopFuture<Void> {
		return database.schema(Todo.schema).delete()
	}

}
