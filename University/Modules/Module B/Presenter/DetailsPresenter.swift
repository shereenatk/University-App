//
//  DetailsPresenter.swift
//  University
//
//  Created by ios on 08/05/2024.
//

import Foundation
protocol DetailsPresenterProtocol: AnyObject {
    var view: DetailsViewProtocol? { get set }
    var university: University { get }

    // Presenter to View
    func viewDidLoad()
}

class DetailsPresenter: DetailsPresenterProtocol {
    weak var view: DetailsViewProtocol?
    var university: University

    init(view: DetailsViewProtocol, university: University) {
        self.view = view
        self.university = university
    }

    func viewDidLoad() {
        view?.displayUniversityDetails(university)
    }
}
