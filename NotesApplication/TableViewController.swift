//
//  ViewController.swift
//  NotesApplication
//
//  Created by Lee Sangoroh on 18/03/2024.
//

import UIKit

class TableViewController: UITableViewController {
    
    //var contents = [Note]()
    var tableList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemRed
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addNote))
    }
    
    
    @objc func addNote(){
        let ac = UIAlertController(title: "Add Note", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "New Note", style: .default) { [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else {return}
            //self?.submit(item)
            self?.tableList.append(item)
            self?.tableView.reloadData()
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return tableList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let noteHeading = tableList[indexPath.item]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = noteHeading
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.noteIdentifier = tableList[indexPath.row]
        print(vc.noteIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

