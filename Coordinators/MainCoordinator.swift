//
//  MainCoordinator.swift
//  Coordinators
//
//  Created by Frank Noodlewerk on 02/05/2017.
//  Copyright © 2017 Frank Noodlewerk. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinating {
    let root: UIViewController
    
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

    let starting: Starting?
    let ending: Ending?
    
    var flowCoordinator : FlowCoordinator?
    
    var currentChildViewController: UIViewController? {
        didSet {
            configure(currentChildViewController: currentChildViewController)            
        }
    }
    
    init(root: UIViewController) {
        self.root = root
        self.starting = nil
        self.ending = nil
    }
    
    func configure(currentChildViewController: UIViewController?) {
        if let viewController = currentChildViewController as? MainViewController {
            viewController.modalTapped = startModalFlow
            viewController.detailTapped = startDetailFlow
        }
    }
    
    func startModalFlow() {
        guard let viewController = currentChildViewController else {
            return
        }
        flowCoordinator = FlowCoordinator(root: viewController, starting: .present, ending: .dismiss)
        flowCoordinator?.begin(animated: true)
    }
    
    func startDetailFlow() {
        guard let viewController = currentChildViewController else {
            return
        }
        flowCoordinator = FlowCoordinator(root: viewController, starting: .show, ending: .popToRoot)
        flowCoordinator?.begin(animated: true)
        
    }
    
}
