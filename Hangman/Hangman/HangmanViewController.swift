//
//  HangmanViewController.swift
//  Hangman
//

import UIKit

class HangmanViewController: UIViewController {
    
    // The 'Character' Pressed to indicate what character
    // the user guessed so far.
    private static let alphabet = ["A", "B", "C", "D", "E",
         "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q",
            "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    
    // Current Guess:
    var guess: String = ""
    let currentGuessLabel = "Current Guess : "
    @IBOutlet weak var currentGuess: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hangmanPhrases = HangmanPhrases()
        // Generate a random phrase for the user to guess
        let phrase: String = hangmanPhrases.getRandomPhrase()
        print(phrase)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func alphabetPressed(_ sender: Any) {
        let charc = HangmanViewController.alphabet[Int((sender as AnyObject).tag)]
        self.guess = charc
        currentGuess.text = currentGuessLabel + charc;
    }
    
    
    
    // Exit back to menu
    @IBAction func exitToMain(_ sender: Any) {
        performSegue(withIdentifier: "menu", sender: self)
    }
    
    

}
