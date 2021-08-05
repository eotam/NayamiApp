//
//  Hentou4ViewController.swift
//  NayamiApp
//
//  Created by yamaguchi iori on 2021/07/03.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage
import NendAd



class Hentou4ViewController: UIViewController,NADViewDelegate {
    
    @IBOutlet weak var commentField: UITextView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nadView: NADView!
    
    
    var tag = Int()
    var honbunString = String()
    var userName = String()
    var userImage = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        commentField.text = honbunString
        name.text = userName
        image.sd_setImage(with: URL(string: userImage), completed: nil)
        commentField.isEditable = false
        
        image.layer.cornerRadius = image.frame.width/2
        
        nadView.setNendID(1037670, apiKey: "3969554bde3db86a175dd285656b6944b75e934d")
        nadView.delegate = self
        nadView.load()
        // Do any additional setup after loading the view.
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
