//
//  Download.swift
//  NayamiApp
//
//  Created by yamaguchi iori on 2021/05/28.
//

import Foundation
import Firebase
import FirebaseFirestore
import SDWebImage

protocol Done {
    func check(dataSetArray:[DataSet])
}

class DownLoad{
    
    let db = Firestore.firestore()
    var dataSetArray = [DataSet]()
    var done:Done?
    
    //    ロード
    func load(tag:Int){
        
        
        db.collection(Util.category[tag - 1]).addSnapshotListener { snapshot, error in
            self.dataSetArray = []
            
            if error != nil{
                return
            }
            
            if let snapShotDoc = snapshot?.documents{
                
                for doc in snapShotDoc{
                    
                    let data = doc.data()
                    
                    let dataSet = DataSet(title: data["title"] as! String, textView: data["textView"] as! String, category: data["category"] as! String,imageString: data["imageString"] as! String, postDate: data["postDate"] as! Double,userName: data["userName"] as! String, docID: doc.documentID, users: data["users"] as! String)
                    
                    
                    self.dataSetArray.append(dataSet)
                   
                }
                
            }
            
            self.done?.check(dataSetArray:self.dataSetArray)
            
        }
    }
}

