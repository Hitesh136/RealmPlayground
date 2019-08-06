//
//  Extension.swift
//  RealmPlayground
//
//  Created by Hitesh  Agarwal on 04/08/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import Foundation
import UIKit


extension UITableView {
  func applychanges(section: Int = 0, deletions: [Int], insertions: [Int], updates: [Int]) {
    beginUpdates()
    deleteRows(at: deletions.map(IndexPath.fromRow), with: .automatic)
    insertRows(at: insertions.map(IndexPath.fromRow), with: .automatic)
    reloadRows(at: updates.map(IndexPath.fromRow), with: .automatic)
    endUpdates()
  }
}


