//
//  ListingViewController.swift
//  University
//
//  Created by ios on 07/05/2024.
//

import UIKit

protocol ListingViewProtocol: class {
    func displayData(data: [University])
    func displayError(message: String)
}
class ListingViewController: UIViewController, ListingViewProtocol {
    var presenter: ListingPresenterProtocol?
    var universities: [University] = []
    @IBOutlet weak var universityTableView: UITableView!
     var refreshControl = UIRefreshControl()
    let reachability = Reachability()
    let interactor = ListingInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ListingPresenter(reachability: reachability, interactor: interactor)
        presenter?.view = self
        universityTableView.dataSource = self
        universityTableView.delegate = self
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        universityTableView.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.fetchData()
    }
    
    func displayData(data: [University]) {
        DispatchQueue.main.async {
            self.universities = data
            self.universityTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func displayError(message: String) {
        // Display error message
    }
    
    @objc private func refreshData() {
        presenter?.fetchData()
    }
    
}

extension ListingViewController: UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UniversityTableViewCell", for: indexPath) as! UniversityTableViewCell
        DispatchQueue.main.async {
            let university = self.universities[indexPath.row]
            cell.nameLabel.text = university.name
            cell.stateLabel.text = university.stateProvince ?? "N/A"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUniversity = universities[indexPath.row]
        let detailsViewController = DetailsRouter.createDetailsModule(with: selectedUniversity)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
