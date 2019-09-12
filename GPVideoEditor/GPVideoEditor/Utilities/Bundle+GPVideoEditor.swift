//
//  Bundle+GPVideoEditor.swift
//  GPVideoEditor
//
//  Created by Glenn Posadas on 12/09/2019.
//  Copyright © 2019 Glenn Posadas. All rights reserved.
//

import Foundation

extension Bundle {
    /// Gets the name of the app - title under the icon.
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
            object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}
