//
//  Coordinating.swift
//  FeedMe
//
//  Created by Noodlewerk on 21/11/16.
//  Copyright © 2016 Noodlewerk Apps. All rights reserved.
//

import UIKit

protocol Coordinating: class {
    associatedtype ViewController: UIViewController

    var root: ViewController { get }
    
    var storyboard: UIStoryboard { get }
    
    var starting: Starting? { get }
    var ending: Ending? { get }
    
    var currentChildViewController: ViewController? { get set }
    
    func configure(currentChildViewController: UIViewController?)
    
    func getInitialChildViewController() -> ViewController
}

enum Starting {
    case show
    case present
}

enum Ending {
    case dismiss
    case popToRoot
    case custom(((_ vc: UIViewController) -> ())?) // investigate if 'custom(((_ vc: UIViewController?) -> ())?)' is also possible
}


extension Coordinating {
    //These methods can be overwritten by a coordinator
    func configure(with nav: UINavigationController, and childVC: UIViewController) {
    }
    
    func getInitialChildViewController() -> UIViewController {
        
        let firstViewController: UIViewController
        
        if let initialViewController = storyboard.instantiateInitialViewController() {
            firstViewController = initialViewController
        } else {
            firstViewController = UIViewController()
        }
    
        return firstViewController
    }

    func show(vc: UIViewController) {
        root.show(vc, sender: self)
    }
    func presentModally(nav: UINavigationController, animated: Bool) {
        root.present(nav, animated: animated, completion: nil)
    }
    func dismiss() {
        root.dismiss(animated: true, completion: nil)
    }
    
    func popToRoot() {
        _ = currentChildViewController?.navigationController?.popToRootViewController(animated: true)
    }
    
    //These methods make sense in combination with a linear flow defined in storyboard
    func performNextStepSegue() -> () {
        guard let viewController = currentChildViewController else {
            print("no current viewcontroller")
            return
        }
        viewController.performSegue(withIdentifier: "nextStep", sender: nil)
    }
    
    func nextDestination(viewController: ViewController) {
        currentChildViewController = viewController
    }
    
    func finalStep(vc: UIViewController) -> () {
        self.stop()
    }
}

extension Coordinating {
    // Lifecycle methods of a coordinator - DO NOT OVERRIDE
    func begin(animated: Bool) {
        let initialViewController: ViewController
        
        guard let starting = starting else {
            initialViewController = root
            self.currentChildViewController = initialViewController
            return
        }
        
        initialViewController = getInitialChildViewController()
        self.currentChildViewController = initialViewController

        switch starting {
        case .show:
            show(vc: initialViewController)
            
        case .present:
            let nav = UINavigationController()
            nav.addChildViewController(initialViewController)
            configure(with: nav, and: initialViewController)
            presentModally(nav: nav, animated: animated)
            
        }
    }

    func stop() {
        guard let ending = ending else {
            print("No ending defined")
            return
        }
        switch ending {
        case .dismiss:
            dismiss()
            
        case .popToRoot:
            popToRoot()
            
        case .custom(let ending):
            
            guard let currentChildViewController = currentChildViewController else {
                print("no current child view controller")
                return
            }
            
            ending?(currentChildViewController)
        }
    }
}
