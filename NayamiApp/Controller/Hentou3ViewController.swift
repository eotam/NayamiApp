//
//  Hentou3ViewController.swift
//  NayamiApp
//
//  Created by yamaguchi iori on 2021/06/02.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage

class Hentou3ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    
    
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var honbunText: UITextView!
    @IBOutlet weak var commentTable: UITableView!
    @IBOutlet weak var userNamelabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var sendBotton: UIButton!
    var titleString = String()
    var honbunString = String()
    var userName = String()
    var userImage = String()
    var idString = String()
    let db = Firestore.firestore()
    
    var tag = Int()
    
    var commentSet:[CommentSet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        commentTable.delegate = self
        commentTable.dataSource = self
        
        imageLabel.layer.cornerRadius = imageLabel.frame.width/2
        
        titleText.text = titleString
        honbunText.text = honbunString
        userNamelabel.text = userName
        imageLabel.sd_setImage(with: URL(string: userImage), completed: nil)
        honbunText.isEditable = false
        
        commentTable.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "commentCell")
        commentTable.separatorStyle = .none
        
        loadComment()
        
        
}

    
//    コメント投稿
    @IBAction func sendBotton(_ sender: Any) {
        
        if commentField.text?.isEmpty == true {
            
            //            alert表示
            let alert = UIAlertController(title: "コメントを入力してください", message: "", preferredStyle: .alert)
            let okAction: UIAlertAction =
                UIAlertAction(title: "閉じる",style: UIAlertAction.Style.default,
                              handler:{
                                (action: UIAlertAction!) -> Void in
                                print("閉じる")
                                
                              })
            
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
        }else{
        
            db.collection(Util.category[tag - 1]).document(idString).collection("Comment").document().setData(["Comment": commentField.text as Any,"postDate":Date().timeIntervalSince1970,"Users":Auth.auth().currentUser!.uid,"userName":UserDefaults.standard.string(forKey: "userName") as Any,"userImage":  UserDefaults.standard.object(forKey: "userImage") as Any])
        
            //       alert表示
                    let alert = UIAlertController(title: "コメントが投稿されました", message: "", preferredStyle: .alert)
                    let okAction: UIAlertAction =
                        UIAlertAction(title: "閉じる",style: UIAlertAction.Style.default,
                            handler:{
                                (action: UIAlertAction!) -> Void in
                                print("閉じる")

                })

                    alert.addAction(okAction)
                    present(alert, animated: true, completion: nil)

//            コメントフィールドを空にする
            commentField.text = ""
            loadComment()
            
        }
    }
    

//    コメント受信
    func loadComment(){
        
        db.collection(Util.category[tag - 1]).document(idString).collection("Comment").order(by: "postDate").addSnapshotListener { snapShot, error in
            
            self.commentSet = []
            
            if error != nil{
                return
            }
            
            if let snapShotDoc = snapShot?.documents{
                
                for doc in snapShotDoc{
                    
                    let data = doc.data()
                    
                    let commentSet = CommentSet(commentField: data["Comment"] as! String, imageString: data["userImage"] as! String, postDate: data["postDate"] as! Double, userName: data["userName"] as! String)
                    
                    self.commentSet.append(commentSet)
                    
                }
            }
            
            self.commentTable.reloadData()
        }
        
        
    }
    
    
    //    セル設定
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return commentSet.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell



            cell.nameLable.text = self.commentSet[indexPath.row].userName
            cell.commentLabel.text = self.commentSet[indexPath.row].commentField
            cell.userImageView.sd_setImage(with: URL(string: self.commentSet[indexPath.row].imageString), completed: nil)


            return cell

        }

    private func tableview(_ tableview: UITableView, heightForRowAt indexpath: IndexPath) -> CGFloat{
        return 100
    }
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let hentou4VC = self.storyboard?.instantiateViewController(identifier: "hentou4") as! Hentou4ViewController
        
//        データを渡す
        hentou4VC.honbunString = commentSet[indexPath.row].commentField
        hentou4VC.userImage = commentSet[indexPath.row].imageString
        hentou4VC.userName = commentSet[indexPath.row].userName

//        下タグの受け渡し？
        hentou4VC.tag = tag
        
        navigationController?.pushViewController(hentou4VC, animated: true)
    
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}



