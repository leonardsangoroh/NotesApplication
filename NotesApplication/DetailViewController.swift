//
//  DetailViewController.swift
//  NotesApplication
//
//  Created by Lee Sangoroh on 18/03/2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    let fileManager = FileManager.default
    
    weak var delegate: NoteUpdateDelegate?
    var contents: String?
    var noteIdentifier: String!
    let textView = UITextView()
    var notes: [Note] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViewController()
        notes = reloadNotes()
        setupTextView()
        
    }
    
    func setupViewController() {
        title = noteIdentifier
    }
    
    
    func setupTextView() {
        textView.text = contents
        print(contents)
        view.addSubview(textView)
        //textView.frame = CGRect(x: 20.0, y: 90.0, width: 250.0, height: 100.0)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    func saveNoteContent(){
        
        let noteContent = textView.text
        
//        for index in notes.indices {
//            if noteIdentifier == notes[index].heading {
//                // Modify the mutable noteHead
//                notes[index].noteContent = noteContent
//                print("Content has been set!!!!")
//            }
//        }
//
//        save()
        
        if let content = noteContent {
            delegate?.didUpdateNoteContent(content: content, forNoteWithIdentifier: noteIdentifier)
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
    
    
    func save () {
        let fileURL = getFileURL()
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(notes) {
            do {
                try savedData.write(to: fileURL)
                print("SAVED!!!!!")
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        print(textView.text)
        saveNoteContent()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
