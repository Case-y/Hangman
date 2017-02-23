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
    
    // Word to Guess!
    var phraseLabel: String = ""
    var phraseArray: [String] = []
    var displayArray: [String] = []
    var lettersGuessed: Set<String> = []
    var lettersContained: Set<String> = []
    var correctGuesses: Int = 0
    var correctNumToGuess: Int = 0
    @IBOutlet weak var phrase: UILabel!
    
    // Photo
    @IBOutlet weak var hangmanImage: UIImageView!
    
    // Current Guess:
    var guess: String = "A"
    let currentGuessLabel = "Current Guess : "
    @IBOutlet weak var currentGuess: UILabel!
    
    
    @IBAction func cheatWord(_ sender: Any) {
        
        let alert = UIAlertController(title: "Don't cheat!", message: "You can solve this! Just kidding, the word is " + phraseLabel, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay, I can do this!", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    // Incorrect Guesses:
    var incorrect: Int = 0
    let incorrectGuessesLabel = "Incorrect Guesses : "
    @IBOutlet weak var incorrectGuesses: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameSetAndReady()
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
    
    // Set up the game!
    func gameSetAndReady() {
        let hangmanPhrases = HangmanPhrases()
        // Generate a random phrase for the user to guess
        self.phraseLabel = hangmanPhrases.getRandomPhrase()
//        print(self.phraseLabel)
        
        // Generate incorrect
        self.incorrect = 0
        self.incorrectGuesses.text = self.incorrectGuessesLabel + String(self.incorrect)
        
        // Generate new photo
        hangmanImage.image = UIImage(named: "hangman1")
        
        // Genereate Default 'A'
        self.currentGuess.text = self.currentGuessLabel + self.guess
        
        // Generate new set
        lettersGuessed = Set<String>()
        lettersContained = Set<String>()
        
        // Generate Phrase Arrays
        displayArray = []
        
        phraseArray = self.phraseLabel.characters.map { String($0) }
        for char in phraseArray {
            if (char == " ") {
                displayArray.append("\n")
            } else {
                displayArray.append("_")
                lettersContained.insert(char)
            }
        }
        
        // Set number of times to guess correct
        correctGuesses = 0
        correctNumToGuess = lettersContained.count
        let displayRepresentation = displayArray.joined(separator: " ")
        phrase.text = displayRepresentation
        
    }
    
    func validateCorrectness() {
        
        // Was user wrong?
        if self.lettersContained.contains(self.guess) {
            // User right!
            // --------------------
            
            // Update correctness
            correctGuesses += 1
            
            // Update display!
            for i in phraseArray.indices {
                if (phraseArray[i] == self.guess) {
                    displayArray[i] = self.guess
                }
            }
            
            let displayRepresentation = displayArray.joined(separator: " ")
            phrase.text = displayRepresentation
            
            if (correctGuesses == correctNumToGuess) {
                let alert = UIAlertController(title: "Horray!", message: "You solved this word's Hangman! The word was " + phraseLabel + ".", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay, I'm happy haha!", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                gameSetAndReady()
            }
            
        } else {
            // User wrong :\
            // --------------------
            
            // Update incorrect guesses...
            incorrect += 1
            incorrectGuesses.text = incorrectGuessesLabel + String(incorrect)
            
            // Update hangman photo
            hangmanImage.image = UIImage(named: "hangman" + String(incorrect + 1))
            
            // Six times to be wrong :P
            if (incorrect == 6) {
                let alert = UIAlertController(title: "Noooo!", message: "You've been hanged! The word was " + phraseLabel + ". :(", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Okay, I'm try again by clicking startover!", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                let displayRepresentation = phraseArray.joined(separator: " ")
                phrase.text = displayRepresentation
                
                gameSetAndReady()
            }
        }
    }
    
    @IBAction func userGuessed(_ sender: Any) {
        
        // Did user pressed this before?
        if !self.lettersGuessed.contains(self.guess) {
            self.lettersGuessed.insert(self.guess)
            
            // Was user right or wrong?
            validateCorrectness()
            
        } else {
            
            // Yes user pressed this before...
            let alert = UIAlertController(title: "Whoops!", message: "You already guessed this letter!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay, I'm sorry haha!", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func restartTheGame(_ sender: Any) {
        gameSetAndReady()
    }
    
    // User presses on the alphabet keyboard
    @IBAction func alphabetPressed(_ sender: Any) {
        let charc = HangmanViewController.alphabet[Int((sender as AnyObject).tag)]
        self.guess = charc
        self.currentGuess.text = self.currentGuessLabel + self.guess
    }
    
    
    // Exit back to menu
    @IBAction func exitToMain(_ sender: Any) {
        performSegue(withIdentifier: "menu", sender: self)
    }
    
    

}
