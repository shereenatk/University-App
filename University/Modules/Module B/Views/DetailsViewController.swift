//
//  DetailsViewController.swift
//  University
//
//  Created by ios on 08/05/2024.
//

import Foundation
import UIKit
protocol DetailsViewProtocol: AnyObject {
    func displayUniversityDetails(_ university: University)
}

class DetailsViewController: UIViewController, DetailsViewProtocol {
    
    var presenter: DetailsPresenterProtocol?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var countryCode: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    func displayUniversityDetails(_ university: University) {
        DispatchQueue.main.async {
            self.nameLabel.text = university.name
            self.stateLabel.text = university.stateProvince ?? "NA"
            self.countryCode.text = university.alphaTwoCode ?? ""
            self.countryLabel.text = university.country ?? ""
        }
    }
}
