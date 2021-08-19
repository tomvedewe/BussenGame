//
//  HomeViewController.swift
//  Bussen
//
//  Created by Tom Van der Weeën on 12/08/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func changeLang(_ sender: Any) {
        let url = URL(string: UIApplication.openSettingsURLString)!
        UIApplication.shared.open(url)
    }
}
