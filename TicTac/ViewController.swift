//
//  ViewController.swift
//  TicTac
//
//  Created by Haroon Ahmad on 8/10/21.
//

import UIKit


struct User {
    var lastMove : Int
    var moves: [Int]
}

enum Player : String {
    case player1 = "o"
    case player2 = "x"
    
    func changePlayer() -> Player {
        switch (self) {
        case .player1: return .player2
        case .player2: return .player1
        }
    }
    
    func image() -> UIImage {
        return UIImage(named: self.rawValue + ".png")!
    }
}

struct Board {
    var field : [Player?]
    var totalTurns : Int
    var gameStart : Bool
    var gameOver : Bool
}


class ViewController: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var gameStatus: UILabel!
    
    @IBOutlet weak var topLeft: UIButton!
    @IBOutlet weak var midLeft: UIButton!
    @IBOutlet weak var bottomLeft: UIButton!
    @IBOutlet weak var topMid: UIButton!
    @IBOutlet weak var midMiddle: UIButton!
    @IBOutlet weak var bottomMiddle: UIButton!
    @IBOutlet weak var topRight: UIButton!
    @IBOutlet weak var midRight: UIButton!
    @IBOutlet weak var bottomRight: UIButton!
    
    var currentPlayer : Player!
    var gameboard : Board!
    let winCondition = [[0, 1, 2], [3, 4, 5], [6, 7, 8], //horizontal
                        [0, 3, 6], [1, 4, 7], [2, 5, 8], //vertical
                        [0, 4, 8], [2, 4, 6]] //diagonals

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startGame(_ sender: UIButton) {
        self.start()
        sender.setTitle("Start Again", for: .normal)
    }
    
    func start() {
        
        currentPlayer = Player.player1
        gameboard = Board(field: [nil,nil,nil,nil,nil,nil,nil,nil,nil], totalTurns: 0, gameStart: true, gameOver: false)
        self.reset()
    }
    
    @IBAction func makeMove(_ sender: UIButton) {
        
        let indexToMove = sender.tag
        
        sender.setTitle(currentPlayer.rawValue, for: .normal)
        if (gameboard.field[indexToMove] == nil && !gameboard.gameOver) {
            gameboard.field[indexToMove] = currentPlayer
            gameboard.totalTurns += 1

            if let winner = checkResult() {
                gameboard.gameOver = true
                gameStatus.text = "\(winner) won!"
            } else if (gameboard.totalTurns == 9) {
                gameboard.gameOver = true
                gameStatus.text = "This was a tie!"
                
                
            } else {
                currentPlayer = currentPlayer.changePlayer()
            }
        }
    }
    
        
    func checkResult() -> Player? {
        for condition in winCondition {
            let row = condition.map { gameboard.field[$0] }
            if (row[0] != nil && row[0] == row[1] && row[1] == row[2]) {
                return row[0]
            }
        }
        return nil
    }
    
    
    func reset() {
        self.bottomLeft.setTitle("", for: .normal)
        self.topLeft.setTitle("", for: .normal)
        self.midLeft.setTitle("", for: .normal)
        self.bottomRight.setTitle("", for: .normal)
        self.topRight.setTitle("", for: .normal)
        self.midRight.setTitle("", for: .normal)
        self.topMid.setTitle("", for: .normal)
        self.bottomMiddle.setTitle("", for: .normal)
        self.midMiddle.setTitle("", for: .normal)
    }


}

