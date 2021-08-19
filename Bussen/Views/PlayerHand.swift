//
//  PlayerHand.swift
//  Bussen
//
//  Created by Tom Van der Weeën on 19/08/2021.
//

import UIKit

class PlayerHand: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var cards: [Card]!
    
    var collectionView : UICollectionView = {
            let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 170)
            let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
            //If you set it false, you have to add constraints.
            cv.translatesAutoresizingMaskIntoConstraints = false
            cv.register(HeaderCell.self, forCellWithReuseIdentifier: "HeaderCell")
            cv.backgroundColor = .yellow
            return cv
        }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        //self.backgroundColor = .red
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        self.frame = UIScreen.main.bounds

        self.addSubview(collectionView)

        //Add constraint
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    func animateIn() {
        self.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn,  animations: {
            self.transform = .identity
            self.alpha = 1
        })
    }

    @objc func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn,  animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        }) { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
        cell.cardImg = UIImageView(image: UIImage(named: "Yellow_back"))
        cell.backgroundColor = .cyan
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: 200)
    }
}

class HeaderCell: UICollectionViewCell {

    var cardImg: UIImageView!
    
//    func configure(with img: UIImage) {
//        cardImg.image = img
//        flip()
//    }

    func flip() {
        UIView.transition(with: self.contentView, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
}
    
//    var myCollectionView:UICollectionView?
//
//    private let layout: UICollectionViewFlowLayout = {
//        let coll = UICollectionViewFlowLayout()
//        //coll.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
//        coll.itemSize = CGSize(width: 60, height: 60)
//        return coll
//    }()
//

//

//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
//        //self.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
//        self.frame = UIScreen.main.bounds
//
//        myCollectionView = UICollectionView(frame: self.container.frame, collectionViewLayout: layout)
//        myCollectionView?.register(HeaderCell.self, forCellWithReuseIdentifier: "HeaderCell")
//        myCollectionView?.backgroundColor = UIColor.green
//
//        myCollectionView?.dataSource = self
//        myCollectionView?.delegate = self
//

//
//        container.addSubview(myCollectionView ?? UICollectionView())
//        myCollectionView!.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
//        myCollectionView!.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
//        myCollectionView!.heightAnchor.constraint(equalTo: container.heightAnchor).isActive = true
//
//        animateIn()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("not implemented yes")
//    }
//}
//

//
//extension PlayerHand: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 9 // How many cells to display
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
//        myCell.backgroundColor = UIColor.blue
//        return myCell
//    }
//}
//extension PlayerHand: UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//       print("User tapped on item \(indexPath.row)")
//    }
//}

