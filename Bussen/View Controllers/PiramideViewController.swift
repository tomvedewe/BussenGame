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
    var deck: Deck!
    var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var nextBtn: UIBarButtonItem!
    var loser: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        nextBtn.isEnabled = false
        nextBtn.title = nil
        showAlert()
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(turnCard))
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
                showPlayerCard(playerCard: c!, currentPlayer: player)
            }
        }
    }
    
    func addIndex() {
        if index < self.cards.count - 1 {
            index += 1
        }
        else {
            self.tapGestureRecognizer.isEnabled = false
            self.loser = getPlayerWithLeastCards().name
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                let popup = PopupLoserOfPiramide(playerName: self.loser)
                self.view.addSubview(popup)
            }
            
            nextBtn.isEnabled = true
            nextBtn.title = "playBus".localized()
        }
    }
    
    func showPlayerCard(playerCard: Card, currentPlayer: Player) {
        let alert = UIAlertController(title: currentPlayer.name, message: "layCard".localized(), preferredStyle: .alert)
        
        let noAction = UIAlertAction(title: "keep".localized(), style: .cancel, handler: nil)

        for i in 0..<currentPlayer.cards.count {
            let imgViewTitle: UIImageView!
            switch i {
            case 0:
                imgViewTitle = UIImageView(frame: CGRect(x: 15, y: 85, width: 100, height: 170))
            case 1:
                imgViewTitle = UIImageView(frame: CGRect(x: 145, y: 85, width: 100, height: 170))
            case 2:
                imgViewTitle = UIImageView(frame: CGRect(x: 15, y: 260, width: 100, height: 170))
            case 3:
                imgViewTitle = UIImageView(frame: CGRect(x: 145, y: 260, width: 100, height: 170))
            default:
                imgViewTitle = UIImageView(frame: CGRect(x: 15, y: 85, width: 100, height: 170))
            }
            //Add imageview to alert
            imgViewTitle.image = currentPlayer.cards[i].image
            if currentPlayer.cards[i] == playerCard {
                imgViewTitle.layer.borderWidth = 3
                imgViewTitle.layer.borderColor = UIColor(red: 1, green: 1, blue: 0, alpha: 1.0).cgColor
            }
            
            alert.view.addSubview(imgViewTitle)
        }
        
        let height = NSLayoutConstraint(item: alert.view as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.view.frame.height - 20)
        let width = NSLayoutConstraint(item: alert.view as Any, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
        alert.view.addConstraint(height)
        alert.view.addConstraint(width)
        
        for player in self.players {
            if player != currentPlayer {
                let action = UIAlertAction(title: player.name, style: .default, handler: { action in
                    if let index = self.players.firstIndex(of: currentPlayer) {
                        self.players[index].removeCardFromPlayer(card: playerCard)
                        print(self.players[index].cards.count)
                    }
                })
                alert.addAction(action)
            }
        }

        alert.addAction(noAction)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
            self.present(alert, animated: true, completion: nil)
        }
       
    }
    
    func getPlayerWithLeastCards() -> Player {
        _ = self.players.sorted(by: { $0.cards.count < $1.cards.count })
        
        return self.players[0]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is BusViewController {
            let vc = segue.destination as? BusViewController
            vc?.playerName = self.loser
            
        }
    }
    
    @IBAction func playBus(_ sender: Any) {
        performSegue(withIdentifier: "Bus", sender: nil)
    }
    
}
