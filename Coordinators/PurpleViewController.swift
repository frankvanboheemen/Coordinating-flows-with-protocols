//
//  PurpleViewController.swift
//  Coordinators
//
//  Created by Frank Noodlewerk on 02/05/2017.
//  Copyright © 2017 Frank Noodlewerk. All rights reserved.
//

import UIKit

class PurpleViewController: CoordinatedViewController {

    @IBAction func nextButtonTapped(_ sender: Any) {
        
        // save results or do whatever the goal is of this viewcontroller
        
        nextStep?()
    }
}
