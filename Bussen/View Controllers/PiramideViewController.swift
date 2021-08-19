//
//  PiramideViewController.swift
//  Bussen
//
//  Created by Tom Van der Weeën on 18/08/2021.
//

import UIKit

class PiramideViewController: UIViewController {
    
    var players: [Player]!
    @IBOutlet var cards: [UIImageView]!
    var index: Int = 0
    var card: Card!
    var deck = Deck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAlert()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(turnCard))
        tapGestureRecognizer.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func turnCard() {
        self.card = deck.drawCard()
        cards[self.index].image = self.card.image
        UIView.transition(with: self.cards[self.index], duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        checkPlayerCards(cardToCheck: self.card)
        addIndex()
    }
    
    func showAlert() {
        let alertController = UIAlertController(
            title: "note".localized(),
            message: "tapRules".localized(),
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))

        present(alertController, animated: true, completion: nil)
    }
    
    func checkPlayerCards(cardToCheck: Card) {
        for player in self.players {
            let c = player.checkCards(card: cardToCheck)
            if c != nil {
                showPlayerCard(playerCard: c!, playerName: player.name)
            }
        }
    }
    
    func addIndex() {
        if index < self.cards.count - 1 {
            index += 1
        }
    }
    
    func showPlayerCard(playerCard: Card, playerName: String) {
        let alert = UIAlertController(title: playerName, message: "Afleggen?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "YES", style: .default, handler: nil)
        let noAction = UIAlertAction(title: "NO", style: .cancel, handler: nil)

        //Add imageview to alert
        let imgViewTitle = UIImageView(frame: CGRect(x: 10, y: 80, width: 100, height: 170))
        imgViewTitle.image = playerCard.image
        imgViewTitle.layer.borderWidth = 2
        imgViewTitle.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
        alert.view.addSubview(imgViewTitle)
        
        let height = NSLayoutConstraint(item: alert.view as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 320)
        let width = NSLayoutConstraint(item: alert.view as Any, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
        alert.view.addConstraint(height)
        alert.view.addConstraint(width)

        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true, completion: nil)
    }
}
