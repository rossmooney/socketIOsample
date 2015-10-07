//
//  ViewController.swift
//  SocketSample
//
//  Created by Ross M Mooney on 10/5/15.
//  Copyright © 2015 BoomTown. All rights reserved.
//

import UIKit
import Socket_IO_Client_Swift

class ViewController: UIViewController {

    @IBOutlet weak var chatView:UITextView!
    @IBOutlet weak var sendButton:UIButton!
    @IBOutlet weak var sendField:UITextField!
    
    let socket = SocketIOClient(socketURL: "10.0.0.8:8080", opts: ["log": true])

    override func viewDidLoad() {
        super.viewDidLoad()

        addHandlers()
        self.socket.connect()
    }

    @IBAction func send() {
        self.socket.emit("chat message", withItems: [self.sendField.text!])
        self.sendField.text = ""
        self.sendField.resignFirstResponder()
    }

    func addHandlers() {
        self.socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        self.socket.on("chat message") { data, ack in
            if let value = data.first as? String {
                self.chatView.text?.appendContentsOf(value + "\n")
            }
        }
    }
}

