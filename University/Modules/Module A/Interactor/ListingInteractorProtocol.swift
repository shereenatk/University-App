//
//  ListingInteractorProtocol.swift
//  University
//
//  Created by ios on 07/05/2024.
//

import UIKit
import CoreData

protocol ListingInteractorProtocol {
    var presenter: ListingPresenterProtocol? { get set }
    
    func fetchDataFromAPI()
    func fetchDataFromCoreData()
}

class ListingInteractor: ListingInteractorProtocol {
    var presenter: ListingPresenterProtocol?
    
    func fetchDataFromAPI() {
        guard let url = URL(string: "http://universities.hipolabs.com/search?country=United%20Arab%20Emirates") else {
            presenter?.view?.displayError(message: "Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let self = self else { return }
                if let error = error {
                    self.presenter?.view?.displayError(message: error.localizedDescription)
                    return
                }
                
                guard let data = data else {
                    self.presenter?.view?.displayError(message: "No data received")
                    return
                }
                
                do {
                    print(data)
                    let universitiesDTO = try JSONDecoder().decode([UniversityDTO].self, from: data)
                    let universities = universitiesDTO.map { dto in
                        // Create University managed objects from DTOs
                        let university = University(context: CoreDataStack.shared.context)
                        university.update(with: dto)
                        return university
                    }
                    self.saveToCoreData(universities: universities)
                    self.presenter?.view?.displayData(data: universities)
                } catch {
                    print( error.localizedDescription)
                    self.presenter?.view?.displayError(message: error.localizedDescription)
                }
            }.resume()
        }
    
    func fetchDataFromCoreData() {
        let fetchRequest = University.fetchRequest() as NSFetchRequest<University>
            do {
                let universities = try CoreDataStack.shared.context.fetch(fetchRequest)
                print(universities.first?.alphaTwoCode)
                self.presenter?.view?.displayData(data: universities)
            } catch {
                self.presenter?.view?.displayError(message: error.localizedDescription)
            }
    }
    
    private func saveToCoreData(universities: [University]) {
        let context = CoreDataStack.shared.context
        for university in universities {
            let universityObject = University(context: context)
            universityObject.id = university.id
            universityObject.stateProvince = university.stateProvince
//            universityObject.domains = university.domains
//            universityObject.webPages = university.webPages
            universityObject.name = university.name
            universityObject.alphaTwoCode = university.alphaTwoCode
            universityObject.country = university.country
        }
        CoreDataStack.shared.saveContext()
    }
}
