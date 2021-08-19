//
//  HigherLowerViewController.swift
//  Bussen
//
//  Created by Tom Van der Weeën on 27/07/2021.
//

import Foundation
import UIKit

class HigherLowerViewController: UIViewController {
    
    var players: [Player]!
    var currentPlayer: Player!
    var card: Card!
    var index: Int = 0
    var deck = Deck()
    @IBOutlet var cardImage: UIImageView!
    @IBOutlet var cardToShow: UIImageView!
    @IBOutlet var lowerButton: UIButton!
    @IBOutlet var higherButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setUi()
    }
    
    func setUi() {
        self.currentPlayer = players[self.index]
        self.title = players[self.index].name
        self.cardToShow.image = UIImage(named: "Yellow_back")
        UIView.transition(with: self.cardToShow, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
        self.cardImage.image = self.currentPlayer.cards.first?.image
        disableButtons(bool: false)
    }
    
    func getCard() {
        self.card = deck.drawCard()
        self.cardToShow.image = self.card.image
        UIView.transition(with: self.cardToShow, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        self.players[self.index].cards.append(self.card)
        disableButtons(bool: true)
    }
    
    @IBAction func higher(_ sender: Any) {
        getCard()
        getCorrectPopup(higher: true)
    }
    
    @IBAction func lower(_ sender: Any) {
        getCard()
        getCorrectPopup(higher: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is BetweenViewController {
            let vc = segue.destination as? BetweenViewController
            vc?.players = self.players
        }
    }
    
    @IBAction func next(_ sender: Any) {
        if self.cardToShow.image != UIImage(named: "Yellow_back") {
            if self.index < self.players.count - 1 {
                self.index += 1
                setUi()
            }
            else {
                performSegue(withIdentifier: "Between", sender: nil)
            }
        }
    }
    
    func getCorrectPopup(higher: Bool) {
        if higher {
            if self.card.value <= self.currentPlayer.cards[0].value {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    let popup = PopupCorrect(nrOfSips: 2)
                    popup.nrOfSips = 2
                    self.view.addSubview(popup)
                }
            }
        }
        else {
            if self.card.value >= self.currentPlayer.cards[0].value {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    let popup = PopupCorrect(nrOfSips: 2)
                    popup.nrOfSips = 2
                    self.view.addSubview(popup)
                }
            }
        }
        
    }
    
    func disableButtons(bool: Bool) {
        if bool {
            self.lowerButton.isEnabled = false
            self.higherButton.isEnabled = false
        }
        else {
            self.lowerButton.isEnabled = true
            self.higherButton.isEnabled = true
        }
    }
    
}
