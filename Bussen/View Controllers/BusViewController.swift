//
//  BusViewController.swift
//  Bussen
//
//  Created by Tom Van der Weeën on 08/08/2021.
//

import UIKit

class BusViewController: UIViewController {
    
    @IBOutlet var cards: [UIImageView]!
    var index: Int = 1
    var deck = Deck()
    var currentCard: Card!
    var drawnCards: [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deck.shuffleCards()
        setUi()
    }
    
    func setUi() {
        self.currentCard = deck.drawCard()
        self.cards[0].image = self.currentCard.image
        self.drawnCards.append(self.currentCard)
        UIView.transition(with: self.cards[0], duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
    
    func getCard() {
        self.currentCard = deck.drawCard()
        self.cards[self.index].image = self.currentCard.image
        self.drawnCards.append(self.currentCard)
        UIView.transition(with: self.cards[self.index], duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
        self.index += 1
    }
    
    @IBAction func lower(_ sender: Any) {
        getCard()
        getPopup(higher: false)
    }
    
    @IBAction func higher(_ sender: Any) {
        getCard()
        getPopup(higher: true)
    }
    
    func getPopup(higher: Bool) {
        let size = self.drawnCards.count
        if higher {
            if self.drawnCards[size-1].value <= self.drawnCards[size-2].value {
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.reset()
                    
                    let popup = PopupCorrect(nrOfSips: self.index)
                    popup.nrOfSips = self.index
                    self.view.addSubview(popup)
                }
            }
        }
        else {
            if self.drawnCards[size-1].value >= self.drawnCards[size-2].value {
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.reset()
                    
                    let popup = PopupCorrect(nrOfSips: self.index)
                    popup.nrOfSips = self.index
                    self.view.addSubview(popup)
                }
            }
        }
    }
    
    func reset() {
        self.index = 1
        for i in 1..<self.cards.count {
            self.cards[i].image = UIImage(named: "Yellow_back")
            UIView.transition(with: self.cards[i], duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
        if let first = self.drawnCards.first {
            self.drawnCards = [first]
        }
    }
}
