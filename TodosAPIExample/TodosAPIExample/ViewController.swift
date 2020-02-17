//
//  ViewController.swift
//  TodosAPIExample
//
//  Created by DhakaLive on 1/15/20.
//  Copyright © 2020 DhakaLive. All rights reserved.
//

import UIKit

import JGProgressHUD

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let apiClient = APIClient()
    var todos = [Todos]()
    
    let hud = JGProgressHUD(style: JGProgressHUDStyle.dark)
    
    private func showHUD(){
        hud.textLabel.text = "Loading Todos..."
        hud.show(in: self.todosTableView)
    }
    
    private func hideHUD(){
        hud.dismiss()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodosCell", for: indexPath) as! CustomTableViewCell
        
        let todo = todos[indexPath.row]
        cell.userIdLabel.text = String(todo.userId)
        cell.idLabel.text = String(todo.id)
        cell.titleLabel.text = todo.title
        cell.completedLabel.text = String(todo.completed)
        
        return cell
        
    }
    
    private func getTodos(){
        showHUD()
        apiClient.getAllTodos { [weak self] result in
            do{
                let data = try JSONDecoder().decode([Todos].self, from: result)
                self?.todos += data
                DispatchQueue.main.sync {
                    self?.hideHUD()
                    self?.todosTableView.reloadData()
                }
            } catch (let error){
                print(error.localizedDescription)
            }
        }
    }
    

    @IBOutlet weak var todosTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getTodos()
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.todos.remove(at: indexPath.row)
            self.todosTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

