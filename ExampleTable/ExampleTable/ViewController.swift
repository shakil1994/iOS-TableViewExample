//
//  ViewController.swift
//  ExampleTable
//
//  Created by DhakaLive on 1/14/20.
//  Copyright © 2020 DhakaLive. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblUserContact: UITableView!
    
    var names = ["Shakil", "Rana", "Kamrul", "Tanmoy"]
    var address = ["Cumilla", "Gopalgong", "Dinajpur", "Nilfamari"]
    var ages = ["25", "26", "28", "26"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! CustomTableViewCell
        
        cell.nameLabel.text = names[indexPath.row]
        cell.addressLabel.text = address[indexPath.row]
        cell.ageLabel.text = ages[indexPath.row]
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.names.remove(at: indexPath.row)
            self.tblUserContact.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func addName(_ sender: Any) {
        let alertController = UIAlertController(title: "Add New Person", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter your name"
        }
        alertController.addTextField { textAddress in
            textAddress.placeholder = "Enter your address"
        }
        alertController.addTextField { textAge in
            textAge.placeholder = "Enter your age"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { alert in
            self.names.append(alertController.textFields![0].text! )
            self.address.append(alertController.textFields![1].text!)
            self.ages.append(alertController.textFields![2].text!)
            
            self.tblUserContact.reloadData()
        }
        alertController.addAction(saveAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

