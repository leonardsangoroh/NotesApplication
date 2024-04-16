//
//  ViewController.swift
//  NotesApplication
//
//  Created by Lee Sangoroh on 18/03/2024.
//

import UIKit

class TableViewController: UITableViewController {
    
    let fileManager = FileManager.default
    
    var notes: [Note] = []
    var tableList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createSaveDirectory()
        notes = reloadNotes()
        print(notes)
        setupTableView()
        
    }
    
    
    func setupTableView() {
        view.backgroundColor = .systemBackground
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addNote))
    }
    
    
    @objc func addNote(){
        let ac = UIAlertController(title: "Add Note", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "New Note", style: .default) { [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else {return}
            
            self?.writeToJSON(item: item)
            self?.tableView.reloadData()
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    
    // write to json file
    func writeToJSON(item heading: String) {
        let note = Note(heading: heading, noteContent: nil)
        notes.append(note)
        save()
        
    }
    
    
    func save () {
        let fileURL = getFileURL()
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(notes) {
            do {
                try savedData.write(to: fileURL)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func getFileURL() -> URL{
        //get url for documents directory
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        //let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        // create directory where notes will be saved
        // create userNotes URL
        let userNotes = documentURL.appendingPathComponent("UserNotes")
        
        //check if directory exists
        // create userNotes directory
        if !FileManager.default.fileExists(atPath: userNotes.path) {
            print("Directory Created")
            FileManager.default.createFile(atPath: userNotes.path, contents: nil, attributes: nil)
        } else {
            print("Directory already created")
        }
        
        // create notes JSON file url
        let notesFileURL = userNotes.appendingPathComponent("notes.json")
        
        return notesFileURL
    }
    
    
    func createSaveDirectory() {
        /*
         when it comes to file management, each app has its own sandboxed file system
         this means each app has its own area in the device's file system where it can save and manage files
         other apps can't access this area, which helps keep the app's data secure
         
         one of the key parts of an app's sandboxed file system is the documents directory
         this directory is where the app can save user-generated data that the app needs to function properly
         the documents directory is automatically created by the system when the app is installed
         
         FileManager.default.urls(for: in:) returns an array of URLs for the specified directory in the specified domain
         the .documentDirectory argument specifies the Documents directory
         .userDomainMask argument specifies the current user's home directory
         first! gets the first and usually the only URL in the array
         */
        
        //get url for documents directory
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        //let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        // create directory where notes will be saved
        // create userNotes URL
        let userNotes = documentURL.appendingPathComponent("UserNotes")
        
        //check if directory exists
        // create userNotes directory
        if !FileManager.default.fileExists(atPath: userNotes.path) {
            print("Directory Created")
            FileManager.default.createFile(atPath: userNotes.path, contents: nil, attributes: nil)
        } else {
            print("Directory already created")
        }
        
        // create notes JSON file url
        let notesFileURL = userNotes.appendingPathComponent("notes.json")
        
        //check if file exists
        if !FileManager.default.fileExists(atPath: notesFileURL.path) {
            FileManager.default.createFile(atPath: notesFileURL.path, contents: nil, attributes: nil)
        } else {
            print("File already created")
        }
        
        
    }
    
    
    func reloadNotes() -> [Note] {
        let fileURL = getFileURL()
        var readingData: [Note] = []
        
        do {
            let jsonNotes = try Data(contentsOf: fileURL)
            
            let jsonDecoder = JSONDecoder()
            readingData = try jsonDecoder.decode([Note].self, from: jsonNotes)
            
        } catch {
            print("Error decoding data: \(error)")
        }
        
        return readingData
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let noteHeading = notes[indexPath.item].heading
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = noteHeading
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.noteIdentifier = notes[indexPath.row].heading
        print(vc.noteIdentifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

