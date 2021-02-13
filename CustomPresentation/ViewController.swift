//
//  ViewController.swift
//  CustomPresentation
//
//  Created by 박찬웅 on 2021/02/12.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.modalPresentationStyle = .custom
        segue.destination.transitioningDelegate = self
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


extension ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SimplePresentationController(presentedViewController: presented, presenting: presenting)
    }
}

