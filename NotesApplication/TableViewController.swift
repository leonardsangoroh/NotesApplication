//
//  ViewController.swift
//  NotesApplication
//
//  Created by Lee Sangoroh on 18/03/2024.
//

import UIKit

class TableViewController: UITableViewController {
    
    var contents = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemRed
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addNote))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        ///load array from disk when app runs
        let defaults = UserDefaults.standard
        
        ///get optional Data
        if let savedNotes = defaults.object(forKey: "notes") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                ///give it to jsonDecoder to convert it back to object graph
                contents = try jsonDecoder.decode([Note].self, from: savedNotes)
            } catch {
                print("Failed to load people")
            }
        }
        
    }
    
    
    @objc func addNote(){
        let ac = UIAlertController(title: "Add Note", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "New Note", style: .default) { [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else {return}
            self?.submit(item)
            
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    func submit(_ item: String){
        let note = Note(heading: item, noteContent: "")
        contents.insert(note, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        save()
        return
    }
    
    
    func save () {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(contents) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return contents.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let note = contents[indexPath.item]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = note.heading
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = contents[indexPath.item]
        let vc = DetailViewController()
        vc.noteIdentifier = note.heading
        print(vc.noteIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

