//
//  KiyakuViewController.swift
//  NayamiApp
//
//  Created by yamaguchi iori on 2021/08/11.
//

import UIKit
import WebKit
import Firebase

class KiyakuViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var upLoadImage = UpLoadImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       openURL("https://otoufucraft.wixsite.com/otoufucraft/%E5%88%A9%E7%94%A8%E8%A6%8F%E7%B4%84")
    }
    
   
    func openURL(_ string: String?){

        let url = URL(string: string!)
        let request = URLRequest(url: url!)
        webView.load(request)

    }
    
    @IBAction func doui(_ sender: Any) {
        
        Auth.auth().signInAnonymously { (result, error) in
            
            UserDefaults.standard.setValue("匿名さん", forKey: "userName")
            print("ユーザー名登録")
//            let image = UIImage(named: "icon")!
//            let data = image.jpegData(compressionQuality: 1.0)
//            self.upLoadImage.sendProfileImageDate(data: data!)
//            print("icon登録")
             
             

            
            UserDefaults.standard.set(true, forKey: "doui")
            let topVC = self.storyboard?.instantiateViewController(identifier: "top") as!ViewController
            
            self.navigationController?.pushViewController(topVC, animated: true)
    }
        
//        let topVC = storyboard?.instantiateViewController(identifier: "top") as!ViewController
//
//        navigationController?.pushViewController(topVC, animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
