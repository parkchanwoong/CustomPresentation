//
//  SimplePresentationController.swift
//  CustomPresentation
//
//  Created by 박찬웅 on 2021/02/12.
//

import UIKit

class SimplePresentationController: UIPresentationController {
    let dimmingView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    let closeButton = UIButton(type: .custom)
    var closeButtonTopConstraint: NSLayoutConstraint?
    
    let workaroundView = UIView()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        closeButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        closeButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func dismiss() {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
    
    // 원하는 프레임 설정 가능
    override var frameOfPresentedViewInContainerView: CGRect {
        print(String(describing: type(of: self)), #function)
        guard var frame = containerView?.frame else { return .zero }
        
        frame.origin.y = frame.size.height / 2
        frame.size.height = frame.size.height / 2
        
        return frame
        
    }
    // 애니메이션에서 필요한 설정 구현
    override func presentationTransitionWillBegin() {
        print("\n\n")
        print(String(describing: type(of: self)), #function)
        
        guard let containerView = containerView else { fatalError() }
        
        dimmingView.alpha = 0.0
        dimmingView.frame = containerView.bounds
        containerView.insertSubview(dimmingView, at: 0)
        
        workaroundView.frame = dimmingView.bounds
        workaroundView.isUserInteractionEnabled = false
        containerView.insertSubview(workaroundView, aboveSubview: dimmingView)
        
        containerView.addSubview(closeButton)
        closeButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        closeButtonTopConstraint = closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -80)
        closeButtonTopConstraint?.isActive = true
        containerView.layoutIfNeeded()
        
        closeButtonTopConstraint?.constant = 60
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            presentingViewController.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            containerView.layoutIfNeeded()
            return
        }
        
        coordinator.animate { (context) in
            self.dimmingView.alpha = 0.0
            self.presentingViewController.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            containerView.layoutIfNeeded()
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        print(String(describing: type(of: self)), #function)
    }
    
    override func dismissalTransitionWillBegin() {
        print(String(describing: type(of: self)), #function)
        
        closeButtonTopConstraint?.constant = -80
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            presentingViewController.view.transform = CGAffineTransform.identity
            containerView?.layoutIfNeeded()
            return
        }
        
        coordinator.animate { (context) in
            self.dimmingView.alpha = 0.0
            self.presentingViewController.view.transform = CGAffineTransform.identity
            self.containerView?.layoutIfNeeded()
        }

        
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        print(String(describing: type(of: self)), #function)
    }
    
    override func containerViewWillLayoutSubviews() {
        print(String(describing: type(of: self)), #function)
        
        presentedView?.frame = frameOfPresentedViewInContainerView
        dimmingView.frame = containerView!.bounds
    }
    
    override func containerViewDidLayoutSubviews() {
        print(String(describing: type(of: self)), #function)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        presentingViewController.view.transform = CGAffineTransform.identity
        
        coordinator.animate { (context) in
            self.presentingViewController.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }

    }
    

}
