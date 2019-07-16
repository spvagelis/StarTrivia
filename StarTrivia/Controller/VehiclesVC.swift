//
//  VehiclesVC.swift
//  StarTrivia
//
//  Created by vagelis spirou on 11/07/2019.
//  Copyright © 2019 vagelis spirou. All rights reserved.
//

import UIKit

class VehiclesVC: UIViewController,PersonProtocol {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var makerLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var lengthLbl: UILabel!
    @IBOutlet weak var speedLbl: UILabel!
    @IBOutlet weak var crewLbl: UILabel!
    @IBOutlet weak var passengersLbl: UILabel!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    var person: Person!
    var vehicles = [String]()
    var currentVehicle = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.startAnimating()
        
        vehicles = person.vehicleUrls
        nextBtn.isEnabled = vehicles.count > 1
        previousBtn.isEnabled = false
        print(vehicles)
        guard let firstVehicle = vehicles.first else { return }
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            if let url = URL(string: firstVehicle) {
                
                if let data = try? Data(contentsOf: url) {
                    
                    self.parseVehicle(json: data)
                    
                }
            }
        }
        
    }
    
    func parseVehicle(json: Data) {
        
        let decoder = JSONDecoder()
        
        do {
            
            let vehicle = try decoder.decode(Vehicle.self, from: json)
            
            DispatchQueue.main.async {
                
                self.spinner.stopAnimating()
                
                self.updateUI(vehicle: vehicle)
                
            }
            
        } catch {
            
            debugPrint(error.localizedDescription)
            
        }
        
    }
    
    func updateUI(vehicle: Vehicle) {
        
        nameLbl.text = vehicle.name
        modelLbl.text = vehicle.model
        makerLbl.text = vehicle.manufacturer
        costLbl.text = vehicle.cost
        lengthLbl.text = vehicle.length
        speedLbl.text = vehicle.speed
        crewLbl.text = vehicle.crew
        passengersLbl.text = vehicle.passengers
        
    }
    
    @IBAction func previousBtnPressed(_ sender: Any) {
        
        currentVehicle -= 1
        setButtonState()
        
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        
        currentVehicle += 1
        setButtonState()
        
    }
    
    func setButtonState() {
        
        spinner.startAnimating()
        nextBtn.isEnabled = currentVehicle == vehicles.count - 1 ? false : true
        previousBtn.isEnabled = currentVehicle == 0 ? false : true
        
//        if currentVehicle == 0 {
//
//            previousBtn.isEnabled = false
//
//        } else {
//
//            previousBtn.isEnabled = true
//
//        }
//
//        if currentVehicle == vehicles.count - 1 {
//
//            nextBtn.isEnabled = false
//
//        } else {
//
//            nextBtn.isEnabled = true
//
//        }
        
        let vehicle = vehicles[currentVehicle]
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            if let url = URL(string: vehicle) {
                
                if let data = try? Data(contentsOf: url) {
                    
                    self.parseVehicle(json: data)
                    
                }
            }
        }
        
    }
    
}
