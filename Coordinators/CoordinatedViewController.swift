//
//  CoordinatedViewController.swift
//  FeedMe
//
//  Created by Noodlewerk on 25/11/16.
//  Copyright © 2016 Noodlewerk Apps. All rights reserved.
//

import UIKit

//This class is meant as superclass for every viewcontroller in the coordinated flows.
class CoordinatedViewController: UIViewController {
 
    @objc var nextStep: (() -> ())?
    @objc var nextDestination: ((_ nextVC: UIViewController) -> ())?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        nextDestination?(segue.destination)
    }
}
