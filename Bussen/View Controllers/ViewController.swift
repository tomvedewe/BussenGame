//
//  ViewController.swift
//  Bussen
//
//  Created by Tom Van der Weeën on 23/07/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var playerName: UITextField!
    var players: [Player] = []
    @IBOutlet var playersTable: UITableView!
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    let cellSpacingHeight: CGFloat = 5
    
//    var topView: PlayerHand = {
//        let tv = PlayerHand()
//        tv.translatesAutoresizingMaskIntoConstraints = false
//        return tv
//    }()
//
//    func addTopView() {
//        view.addSubview(topView)
//
//        topView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        topView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        topView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
//        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45).isActive = true
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Register the table view cell class and its reuse id
        self.playersTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
                
        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()

        // This view controller itself will provide the delegate methods and row data for the table view.
        playersTable.delegate = self
        playersTable.dataSource = self
        
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))

        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    @IBAction func addPlayer(_ sender: Any) {
        if let text = playerName.text, playerName.text != nil, playerName.text != "" {
            DispatchQueue.main.async {
                let newEntry = [text]
                UserDefaults.standard.setValue(newEntry, forKey: "playersTable")
                let player = Player(name: text, cards: [])
                self.players.append(player)
                self.playersTable.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.players.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.playersTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier)! as UITableViewCell
            
        // set the text from the data model
        cell.textLabel?.text = self.players[indexPath.row].name
        
        // add border and color
        cell.textLabel?.textColor = UIColor.black
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
            
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
    }
    
    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {

        // remove the item from the data model
        self.players.remove(at: indexPath.row)

        // delete the table view row
        self.playersTable.deleteRows(at: [indexPath], with: .fade)

        } else if editingStyle == .insert {
            // Not used in our example, but if you were adding a new row, this is where you would do it.
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is SelectColorViewController {
            let vc = segue.destination as? SelectColorViewController
            vc?.players = self.players
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if self.players.isEmpty {
            let alertController = UIAlertController(
                title: "No players added",
                message: "You need to add players via the textfield.",
                        preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))

                    present(alertController, animated: true, completion: nil)
                    return false
        }
        return true
    }
}

