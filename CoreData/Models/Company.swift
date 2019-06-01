//
//  Company.swift
//  CoreData
//
//  Created by We//Yes on 25/05/2019.
//  Copyright © 2019 Daniil Vereschagin. All rights reserved.
//

import Foundation
import UIKit

struct Company: Codable {
    let name: String
    let founded: Date
    let image: Data?
}
