//
//  Todo.swift
//  
//
//  Created by Jack Moseley on 16 October 2021.
//

import Foundation
import Fluent

final class Todo: Model {
	static let schema: String = "todos"

	@ID(key: .id)
	var id: UUID?

	@Field(key: "title")
	var title: String

	@Field(key: "completed")
	var completed: Bool

	init() {}

	init(id: UUID = UUID(), title: String) {
		self.id = id
		self.title = title
	}

}
