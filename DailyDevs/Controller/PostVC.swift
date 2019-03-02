//
//  PostVC.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 01/03/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit
import Firebase
class PostVC: UIViewController {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postTextView.delegate = self
        sendButton.bindToKeyboard()
    }
    
    
    @IBAction func sendNewPost(_ sender: Any) {
        if postTextView.text != "" && postTextView.text != "Add new post here ..." {
            sendButton.isEnabled = false
            DataService.instance.createNewPost(withMessage: postTextView.text, fromUID: (Auth.auth().currentUser?.uid)!, groupKey: "") { (success) in
                
                if success {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension PostVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        postTextView.text = ""
    }
}
