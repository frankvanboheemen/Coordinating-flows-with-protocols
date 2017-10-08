//
//  MainViewController.swift
//  Coordinators
//
//  Created by Frank Noodlewerk on 02/05/2017.
//  Copyright © 2017 Frank Noodlewerk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @objc var modalTapped : (() -> ())?
    @objc var detailTapped : (() -> ())?
    
    @IBAction func showModalButtonTapped(_ sender: Any) {
        modalTapped?()
    }
    
    @IBAction func showDetailButtonTapped(_ sender: Any) {
        detailTapped?()
    }
    
}
