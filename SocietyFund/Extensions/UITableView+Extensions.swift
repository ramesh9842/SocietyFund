//
//  UITableView+Extensions.swift
//  SocietyFund
//
//  Created by sanish on 9/6/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit


extension UITableView {
    func tableViewCellForLastRow() -> UITableViewCell? {
        let lastSectionIndex = self.numberOfSections - 1
        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1
        let pathToLastRow = IndexPath(row: lastRowIndex, section: lastSectionIndex)
        return self.cellForRow(at: pathToLastRow)
    }
}
