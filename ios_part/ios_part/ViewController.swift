//
//  ViewController.swift
//  ios_part
//
//  Created by 菊池 紘 on 2020/09/16.
//  Copyright © 2020 菊池 紘. All rights reserved.
//

import UIKit
import Flutter
import FirebaseFirestore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let flutterButton = UIButton(type:UIButton.ButtonType.custom)
        flutterButton.addTarget(self, action: #selector(showFlutter), for: .touchUpInside)
        flutterButton.setTitle("Show Flutter!", for: UIControl.State.normal)
        flutterButton.frame = CGRect(x: 0.0, y: 50.0, width: 160.0, height: 40.0)
        flutterButton.backgroundColor = UIColor.blue
        self.view.addSubview(flutterButton)
        
        let firestoreButton = UIButton(type:UIButton.ButtonType.custom)
        firestoreButton.addTarget(self, action: #selector(increment), for: .touchUpInside)
        firestoreButton.setTitle("Increment count on Firebase", for: UIControl.State.normal)
        firestoreButton.frame = CGRect(x: 200.0, y: 50.0, width: 160.0, height: 40.0)
        firestoreButton.backgroundColor = UIColor.orange
        self.view.addSubview(firestoreButton)
    }

    @objc func showFlutter() {
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        let flutterViewController =
          FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        present(flutterViewController, animated: true, completion: nil)
    }
    
    @objc func increment() {
        let doc = Firestore.firestore().document("/counter/1")
        doc.setData(["count": FieldValue.increment(1 as Int64)], merge: true)
        
    }
}

