//
//  Constants.swift
//  StarTrivia
//
//  Created by vagelis spirou on 09/07/2019.
//  Copyright © 2019 vagelis spirou. All rights reserved.
//

import UIKit

let BLACK_BG = UIColor.black.withAlphaComponent(0.6).cgColor

let BASE_URL = "https://swapi.co/api/"
let PERSON_URL = BASE_URL + "people/1/"

typealias PersonResponseCompletion = (Person?) -> Void
