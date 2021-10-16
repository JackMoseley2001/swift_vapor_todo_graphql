//
//  TodoResolver.swift
//  
//
//  Created by Jack Moseley on 16 October 2021.
//

import Foundation
import Vapor
import Fluent
import Graphiti

final class TodoResolver {

	func getAllTodos(request: Request, _: NoArguments) throws -> EventLoopFuture<[Todo]> {
		return Todo.query(on: request.db).all()
	}

	func getTodoById(request: Request, arguments: GetTodoByIdArugments) throws -> EventLoopFuture<Todo> {
		return Todo.find(arguments.id, on: request.db)
			.unwrap(or: Abort(.notFound))
	}

	func createTodo(request: Request, arguments: CreateTodoArguments) throws -> EventLoopFuture<Todo> {
		let todo = Todo(title: arguments.title)
		return todo.create(on: request.db).map { todo }
	}

	func updateTodo(request: Request, arguments: UpdateTodoArugments) throws -> EventLoopFuture<Bool> {
		return Todo.find(arguments.id, on: request.db)
			.unwrap(or: Abort(.notFound))
			.flatMap { todo -> EventLoopFuture<Void> in
				todo.completed = arguments.completed
				return todo.update(on: request.db)
			}
			.transform(to: true)
	}

	func deleteTodo(request: Request, arguments: DeleteTodoByArugments) throws -> EventLoopFuture<Bool> {
		return Todo.find(arguments.id, on: request.db)
			.unwrap(or: Abort(.notFound))
			.flatMap { $0.delete(on: request.db) }
			.transform(to: true)
	}

}

extension TodoResolver {

	struct CreateTodoArguments: Codable {
		let title: String
	}

	struct GetTodoByIdArugments: Codable {
		let id: UUID
	}

	struct UpdateTodoArugments: Codable {
		let id: UUID
		let completed: Bool
	}

	struct DeleteTodoByArugments: Codable {
		let id: UUID
	}

}
