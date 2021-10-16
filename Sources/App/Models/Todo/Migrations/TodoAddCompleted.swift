//
//  TodoAddCompleted.swift
//  
//
//  Created by Jack Moseley on 16 October 2021.
//

import Foundation
import Fluent

struct TodoAddCompletedMigration: Migration {

	func prepare(on database: Database) -> EventLoopFuture<Void> {
		return database.schema(Todo.schema)
			.field("completed", .bool, .required, .sql(.default(false)))
			.update()
	}

	func revert(on database: Database) -> EventLoopFuture<Void> {
		return database.schema(Todo.schema)
			.deleteField("completed")
			.update()
	}

}
