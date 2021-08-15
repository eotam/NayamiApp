//
//  ReportViewController.swift
//  NayamiApp
//
//  Created by yamaguchi iori on 2021/08/11.
//

import UIKit
import WebKit

class ReportViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openURL("https://otoufucraft.wixsite.com/otoufucraft/%E3%81%94%E9%80%A3%E7%B5%A1")

        // Do any additional setup after loading the view.
    }
    
    func openURL(_ string: String?){

        let url = URL(string: string!)
        let request = URLRequest(url: url!)
        webView.load(request)

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
