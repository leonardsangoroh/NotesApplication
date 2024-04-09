//
//  DetailViewController.swift
//  NotesApplication
//
//  Created by Lee Sangoroh on 18/03/2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    var noteIdentifier: String!
    let textView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = noteIdentifier
        
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
    
    
    func updateUserDefaults(){
        // retrieve existing encoded data from UserDefaults
        let defaults = UserDefaults.standard
        // decode the data back to Notes
        if let encodedData = defaults.data(forKey: noteIdentifier) {
            print("decoded")
            let decoder = JSONDecoder()
            if let decodedNotes = try? decoder.decode(Note.self, from: encodedData) {
                // modify the decoded Note instance with the noteContent
                let updatedNote = Note(heading: decodedNotes.heading, noteContent: textView.text)
                
                // convert updated note instance to Data
                let encoder = JSONEncoder()
                if let updatedEncodedData = try? encoder.encode(updatedNote){
                    // save updated encoded note to UserDefaults
                    defaults.set(updatedEncodedData, forKey: noteIdentifier)
                    print("done")
                }
            }
        } else {
            print("Not decoded")
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        print("Gone")
        updateUserDefaults()
    }
    
    
//    func save () {
//        let jsonEncoder = JSONEncoder()
//        if let savedData = try? jsonEncoder.encode(contents) {
//            let defaults = UserDefaults.standard
//            defaults.set(savedData, forKey: "notes")
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
