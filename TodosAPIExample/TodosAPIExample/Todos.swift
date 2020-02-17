//
//  Todos.swift
//  TodosAPIExample
//
//  Created by DhakaLive on 1/15/20.
//  Copyright © 2020 DhakaLive. All rights reserved.
//

import Foundation

class Todos: Codable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}
