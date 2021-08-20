//
//  BetweenViewController.swift
//  Bussen
//
//  Created by Tom Van der Weeën on 27/07/2021.
//

import Foundation
import UIKit

class BetweenViewController: UIViewController {
    
    var players: [Player]!
    var currentPlayer: Player!
    var card: Card!
    var index: Int = 0
    var deck: Deck!
    @IBOutlet var card1: UIImageView!
    @IBOutlet var card2: UIImageView!
    @IBOutlet var cardToShow: UIImageView!
    @IBOutlet var betweenButton: UIButton!
    @IBOutlet var outsideButton: UIButton!
    
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
        self.card1.image = self.currentPlayer.cards.first?.image
        self.card2.image = self.currentPlayer.cards[1].image
        disableButtons(bool: false)
    }
    
    func getCard() {
        self.card = deck.drawCard()
        self.cardToShow.image = self.card.image
        UIView.transition(with: self.cardToShow, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        self.players[self.index].cards.append(self.card)
        disableButtons(bool: true)
    }
    
    @IBAction func between(_ sender: Any) {
        getCard()
        getCorrectPopup(between: true)
    }
    
    @IBAction func outside(_ sender: Any) {
        getCard()
        getCorrectPopup(between: false)
    }
    
    @IBAction func next(_ sender: Any) {
        if self.cardToShow.image != UIImage(named: "Yellow_back") {
            if self.index < self.players.count - 1 {
                self.index += 1
                setUi()
            }
            else {
                performSegue(withIdentifier: "HaveOrNot", sender: nil)
            }
        }
    }
    
    func getCorrectPopup(between: Bool) {
        let temp = self.currentPlayer.cards.sorted(by: { $0.value < $1.value })
        if between {
            if self.card.value <= temp[0].value || self.card.value >= temp[1].value {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    let popup = PopupCorrect(nrOfSips: 3)
                    popup.nrOfSips = 3
                    self.view.addSubview(popup)
                }
            }
        }
        else {
            if self.card.value >= temp[0].value && self.card.value <= temp[1].value {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    let popup = PopupCorrect(nrOfSips: 3)
                    popup.nrOfSips = 3
                    self.view.addSubview(popup)
                }
            }
        }
        
    }
    
    func disableButtons(bool: Bool) {
        if bool {
            self.betweenButton.isEnabled = false
            self.outsideButton.isEnabled = false
        }
        else {
            self.betweenButton.isEnabled = true
            self.outsideButton.isEnabled = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is SameTypeCollectionViewController {
            let vc = segue.destination as? SameTypeCollectionViewController
            vc?.players = self.players
            vc?.deck = self.deck
        }
    }
}
