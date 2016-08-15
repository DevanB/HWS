//
//  MasterViewController.swift
//  Project5
//
//  Created by Devan Beitel on 8/14/16.
//  Copyright © 2016 Devan Beitel. All rights reserved.
//

import UIKit
import GameKit

class MasterViewController: UITableViewController {

    var objects = [String]()
    var allWords = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: startWordsPath) {
                allWords = startWords.components(separatedBy: "\n")
            }
        } else {
            allWords = ["silkworm"]
        }
        startGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    func startGame() {
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allWords) as! [String]
        title = allWords[0]
        objects.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] _ in
            let answer = ac.textFields![0]
            self.submitAnswer(answer: answer.text!)
        }
        ac.addAction(submitAction)
        present(ac, animated: true, completion: nil)
    }
    
    func submitAnswer(answer: String) {
        let lowerAnswer: String = answer.lowercased()
        var errorTitle: String = String()
        var errorMessage: String = String()
        
        if wordIsPossible(word: lowerAnswer) {
            if wordIsOriginal(word: lowerAnswer) {
                if wordIsReal(word: lowerAnswer) {
                    objects.insert(lowerAnswer, at: 0)
                    
                    let indexPath = NSIndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
                } else {
                    errorTitle = "Word not recognized."
                    errorMessage = "You can't just make them up, you know!"
                }
            } else {
                errorTitle = "Word used already"
                errorMessage = "Be more original!"
            }
        } else {
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from '\(title?.lowercased())'!"
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    func wordIsPossible(word: String) -> Bool {
        var tempWord = title!.lowercased()
        
        for letter in word.characters {
            if let pos = tempWord.range(of: String(letter)) {
                tempWord.remove(at: pos.lowerBound)
            } else {
                return false
            }
        }
        return true
    }
    
    func wordIsOriginal(word: String) -> Bool {
        return !objects.contains(word)
    }
    
    func wordIsReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.characters.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
}

