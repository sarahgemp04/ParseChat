//
//  ChatViewController.swift
//  ParseApp
//
//  Created by Sarah Gemperle on 4/3/19.
//  Copyright © 2019 Sarah Gemperle. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var messages: [PFObject]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let messages = self.messages {
            print(messages.count)
            return messages.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "chatCell") as! ChatCellTableViewCell
        
        if let messages = self.messages {
            let message = messages[indexPath.row]
            print(message)
            cell.messageLabel.text = message["text"] as! String
            if let user = message["user"] as? PFUser {
                cell.userLabel.text = user.username
            } else {
                cell.userLabel.text = "🤖"
            }
        } else {
            print("error loading cell.")
        }
        
        return cell
    }
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
        tableView.separatorStyle = .none
        
        // Auto size row height based on cell autolayout constraints
        chatTableView.rowHeight = UITableView.automaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        chatTableView.estimatedRowHeight = 50
    }
    
    @objc func onTimer() {
        // construct query
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        query.limit = 20
        
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                // The find succeeded.
                self.messages = []
                
                if let objects = objects {
                    self.messages = objects
                }
                
                self.chatTableView.reloadData()
            } else {
                // Log details of the failure
                print("Error: \(error!.localizedDescription)")
            }
        }
    }
    
    @IBAction func didSend(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = messageTextField.text ?? ""
        chatMessage["user"] = PFUser.current()
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.messageTextField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
                let alert = UIAlertController(title: "Error Sending Message", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
