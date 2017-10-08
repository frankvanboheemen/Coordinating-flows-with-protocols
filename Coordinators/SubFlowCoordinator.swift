//
//  SubFlowCoordinator.swift
//  Coordinators
//
//  Created by Frank Noodlewerk on 02/05/2017.
//  Copyright © 2017 Frank Noodlewerk. All rights reserved.
//

import UIKit

class SubFlowCoordinator: Coordinating {
    let root: UIViewController
    
    let storyboard = UIStoryboard(name: "CoordinatedSubFlow", bundle: Bundle.main)
    
    let starting: Starting?
    let ending: Ending?
    
    var currentChildViewController: UIViewController? {
        didSet {
            configure(currentChildViewController: currentChildViewController)
        }
    }
    
    init(root: UIViewController, starting: Starting, ending: Ending) {
        self.root = root
        self.starting = starting
        self.ending = ending
    }
    
    func configure(currentChildViewController: UIViewController?) {
        
        if let viewController = currentChildViewController as? CoordinatedViewController {
            viewController.nextStep = performNextStepSegue
            viewController.nextDestination = nextDestination
        }
        
        if let viewController = currentChildViewController as? PurpleViewController {
            viewController.nextStep = stop
        }
    }
}
