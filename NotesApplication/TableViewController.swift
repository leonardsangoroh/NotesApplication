//
//  ViewController.swift
//  NotesApplication
//
//  Created by Lee Sangoroh on 18/03/2024.
//

import UIKit

class TableViewController: UITableViewController {
    
    var contents = ["Notes1", "Notes2", "Notes3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemRed
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return contents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      cell.textLabel?.text = contents[indexPath.row]
      return cell
    }
    
}

