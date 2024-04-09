//
//  DetailViewController.swift
//  NotesApplication
//
//  Created by Lee Sangoroh on 18/03/2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    var contents = [Note]()
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

    
    override func viewDidDisappear(_ animated: Bool) {
        print("Gone")
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
