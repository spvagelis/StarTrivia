//
//  FilmsVC.swift
//  StarTrivia
//
//  Created by vagelis spirou on 11/07/2019.
//  Copyright © 2019 vagelis spirou. All rights reserved.
//

import UIKit

class FilmsVC: UIViewController, PersonProtocol {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var episodeLbl: UILabel!
    @IBOutlet weak var directorLbl: UILabel!
    @IBOutlet weak var producerLbl: UILabel!
    @IBOutlet weak var releasedLbl: UILabel!
    @IBOutlet weak var crawlLbl: UITextView!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    var person: Person!
    var films = [String]()
    var currentFilm = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.startAnimating()
        
        films = person.filmUrls
        previousBtn.isEnabled = false
        nextBtn.isEnabled = films.count > 1
        
        guard let firstFilm = films.first else { return }
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            if let url = URL(string: firstFilm) {
                
                if let data = try? Data(contentsOf: url) {
                    
                    
                    self.parseFilm(json: data)
                }
            }
        }
    }
    
    func parseFilm(json: Data) {
        
        
        
      let decoder = JSONDecoder()
        
        do {
            
            let film = try decoder.decode(Film.self, from: json)
            
            DispatchQueue.main.async {
                
                self.spinner.stopAnimating()
                
                self.updateUI(film: film)
                
            }
            
        } catch {
            
            debugPrint(error.localizedDescription)
            
        }
        
        
    }
    
    func updateUI(film: Film) {
        
        titleLbl.text = film.title
        episodeLbl.text = String(film.episode)
        directorLbl.text = film.director
        producerLbl.text = film.producer
        releasedLbl.text = film.releaseDate
        let stripped = film.crawl.replacingOccurrences(of: "\n", with: " ")
        crawlLbl.text = stripped.replacingOccurrences(of: "\r", with: "")
        
    }
    
    func setButtonState() {
        
        spinner.startAnimating()
        
        previousBtn.isEnabled = currentFilm == 0 ? false : true
        nextBtn.isEnabled = currentFilm == films.count - 1 ? false : true
        
        let film = films[currentFilm]
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            if let url = URL(string: film) {
                
                if let data = try? Data(contentsOf: url) {
                    
                    self.parseFilm(json: data)
                    
                }
            }
            
        }
        
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        
        currentFilm += 1
        setButtonState()
        
    }
    
    @IBAction func previousBtnPressed(_ sender: Any) {
        
        currentFilm -= 1
        setButtonState()
        
    }

}
