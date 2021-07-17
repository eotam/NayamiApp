//
//  Upload.swift
//  NayamiApp
//
//  Created by yamaguchi iori on 2021/05/28.
//

import Foundation
import FirebaseStorage

protocol SendProfileOKDelegate {
    
    func sendProfileOKDelegate(url:String)
    
}

class UpLoadImage{
    
    var sendProfileOKDelegate:SendProfileOKDelegate?
    
    init() {
        
    }
    
    func sendProfileImageDate(data:Data){
        
        let image = UIImage(data: data)
        let profileImageData = image?.jpegData(compressionQuality: 0.1)
        
        let imageRef = Storage.storage().reference().child("profileImage").child("\(UUID().uuidString + String(Date().timeIntervalSince1970)).jpg")
        
        imageRef.putData(profileImageData!, metadata:nil) { (metaData, error) in
            
            if error != nil{
                
                print(error.debugDescription)
                return
                
            }
            
            imageRef.downloadURL { (url, error) in
                
                if error != nil{
                    
                    print(error.debugDescription)
                    return
                    
                }
//                ユーザーデフォルトに画像を保存↓
                UserDefaults.standard.set(url?.absoluteString, forKey: "userImage")


                self.sendProfileOKDelegate?.sendProfileOKDelegate(url: url!.absoluteString)
                
            }
            
        }
        
    }
    
}
