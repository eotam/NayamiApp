//
//  ToukouViewController.swift
//  NayamiApp
//
//  Created by yamaguchi iori on 2021/05/23.
//

import UIKit
import Firebase
import FirebaseFirestore
import NendAd

class ToukouViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,NADInterstitialVideoDelegate{
    
//    DBの場所を指定
    let db = Firestore.firestore()
    
    let interstitialVideo = NADInterstitialVideo(spotID: 1037643, apiKey: "8b323303f36ecfb439be0b1785df3cf6e27f744b")
    
//    pickerView配列
    private var datasurce = ["仕事","恋愛","人間関係","その他"]
    var selected = "仕事"
    
//    宣言ゾーン
    @IBOutlet weak var genre: UIPickerView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textView: UITextView!
    var userName = String()
    var imageString = String()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitialVideo.delegate = self
        interstitialVideo.loadAd()
        
        if UserDefaults.standard.object(forKey: "userName") != nil{
            
            userName = UserDefaults.standard.object(forKey: "userName") as! String
            
        }
        
        if UserDefaults.standard.object(forKey: "userImage") != nil{
            
            imageString = UserDefaults.standard.object(forKey: "userImage") as! String
            
        }

        genre.dataSource = self
        genre.delegate = self

    }
    
 
//    pickerView設定
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        datasurce.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = datasurce[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return datasurce[row]
    }
    
    
    
 
    
    
//    投稿を送信
    @IBAction func sendNayamiBotton(_ sender: Any) {
        
        

        
//        タイトル・本文未入力
        if titleField.text?.isEmpty == true && textView.text.isEmpty == true {
            
//            alert表示
                    let alert = UIAlertController(title: "タイトル・本文を入力してください", message: "", preferredStyle: .alert)
                    let okAction: UIAlertAction =
                        UIAlertAction(title: "閉じる",style: UIAlertAction.Style.default,
                            handler:{
                                (action: UIAlertAction!) -> Void in
                                print("閉じる")
            
                })
            
                    alert.addAction(okAction)
                    present(alert, animated: true, completion: nil)
            
            //            タイトル未入力
        }else if titleField.text?.isEmpty == true {
            
            //            alert表示
            let alert = UIAlertController(title: "タイトルを入力してください", message: "", preferredStyle: .alert)
            let okAction: UIAlertAction =
                UIAlertAction(title: "閉じる",style: UIAlertAction.Style.default,
                              handler:{
                                (action: UIAlertAction!) -> Void in
                                print("閉じる")
                                
                              })
            
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
          
//            本文未入力
        }else if textView.text.isEmpty == true {
            
            //            alert表示
            let alert = UIAlertController(title: "本文を入力してください", message: "", preferredStyle: .alert)
            let okAction: UIAlertAction =
                UIAlertAction(title: "閉じる",style: UIAlertAction.Style.default,
                              handler:{
                                (action: UIAlertAction!) -> Void in
                                print("閉じる")
                                
                              })
            
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
        }else{
            
          
//        データ送信
            if selected == "仕事"{
                
                db.collection("1").document().setData(
                    
                    ["title":titleField.text as Any,"textView":textView.text as Any,"category":selected,"postDate":Date().timeIntervalSince1970,"users":Auth.auth().currentUser!.uid,"imageString":imageString,"userName":UserDefaults.standard.string(forKey: "userName") as Any]
                    
                )
                
            }else if selected == "恋愛"{
                
                db.collection("2").document().setData(
                    
                    ["title":titleField.text as Any,"textView":textView.text as Any,"category":selected,"postDate":Date().timeIntervalSince1970,"users":Auth.auth().currentUser!.uid,"imageString":imageString,"userName":UserDefaults.standard.string(forKey: "userName") as Any]
                    
                )
                
            }else if selected == "人間関係"{
                
                db.collection("3").document().setData(
                    
                    ["title":titleField.text as Any,"textView":textView.text as Any,"category":selected,"postDate":Date().timeIntervalSince1970,"users":Auth.auth().currentUser!.uid,"imageString":imageString,"userName":UserDefaults.standard.string(forKey: "userName") as Any]
                    
                )
                
            }else if selected == "その他"{
                
                db.collection("4").document().setData(
                    
                    ["title":titleField.text as Any,"textView":textView.text as Any,"category":selected,"postDate":Date().timeIntervalSince1970,"users":Auth.auth().currentUser!.uid,"imageString":imageString,"userName":UserDefaults.standard.string(forKey: "userName") as Any]
                    
                )
                
            }
        
//       alert表示
        let alert = UIAlertController(title: "投稿が完了しました", message: "", preferredStyle: .alert)
        let okAction: UIAlertAction =
            UIAlertAction(title: "閉じる",style: UIAlertAction.Style.default,
                handler:{
                    (action: UIAlertAction!) -> Void in
                    print("閉じる")

    })

        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)

//       textを空にする
        titleField.text = ""
        textView.text = ""
        }
        
        if interstitialVideo.isReady{
            
            interstitialVideo.showAd(from: self)
            
        }
}
    
    
//    広告の受信
    func nadInterstitialVideoAdDidReceiveAd(_ nadInterstitialVideoAd: NADInterstitialVideo!) {
        print("受信完了")
    }
//    エラー
    func nadInterstitialVideoAd(_ nadInterstitialVideoAd: NADInterstitialVideo!, didFailToLoadWithError error: Error!) {
        print(error.debugDescription)
    }
//    表示がされない
    func nadInterstitialVideoAdDidFailed(toPlay nadInterstitialVideoAd: NADInterstitialVideo!) {
        print("表示がされない")
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           view.endEditing(true)
       }


}
