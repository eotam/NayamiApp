//
//  ProfileViewController.swift
//  NayamiApp
//
//  Created by yamaguchi iori on 2021/05/26.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import SDWebImage
import NendAd

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    
    
    @IBOutlet weak var pofileImage: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var historyView: UITableView!
    
    var upLoadImage = UpLoadImage()
    var urlString = String()
    let db = Firestore.firestore()
    
    var tag = Int()
    var historySetArray = [DataSet]()
    
    let idString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyView.delegate = self
        historyView.dataSource = self
        
        //        カスタムセル
        historyView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "commentCell")
        historyView.separatorStyle = .none
        
        let checkModel = CheckPermission()
        checkModel.showCheckPermission()
        pofileImage.layer.cornerRadius = pofileImage.frame.width/2

        // Do any additional setup after loading the view.
        
        
//        ユーザープロフィール設定
       if UserDefaults.standard.object(forKey: "userImage") != nil {
        
        let imageString = UserDefaults.standard.object(forKey: "userImage") as! String

        pofileImage.sd_setImage(with: URL(string: imageString), completed: nil)
        
        }
        
        if UserDefaults.standard.string(forKey: "userName") != nil {
            
            let name = UserDefaults.standard.string(forKey: "userName")
            userName.text = name
            
        }
        
//        履歴ダウンロード
        self.historySetArray = []
        loadhistory1()
        loadhistory2()
        loadhistory3()
        loadhistory4()
    
        

        

    }
        
    
//        履歴ダウンロード
    func loadhistory1(){
        
        db.collection("1").addSnapshotListener { [self] snapshot, error in
            
            if error != nil{
                return
            }
            
            if let snapShotDoc = snapshot?.documents{
                
                for doc in snapShotDoc{
                    
                    let data = doc.data()
                    
                    let dataSet = DataSet(title: data["title"] as! String, textView: data["textView"] as! String, category: data["category"] as! String,imageString: data["imageString"] as! String, postDate: data["postDate"] as! Double,userName: data["userName"] as! String, docID: doc.documentID, users: data["users"] as! String)
                    
                    if data["users"] as! String == Auth.auth().currentUser!.uid{
                        
                        self.historySetArray.append(dataSet)
                        self.historyView.reloadData()
                        
//                        タグをキャスト
                        let category = Int(data["category"] as! String)
                        tag = category!
                        
                        
                    }
                }
            }
        }
    }
    
    
    func loadhistory2(){
        
        db.collection("2").addSnapshotListener { [self] snapshot, error in
            
            if error != nil{
                return
            }
            
            if let snapShotDoc = snapshot?.documents{
                
                for doc in snapShotDoc{
                    
                    let data = doc.data()
                    
                    let dataSet = DataSet(title: data["title"] as! String, textView: data["textView"] as! String, category: data["category"] as! String,imageString: data["imageString"] as! String, postDate: data["postDate"] as! Double,userName: data["userName"] as! String, docID: doc.documentID, users: data["users"] as! String)
                    
                    if data["users"] as! String == Auth.auth().currentUser!.uid{
                        
                        self.historySetArray.append(dataSet)
                        self.historyView.reloadData()
                        
                        let category = Int(data["category"] as! String)
                        tag = category!

                        
                    }
                }
            }
        }
    }
    
    func loadhistory3(){
        
        db.collection("3").addSnapshotListener { [self] snapshot, error in
            
            if error != nil{
                return
            }
            
            if let snapShotDoc = snapshot?.documents{
                
                for doc in snapShotDoc{
                    
                    let data = doc.data()
                    
                    let dataSet = DataSet(title: data["title"] as! String, textView: data["textView"] as! String, category: data["category"] as! String,imageString: data["imageString"] as! String, postDate: data["postDate"] as! Double,userName: data["userName"] as! String, docID: doc.documentID, users: data["users"] as! String)
                    
                    
                    if data["users"] as! String == Auth.auth().currentUser!.uid{
                        
                        self.historySetArray.append(dataSet)
                        self.historyView.reloadData()
                        
                        let category = Int(data["category"] as! String)
                        tag = category!

                        
                    }
                }
            }
        }
    }
    
    func loadhistory4(){
        db.collection("4").addSnapshotListener { [self] snapshot, error in
            
            if error != nil{
                return
            }
            
            if let snapShotDoc = snapshot?.documents{
                
                for doc in snapShotDoc{
                    
                    let data = doc.data()
                    
                    let dataSet = DataSet(title: data["title"] as! String, textView: data["textView"] as! String, category: data["category"] as! String,imageString: data["imageString"] as! String, postDate: data["postDate"] as! Double,userName: data["userName"] as! String, docID: doc.documentID, users: data["users"] as! String)
                    
                    
                    if data["users"] as! String == Auth.auth().currentUser!.uid{
                        self.historySetArray.append(dataSet)
                        self.historyView.reloadData()
                        
                        let category = Int(data["category"] as! String)
                        tag = category!

                    }
                }
            }
        }
    }
    
    
    @IBAction func kousin(_ sender: Any) {
        
        let image = pofileImage.image
//        匿名登録
        Auth.auth().signInAnonymously { (result, error) in
            if(result?.user) != nil{
                
                
                let data = image?.jpegData(compressionQuality: 1.0)
                self.upLoadImage.sendProfileImageDate(data: data!)
               
                let alert = UIAlertController(title: "", message: "プロフィールが更新されました", preferredStyle: .alert)
                let okAction: UIAlertAction =
                    UIAlertAction(title: "閉じる",style: UIAlertAction.Style.default,
                        handler:{
                            (action: UIAlertAction!) -> Void in
                            print("閉じる")

            })

                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            
            }
                
                
           
        }
 
        
//        ユーザーネームを登録。
        UserDefaults.standard.setValue(self.userName.text, forKey: "userName")
        
    }
    
    @IBAction func tapImageView(_ sender: Any) {
//        アラートを出す
        showAlert()
    }
        
//        アルバムを出す
        func doAlbum(){
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                
                let cameraPicker = UIImagePickerController()
                cameraPicker.allowsEditing = true
                cameraPicker.sourceType = sourceType
                cameraPicker.delegate = self
                self.present(cameraPicker, animated: true, completion: nil)
                
            }
            
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if info[.originalImage] as? UIImage != nil{
            
            let selectedImage = info[.originalImage] as! UIImage
            pofileImage.image = selectedImage
            picker.dismiss(animated: true, completion: nil)
            
            
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func showAlert(){
        
        let alertController = UIAlertController(title: "アルバム", message: "使用を許可しますか？", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "許可する", style: .default) { (alert) in self.doAlbum()
            
        }
        
        let action2 = UIAlertAction(title: "キャンセル", style: .cancel)
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historySetArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = historyView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell

            cell.commentLabel.text = self.historySetArray[indexPath.row].textView
            cell.nameLable.text = self.historySetArray[indexPath.row].title
            cell.userImageView.sd_setImage(with: URL(string: self.historySetArray[indexPath.row].imageString), completed: nil)
       


            return cell

        }
    
    private func tableview(_ tableview: UITableView, heightForRowAt indexpath: IndexPath) -> CGFloat{
        return 160
    }
    
    
//    自分の投稿を削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {


        if editingStyle == UITableViewCell.EditingStyle.delete {
            historySetArray.remove(at: indexPath.row)
            historyView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)

            if historySetArray[indexPath.row].category == "1"{
                db.collection("1").document(historySetArray[indexPath.row].docID).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                    }
                }
            }else if historySetArray[indexPath.row].category == "2"{
                db.collection("2").document(historySetArray[indexPath.row].docID).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                    }
                }
            }else if historySetArray[indexPath.row].category == "3"{
                db.collection("3").document(historySetArray[indexPath.row].docID).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                    }
                }
            }else if historySetArray[indexPath.row].category == "4"{
                db.collection("4").document(historySetArray[indexPath.row].docID).delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                    }
                }

            }
        }
        
    }
                
                func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                    
                    NADInterstitial.sharedInstance()?.showAd(from: self)
                    
                    
                    let hentou3VC = self.storyboard?.instantiateViewController(identifier: "hentou3") as! Hentou3ViewController
                    
                    //        データを渡す
                    hentou3VC.titleString = historySetArray[indexPath.row].title
                    hentou3VC.honbunString = historySetArray[indexPath.row].textView
                    hentou3VC.userImage = historySetArray[indexPath.row].imageString
                    hentou3VC.userName = historySetArray[indexPath.row].userName
                    hentou3VC.idString = historySetArray[indexPath.row].docID
                    //        タグの受け渡し
                    hentou3VC.tag = tag
                    print(tag)
                    
                    //        画面遷移
                    navigationController?.pushViewController(hentou3VC, animated: true)
                }
                
                
                func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                    textField.resignFirstResponder()
                }
                
                
                override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                    view.endEditing(true)
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
