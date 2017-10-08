//
//  FlowCoordinator.swift
//  Coordinators
//
//  Created by Frank Noodlewerk on 05/04/2017.
//  Copyright © 2017 Frank Noodlewerk. All rights reserved.
//

import UIKit

class FlowCoordinator: Coordinating {
    let root: UIViewController
    
    let storyboard = UIStoryboard(name: "CoordinatedFlow", bundle: Bundle.main)

    let starting: Starting?
    let ending: Ending?
    
    var currentChildViewController: UIViewController? {
        didSet {
            configure(currentChildViewController: currentChildViewController)
        }
    }
    
    var subFlowCoordinator : SubFlowCoordinator?
    
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
        
        if let viewController = currentChildViewController as? BlueViewController {
            
            if let starting = starting {
                switch starting {
                case .present:
                    viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "close", style: .plain, target: self, action: #selector(FlowCoordinator.closeModal))
                default:
                    break
                }
            }
        }
        
        if let viewController = currentChildViewController as? RedViewController {
            viewController.performAction = startSubFlow
        }
                
        if let viewController = currentChildViewController as? GreenViewController {
            viewController.nextStep = stop
        }
    }
    
    func startSubFlow() {
        guard  let viewController = currentChildViewController else {
            return
        }
        subFlowCoordinator = SubFlowCoordinator(root: viewController, starting: .show, ending: .custom(continueFlow))
        subFlowCoordinator?.begin(animated: true)
    }
    
    func continueFlow(from viewcontroller: UIViewController) {
        let greenViewController = storyboard.instantiateViewController(withIdentifier: "GreenViewController")
        currentChildViewController = greenViewController
        viewcontroller.show(greenViewController, sender: nil)
        
    }
    
    @objc func closeModal() {
        stop()
    }
    
}
