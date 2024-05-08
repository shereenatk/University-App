//
//  DetailsRouter.swift
//  University
//
//  Created by ios on 08/05/2024.
//

import Foundation
import UIKit
protocol DetailsRouterProtocol: AnyObject {
    static func createDetailsModule(with university: University) -> UIViewController
}

class DetailsRouter: DetailsRouterProtocol {
    static func createDetailsModule(with university: University) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let viewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
           let presenter = DetailsPresenter(view: viewController, university: university)
           viewController.presenter = presenter
           return viewController
    }
}
