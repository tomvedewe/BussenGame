//
//  SelectColorViewController.swift
//  Bussen
//
//  Created by Tom Van der Weeën on 27/07/2021.
//

import Foundation
import UIKit

class SelectColorViewController: UIViewController {
    
    var players: [Player]!
    var currentPlayer: Player!
    var card: Card!
    var index: Int = 0
    var deck = Deck()
    @IBOutlet var cardToShow: UIImageView!
    @IBOutlet var blackButton: UIButton!
    @IBOutlet var redButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUi()
    }
    
    func setUi() {
        self.currentPlayer = players[self.index]
        self.title = players[self.index].name
        self.cardToShow.image = UIImage(named: "Yellow_back")
        UIView.transition(with: self.cardToShow, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
        disableButtons(bool: false)
    }
    
    func getCard() {
        self.card = deck.drawCard()
        
        self.cardToShow.image = self.card.image
        UIView.transition(with: self.cardToShow, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
        self.players[self.index].cards.append(self.card)
        disableButtons(bool: true)
    }

    @IBAction func blackButtonPressed(_ sender: Any) {
        getCard()
        getCorrectPopup(char: "B")
    }
    
    
    @IBAction func redButtonPressed(_ sender: Any) {
        getCard()
        getCorrectPopup(char: "R")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is HigherLowerViewController {
            let vc = segue.destination as? HigherLowerViewController
            vc?.players = self.players
            vc?.deck = self.deck
        }
    }
    
    @IBAction func next(_ sender: Any) {
        if self.cardToShow.image != UIImage(named: "Yellow_back") {
            if self.index < self.players.count - 1 {
                self.index += 1
                setUi()
            }
            else {
                performSegue(withIdentifier: "HigherLower", sender: nil)
            }
        }
    }
    
    func getCorrectPopup(char: Character) {
        if self.card.color != char {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                let popup = PopupCorrect(nrOfSips: 1)
                popup.nrOfSips = 1
                self.view.addSubview(popup)
            }
        }
    }
    
    func disableButtons(bool: Bool) {
        if bool {
            self.blackButton.isEnabled = false
            self.redButton.isEnabled = false
        }
        else {
            self.blackButton.isEnabled = true
            self.redButton.isEnabled = true
        }
    }
}
