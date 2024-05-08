//
//  ListingPresenterProtocol.swift
//  University
//
//  Created by ios on 07/05/2024.
//

import Foundation
protocol ListingPresenterProtocol {
    var view: ListingViewProtocol? { get set }
    var interactor: ListingInteractorProtocol { get }
    var router: ListingRouterProtocol? { get set }
    
    func fetchData()
}

class ListingPresenter: ListingPresenterProtocol {
    weak var view: ListingViewProtocol?
    var interactor: ListingInteractorProtocol
    var router: ListingRouterProtocol?
    var reachability: ReachabilityProtocol

    init(reachability: ReachabilityProtocol, interactor: ListingInteractorProtocol) {
        self.reachability = reachability
        self.interactor = interactor
        self.interactor.presenter = self
    }
    
    func fetchData() {
        if reachability.isConnectedToNetwork() {
            interactor.fetchDataFromAPI()
        } else {
            interactor.fetchDataFromCoreData()
        }
    }
}
