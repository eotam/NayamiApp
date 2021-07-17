//
//  CheckPermission.swift
//  NayamiApp
//
//  Created by yamaguchi iori on 2021/06/04.
//

import Foundation
import Photos

class CheckPermission {
    
    func showCheckPermission(){
        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status){
            
            case .authorized:print("許可されます")
            
            case .denied:print("拒否")
                
            case .notDetermined:print("notDetermined")
                
            case .restricted:print("restricted")
                
            case .limited:print("limited")
            @unknown default: break
                
            }
            
            }
    }
    
    
}
