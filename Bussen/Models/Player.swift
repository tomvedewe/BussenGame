//
//  Player.swift
//  Bussen
//
//  Created by Tom Van der Weeën on 27/07/2021.
//

import Foundation
import UIKit

struct Player: Equatable {
    let id = UUID()
    var name: String
    var cards: [Card]
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
    
    func checkCards(card: Card) -> Card? {
        if !cards.isEmpty {
            for playerCard in cards {
                if playerCard.value == card.value {
                    return playerCard
                }
            }
        }
        return nil
    }
    
    mutating func removeCardFromPlayer(card: Card) {
        if let index = cards.firstIndex(of: card) {
            cards.remove(at: index)
        }
    }
}

struct Card: Equatable {
    let id = UUID()
    let value: Int
    let color: Character
    let image: UIImage
    let suit: Character
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    func flip(front: UIImage, back: UIImage) {
        let transitionOptions = UIView.AnimationOptions.transitionFlipFromLeft
            
        let frontImageView = UIImageView(image: front)
        let backImageView = UIImageView(image: UIImage(named: "Yellow_back")!)
        
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.5, options: transitionOptions, completion: nil)
    }
}

class Deck {
    let cards: [Card] = [
        // Clubs of klaveren
        Card(value: 1, color: "B", image: UIImage(named: "AC")!, suit: "C"),
        Card(value: 2, color: "B", image: UIImage(named: "2C")!, suit: "C"),
        Card(value: 3, color: "B", image: UIImage(named: "3C")!, suit: "C"),
        Card(value: 4, color: "B", image: UIImage(named: "4C")!, suit: "C"),
        Card(value: 5, color: "B", image: UIImage(named: "5C")!, suit: "C"),
        Card(value: 6, color: "B", image: UIImage(named: "6C")!, suit: "C"),
        Card(value: 7, color: "B", image: UIImage(named: "7C")!, suit: "C"),
        Card(value: 8, color: "B", image: UIImage(named: "8C")!, suit: "C"),
        Card(value: 9, color: "B", image: UIImage(named: "9C")!, suit: "C"),
        Card(value: 10, color: "B", image: UIImage(named: "10C")!, suit: "C"),
        Card(value: 11, color: "B", image: UIImage(named: "JC")!, suit: "C"),
        Card(value: 12, color: "B", image: UIImage(named: "QC")!, suit: "C"),
        Card(value: 13, color: "B", image: UIImage(named: "KC")!, suit: "C"),
        // Diamonds of ruiten
        Card(value: 1, color: "R", image: UIImage(named: "AD")!, suit: "D"),
        Card(value: 2, color: "R", image: UIImage(named: "2D")!, suit: "D"),
        Card(value: 3, color: "R", image: UIImage(named: "3D")!, suit: "D"),
        Card(value: 4, color: "R", image: UIImage(named: "4D")!, suit: "D"),
        Card(value: 5, color: "R", image: UIImage(named: "5D")!, suit: "D"),
        Card(value: 6, color: "R", image: UIImage(named: "6D")!, suit: "D"),
        Card(value: 7, color: "R", image: UIImage(named: "7D")!, suit: "D"),
        Card(value: 8, color: "R", image: UIImage(named: "8D")!, suit: "D"),
        Card(value: 9, color: "R", image: UIImage(named: "9D")!, suit: "D"),
        Card(value: 10, color: "R", image: UIImage(named: "10D")!, suit: "D"),
        Card(value: 11, color: "R", image: UIImage(named: "JD")!, suit: "D"),
        Card(value: 12, color: "R", image: UIImage(named: "QD")!, suit: "D"),
        Card(value: 13, color: "R", image: UIImage(named: "KD")!, suit: "D"),
        // Hearts of harten
        Card(value: 1, color: "R", image: UIImage(named: "AH")!, suit: "H"),
        Card(value: 2, color: "R", image: UIImage(named: "2H")!, suit: "H"),
        Card(value: 3, color: "R", image: UIImage(named: "3H")!, suit: "H"),
        Card(value: 4, color: "R", image: UIImage(named: "4H")!, suit: "H"),
        Card(value: 5, color: "R", image: UIImage(named: "5H")!, suit: "H"),
        Card(value: 6, color: "R", image: UIImage(named: "6H")!, suit: "H"),
        Card(value: 7, color: "R", image: UIImage(named: "7H")!, suit: "H"),
        Card(value: 8, color: "R", image: UIImage(named: "8H")!, suit: "H"),
        Card(value: 9, color: "R", image: UIImage(named: "9H")!, suit: "H"),
        Card(value: 10, color: "R", image: UIImage(named: "10H")!, suit: "H"),
        Card(value: 11, color: "R", image: UIImage(named: "JH")!, suit: "H"),
        Card(value: 12, color: "R", image: UIImage(named: "QH")!, suit: "H"),
        Card(value: 13, color: "R", image: UIImage(named: "KH")!, suit: "H"),
        // Schoppen
        Card(value: 1, color: "B", image: UIImage(named: "AS")!, suit: "S"),
        Card(value: 2, color: "B", image: UIImage(named: "2S")!, suit: "S"),
        Card(value: 3, color: "B", image: UIImage(named: "3S")!, suit: "S"),
        Card(value: 4, color: "B", image: UIImage(named: "4S")!, suit: "S"),
        Card(value: 5, color: "B", image: UIImage(named: "5S")!, suit: "S"),
        Card(value: 6, color: "B", image: UIImage(named: "6S")!, suit: "S"),
        Card(value: 7, color: "B", image: UIImage(named: "7S")!, suit: "S"),
        Card(value: 8, color: "B", image: UIImage(named: "8S")!, suit: "S"),
        Card(value: 9, color: "B", image: UIImage(named: "9S")!, suit: "S"),
        Card(value: 10, color: "B", image: UIImage(named: "10S")!, suit: "S"),
        Card(value: 11, color: "B", image: UIImage(named: "JS")!, suit: "S"),
        Card(value: 12, color: "B", image: UIImage(named: "QS")!, suit: "S"),
        Card(value: 13, color: "B", image: UIImage(named: "KS")!, suit: "S")
    ]
    
    private var cardIndices = [Int]()

    var cardsInDeck: Int { return cardIndices.count }

    func shuffleCards() {
        cardIndices = (0...51).map {$0 % 52}
        for i in (1...51).reversed() {
                let rand = Int(arc4random_uniform(UInt32(i + 1)))
                (cardIndices[i], cardIndices[rand]) = (cardIndices[rand], cardIndices[i])
            }
    }

    func drawCard() -> Card {
        if cardIndices.count == 0 {
            shuffleCards()
        }

        let last = cardIndices.removeLast()

        return cards[last]
    }
}
