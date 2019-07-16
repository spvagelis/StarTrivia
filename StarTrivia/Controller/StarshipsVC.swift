//
//  StarshipsVC.swift
//  StarTrivia
//
//  Created by vagelis spirou on 11/07/2019.
//  Copyright © 2019 vagelis spirou. All rights reserved.
//

import UIKit

class StarshipsVC: UIViewController, PersonProtocol {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var makerLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var lengthLbl: UILabel!
    @IBOutlet weak var speedLbl: UILabel!
    @IBOutlet weak var crewLbl: UILabel!
    @IBOutlet weak var passengersLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    var person: Person!
    var starships = [String]()
    var currestStarship = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.startAnimating()
        
        starships = person.starshipUrls
        previousBtn.isEnabled = false
        nextBtn.isEnabled = starships.count > 1
        
        guard let firstStarship = starships.first else { return }
        
        print(firstStarship)
        
            DispatchQueue.global(qos: .userInitiated).async {
            
            if let url = URL(string: firstStarship) {
                    
                    if let data = try? Data(contentsOf: url) {
                     
                        self.parseStarship(json: data)
                }
            }
        }
    }
    
    func parseStarship(json: Data) {
        
        let decoder = JSONDecoder()
        
        do {
            
            let starship = try decoder.decode(Starship.self, from: json)
            
            DispatchQueue.main.async {
                
                self.spinner.stopAnimating()
                
                self.updateUI(starship: starship)
                
            }
            
        } catch {
            
            debugPrint(error.localizedDescription)
            
        }
        
    }
    
    func updateUI(starship: Starship) {
        
        nameLbl.text = starship.name
        modelLbl.text = starship.model
        makerLbl.text = starship.maker
        costLbl.text = starship.cost
        lengthLbl.text = starship.length
        speedLbl.text = starship.speed
        crewLbl.text = starship.crew
        passengersLbl.text = starship.passengers
        
    }
    
    func setButtonState() {
        
        spinner.startAnimating()
        previousBtn.isEnabled = currestStarship == 0 ? false : true
        nextBtn.isEnabled = currestStarship == starships.count - 1 ? false : true
        
//        if currestStarship == 0 {
//
//            previousBtn.isEnabled = false
//
//        } else {
//
//            previousBtn.isEnabled = true
//
//        }
//
//        if currestStarship == starships.count - 1 {
//
//            nextBtn.isEnabled = false
//
//        } else {
//
//            nextBtn.isEnabled = true
//
//        }
        
        let starship = starships[currestStarship]
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            if let url = URL(string: starship) {
                
                if let data = try? Data(contentsOf: url) {
                    
                    self.parseStarship(json: data)
                    
                }
            }
            
        }
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        
        currestStarship += 1
        setButtonState()
        
    }
    
    @IBAction func previousBtnPressed(_ sender: Any) {
        
        currestStarship -= 1
        setButtonState()
        
    }
    
}
