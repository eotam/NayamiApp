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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        openURL("https://otoufucraft.wixsite.com/otoufucraft/利用規約")

    }
    
    func openURL(_ string: String?){

        guard string != string else { return }
        let url = URL(string: "https://otoufucraft.wixsite.com/otoufucraft/利用規約")!
        let request = URLRequest(url: url)
        webView.load(request)

    }
    
    @IBAction func doui(_ sender: Any) {
        
        Auth.auth().signInAnonymously { (result, error) in
            if(result?.user) != nil{
            }
    }
        
        let topVC = storyboard?.instantiateViewController(identifier: "top") as!ViewController
        
        navigationController?.pushViewController(topVC, animated: true)
        
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
