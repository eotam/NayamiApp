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



class Hentou4ViewController: UIViewController {
    
    @IBOutlet weak var commentField: UITextView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    
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
