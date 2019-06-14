//
//  UITableView+extension.swift
//  Finstro
//
//  Created by Erick Vavretchek on 6/5/19.
//  Copyright © 2019 Finstro. All rights reserved.
//

import UIKit

extension UITableView {
    
    enum ReloadAnimationType {
        case up
        case down
        case left
        case right
        case none
    }
    
    func reload(animationDirection: ReloadAnimationType) {
        reloadData()
        layoutIfNeeded()
        let cells = self.visibleCells
        var index = 0
        let tableHeight: CGFloat = self.bounds.size.height
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            switch animationDirection {
            case .up:
                cell.transform = CGAffineTransform(translationX: 0, y: -tableHeight)
                break
            case .down:
                cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
                break
            case .left:
                cell.transform = CGAffineTransform(translationX: tableHeight, y: 0)
                break
            case .right:
                cell.transform = CGAffineTransform(translationX: -tableHeight, y: 0)
                break
            default:
                cell.transform = CGAffineTransform(translationX: tableHeight, y: 0)
                break
            }
            
            UIView.animate(withDuration: 0.5,
                           delay: 0.05 * Double(index),
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseIn,
                           animations: { cell.transform = CGAffineTransform(translationX: 0, y: 0) },
                           completion: nil)
            index += 1
        }
    }
}
