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
    
    let socket = SocketIOClient(socketURL: "localhost:3000")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        socketToMe()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func send() {
//        self.socket.emit("chat message", self.sendField.text!)
        self.socket.emit("chat message", withItems: [self.sendField.text!])
    }

    func socketToMe() {
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        self.socket.on("") {data, ack in
            self.socket.emitWithAck("", data)(timeoutAfter: 0) { _ in }
        }
        
        self.socket.on("chat message") { data, ack in
            if let value = data.first as? String {
                self.chatView.text?.appendContentsOf(value + "\n")
            }
        }
        
        self.socket.connect()
    }
}

