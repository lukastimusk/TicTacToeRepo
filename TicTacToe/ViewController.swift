//
//  ViewController.swift
//  TicTacToe
//
//  Created by Lukas Timusk on 2024-07-11.
//

import UIKit

class ViewController: UIViewController {
    
    enum Turn {
        case Ex
        case Oh
    }

    @IBOutlet weak var c3: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var turnLabel: UILabel!
    
    var firstTurn = Turn.Ex
    var currentTurn = Turn.Ex
    
    var OH = "O"
    var EX = "X"
    var board = [UIButton]()
    
    var OScore = 0
    var XScore = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initBoard()
    }
    
    func initBoard(){
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)


    }

    @IBAction func boardTapAction(_ sender: UIButton)
    {
        addToBoard(sender)
        
        if checkForVictory(EX) {
            resultAlert(title: "Xs Win")
            XScore += 1
        }
        
        if checkForVictory(OH) {
            resultAlert(title: "Os Win")
            OScore += 1
        }
        
        if(fullBoard()) {
            resultAlert(title: "Draw")
        }
    }
    
    func checkForVictory(_ s:String) -> Bool {
        
        // Horizontal victory
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s) {
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s) {
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s) {
            return true
        }
        
        // Vertical victory
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s) {
            return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s) {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s) {
            return true
        }
        
        // Diagonal victory
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s) {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s) {
            return true
        }
        
        
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String) {
        let message = "Os: " + String(OScore) + "Xs: " + String(XScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: {(_) in
            self.resetBoard()
        }))
        
        self.present(ac, animated: true)
    }
    
    func resetBoard() {
        
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if(firstTurn == Turn.Oh){
            firstTurn = Turn.Ex
            turnLabel.text = EX
        }
        else if(firstTurn == Turn.Ex){
            firstTurn = Turn.Oh
            turnLabel.text = OH
        }
        
        currentTurn = firstTurn

    }
    
    func fullBoard() -> Bool {
        for button in board {
            if button.title(for: .normal) == nil {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton) {
        if (sender.title(for: .normal) == nil) {
            if(currentTurn == Turn.Oh) {
                sender.setTitle(OH, for: .normal)
                currentTurn = Turn.Ex
                turnLabel.text = EX
            }
            
            else if(currentTurn == Turn.Ex) {
                sender.setTitle(EX, for: .normal)
                currentTurn = Turn.Oh
                turnLabel.text = OH
            }
            
            sender.isEnabled = false
            
        }
    }
    
}

