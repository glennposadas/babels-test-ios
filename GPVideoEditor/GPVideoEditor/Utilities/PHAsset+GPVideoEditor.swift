//
//  PHAsset+GPVideoEditor.swift
//  GPVideoEditor
//
//  Created by Glenn Posadas on 12/09/2019.
//  Copyright © 2019 Glenn Posadas. All rights reserved.
//

import Foundation
import Photos

extension PHAsset {
    /// Synchronously fetches the `UIImage` representation of a `PHAsset`.
    var thumbnail: UIImage {
        get {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var thumbnail = UIImage()
            option.isSynchronous = true
            manager.requestImage(for: self, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                thumbnail = result!
            })
            return thumbnail
        }
    }
    
    /// Get the representable duration of the video.
    var durationRepresentable: String {
        get {
            let durationRounded = String(format: "%.1f", self.duration)
            return self.mediaType == .video ? "\(durationRounded)S" : ""
        }
    }
}
