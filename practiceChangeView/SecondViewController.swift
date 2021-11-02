//
//  SecondViewController.swift
//  practiceChangeView
//
//  Created by 양호준 on 2021/11/02.
//

import UIKit

class SecondViewController: UIViewController {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        print("second init")
    }
    
    override func loadView() {
        super.loadView()
        
        print("second loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("second viewDidLoad")
    }

    override func viewWillAppear(_ animated: Bool) {
        print("second viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("second viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("second viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("second viewDidDisappear")
    }
    
    deinit {
        print("second deinit")
    }
    
    @IBAction func touchUpDismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
