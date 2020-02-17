//
//  ViewController.swift
//  TableViewWithClosure
//
//  Created by DhakaLive on 1/7/20.
//  Copyright © 2020 DhakaLive. All rights reserved.
//

import UIKit
import JGProgressHUD

class ViewController: UITableViewController {

    let apiClient = ApiClient()
    var todos = [Todo]()
    
    /*Progress Dialog*/
    let hud = JGProgressHUD(style: JGProgressHUDStyle.dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTodos()
    }
    
    /*Progress Dialog*/
    private func showHUD() {
        hud.textLabel.text = "Loading Todos..."
        hud.show(in: self.tableView)
    }
    
    /*Progress Dialog*/
    private func hideHUD() {
        hud.dismiss()
    }

    private func getTodos() {
        showHUD()
        apiClient.getTodos { [weak self] result in
            do {
                let data = try JSONDecoder().decode([Todo].self, from: result)
                self?.todos += data
                DispatchQueue.main.sync {
                    self?.hideHUD()
                    self?.tableView.reloadData()
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PersonTableViewCell {
            let todo = todos[indexPath.row]
            cell.name.text = todo.title
            if todo.completed {
                cell.desp.text = "Compltyed"
            } else {
                cell.desp.text = "InCompltyed"
            }
            return cell
        }
        
        return UITableViewCell()
    }
}

