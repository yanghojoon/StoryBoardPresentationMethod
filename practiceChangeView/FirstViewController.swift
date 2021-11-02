//
//  ViewController.swift
//  practiceChangeView
//
//  Created by 양호준 on 2021/11/02.
//

import UIKit

class ViewController: UIViewController {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        print("first init")
    }
    
    override func loadView() {
        super.loadView()
        
        print("first loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("first viewDidLoad")
    }

    override func viewWillAppear(_ animated: Bool) {
        print("first viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("first viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("first viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("first viewDidDisappear")
    }
    
    deinit {
        print("first deinit")
    }
}

