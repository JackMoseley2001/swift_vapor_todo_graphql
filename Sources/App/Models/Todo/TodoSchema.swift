//
//  TodoSchema.swift
//  
//
//  Created by Jack Moseley on 16 October 2021.
//

import Foundation
import Graphiti
import Vapor

let todoSchema = try! Schema<TodoResolver, Request> {
	Scalar(UUID.self)

	Type(Todo.self) {
		Field("id", at: \.id)
		Field("title", at: \.title)
		Field("completed", at: \.completed)
	}

	Query {
		Field("todos", at: TodoResolver.getAllTodos)

		Field("getTodo", at: TodoResolver.getTodoById) {
			Argument("id", at: \.id)
		}
	}

	Mutation {
		Field("createTodo", at: TodoResolver.createTodo) {
			Argument("title", at: \.title)
		}

		Field("updateTodo", at: TodoResolver.updateTodo) {
			Argument("id", at: \.id)
			Argument("completed", at: \.completed)
		}

		Field("deleteTodo", at: TodoResolver.deleteTodo) {
			Argument("id", at: \.id)
		}
	}

}
