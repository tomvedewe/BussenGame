//
//  PopupLoserOfPiramide.swift
//  Bussen
//
//  Created by Tom Van der Weeën on 12/08/2021.
//

import UIKit

class PopupLoserOfPiramide: UIView {
    
    var playerName: String!
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.text = "busTime".localized()
        label.numberOfLines = 3
        return label
    }()
    
    private let beerImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "bus")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    var subTitleLabel: UILabel = UILabel()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, beerImage, subTitleLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let container: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .magenta
        view.layer.cornerRadius = 24
        return view
    }()
    
    @objc func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn,  animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        }) { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
    
    func animateIn() {
        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn,  animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }
    
    init(playerName: String) {
        self.playerName = playerName
        super.init(frame: CGRect.zero)
        
        self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.subTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.subTitleLabel.textAlignment = .center
        self.subTitleLabel.numberOfLines = 4
        self.subTitleLabel.text = String(self.playerName) + "playTheBus".localized()
        //self.subTitleLabel.text = "U moet \(String(describing: nrOfSips)) slokken nemen"
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        self.frame = UIScreen.main.bounds
        
        self.addSubview(container)
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45).isActive = true
        
        container.addSubview(stack)
        stack.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        stack.heightAnchor.constraint(equalTo: container.heightAnchor).isActive = true
        
        animateIn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented yes")
    }
}
