//
//  SameTypeCollectionViewController.swift
//  Bussen
//
//  Created by Tom Van der Weeën on 08/08/2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class SameTypeCollectionViewController: UICollectionViewController {

    var players: [Player]!
    var currentPlayer: Player!
    var card: Card!
    var index: Int = 0
    var deck = Deck()
    var cardToShow: UIImageView!
    @IBOutlet var haveButton: UIButton!
    @IBOutlet var haveNotButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setUi()
    }
    
    func setUi() {
        self.currentPlayer = players[self.index]
        self.title = players[self.index].name
        self.cardToShow = UIImageView(image: UIImage(named: "Yellow_back"))
        self.players[self.index].cards.append(Card(value: 0, color: "J" , image: self.cardToShow.image!, suit: "J"))

        if index > 0 {
            self.collectionView.reloadData()
        }
        
        disableButtons(bool: false)
    }
    
    func getCard() {
        self.card = deck.drawCard()
        self.players[self.index].cards[3] = self.card
        let cell = collectionView.cellForItem(at: IndexPath(item: 3, section: 0)) as! CollectionViewCell
        
        cell.configure(with: self.card.image)
        
        disableButtons(bool: true)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.players[self.index].cards.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let customCell =  collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CollectionViewCell {
            
            customCell.configure(with: players[self.index].cards[indexPath.row].image)
            
            cell = customCell
        }
        
        return cell
    }
    
    func disableButtons(bool: Bool) {
        if bool {
            self.haveButton.isEnabled = false
            self.haveNotButton.isEnabled = false
        }
        else {
            self.haveButton.isEnabled = true
            self.haveNotButton.isEnabled = true
        }
    }
    
    @IBAction func haveIt(_ sender: Any) {
        getCard()
        getCorrectPopup(haveIt: true)
    }
    
    
    @IBAction func dontHaveIt(_ sender: Any) {
        getCard()
        getCorrectPopup(haveIt: false)
    }
    
    func getCorrectPopup(haveIt: Bool) {
        if haveIt {
            if !self.currentPlayer.cards.contains(where: {c in c.suit == self.card.suit}) {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    let popup = PopupCorrect(nrOfSips: 4)
                    self.view.addSubview(popup)
                }
            }
        }
        else {
            if self.currentPlayer.cards.contains(where: {c in c.suit == self.card.suit}) {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    let popup = PopupCorrect(nrOfSips: 4)
                    self.view.addSubview(popup)
                }
            }
        }
        
    }
    
    @IBAction func next(_ sender: Any) {
        if self.players[self.index].cards[3].image != UIImage(named: "Yellow_back") {
            if self.index < self.players.count - 1 {
                self.index += 1
                setUi()
            }
            else {
                performSegue(withIdentifier: "Piramide", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is PiramideViewController {
            let vc = segue.destination as? PiramideViewController
            vc?.players = self.players
        }
    }
}


