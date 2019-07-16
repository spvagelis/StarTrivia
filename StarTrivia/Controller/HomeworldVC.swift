//
//  HomeworldVC.swift
//  StarTrivia
//
//  Created by vagelis spirou on 11/07/2019.
//  Copyright © 2019 vagelis spirou. All rights reserved.
//

import UIKit

class HomeworldVC: UIViewController, PersonProtocol {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var climateLbl: UILabel!
    @IBOutlet weak var terrainLbl: UILabel!
    @IBOutlet weak var populationLbl: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    var person: Person!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.startAnimating()
        
        let urlString = person.homeworldUrl
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            if let url = URL(string: urlString) {
                
                if let data = try? Data(contentsOf: url) {
                    
                    self.parseHomeworld(json: data)
                    
                }
            }
            
        }
    }
    
    func parseHomeworld(json: Data) {
        
        let decoder = JSONDecoder()
        
        do {
            
            let homeworld = try decoder.decode(Homeworld.self, from: json)
            
            DispatchQueue.main.async {
                
                self.spinner.stopAnimating()
             
                self.updateUI(homeworld: homeworld)
                
            }
            
        } catch {
            
            debugPrint(error.localizedDescription)
            
        }
    }
    
    func updateUI(homeworld: Homeworld) {
        
        nameLbl.text = homeworld.name
        climateLbl.text = homeworld.climate
        terrainLbl.text = homeworld.terrain
        populationLbl.text = homeworld.population
        
    }

}
