//
//  GPCollectionViewCell.swift
//  GPVideoEditor
//
//  Created by Glenn Posadas on 12/09/2019.
//  Copyright © 2019 Glenn Posadas. All rights reserved.
//

 import UIKit

class GPCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier: String! {
        get {
            return "\(self.typeName(self))"
        }
    }
    
    // MARK: - Functions
    
    private static func typeName(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }    
}

