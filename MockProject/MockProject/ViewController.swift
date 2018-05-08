//
//  ViewController.swift
//  MockProject
//
//  Created by Vincent on 08/05/2018.
//  Copyright © 2018 Vincent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label1.text = NSLocalizedString("key1", comment: "")
        label2.text = NSLocalizedString("key2", comment: "")
        label3.text = NSLocalizedString("key3", comment: "")
    }
}

