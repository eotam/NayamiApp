//
//  Hentou1ViewController.swift
//  NayamiApp
//
//  Created by yamaguchi iori on 2021/05/24.
//

import UIKit
import NendAd

class Hentou1ViewController: UIViewController,NADViewDelegate {
    @IBOutlet weak var nadView: NADView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nadView.setNendID(1037670, apiKey: "3969554bde3db86a175dd285656b6944b75e934d")
        nadView.delegate = self
        nadView.load()
        
    }
//    画面遷移
    @IBAction func tap(_ sender: UIButton) {
        let hentou2VC = storyboard?.instantiateViewController(identifier: "hentou2") as!Hentou2ViewController
        
        hentou2VC.tag = sender.tag
        
        navigationController?.pushViewController(hentou2VC, animated: true)
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
