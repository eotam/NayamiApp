//
//  Hentou2ViewController.swift
//  NayamiApp
//
//  Created by yamaguchi iori on 2021/05/28.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage
import Foundation
import NendAd


class Hentou2ViewController: UIViewController,Done,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate,NADViewDelegate {
  
    
 
    @IBOutlet weak var nadView: NADView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var tag = Int()
    var dataSetArray = [DataSet]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nadView.setNendID(1037644, apiKey: "cf325930ebf544f4d9f7fffad388dcc464096a94")
        nadView.delegate = self
        nadView.load()
        
        let downLoad = DownLoad()
        downLoad.done = self
        downLoad.load(tag:tag)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        カスタムセル
        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "commentCell")
        tableView.separatorStyle = .none
        
//      サーチバー設定
        searchBar.delegate = self
        
    }
    
    func check(dataSetArray:[DataSet]) {
        
        self.dataSetArray = dataSetArray
        self.tableView.reloadData()
        
    }
    
//    サーチバー設定
    
//    入力された文字の取得
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard let searchText = searchBar.text else {
                return
            }
            search(searchText)
    }

    

    
//    サーチバー
    func search(_ text: String) {
        
            
            
        if dataSetArray.contains(where: {$0.title.contains(text.lowercased())}){

            let searchIndex = self.dataSetArray.filter({$0.title.contains(text.lowercased())})
            
            self.dataSetArray = searchIndex
        
            tableView.reloadData()  //反映させる
            
        }else{
            
            let alert = UIAlertController(title: "検索結果なし", message: "", preferredStyle: .alert)
            let okAction: UIAlertAction =
                UIAlertAction(title: "閉じる",style: UIAlertAction.Style.default,
                    handler:{
                        (action: UIAlertAction!) -> Void in
                        print("閉じる")

        })

            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
        }
        
      
    }
    
    
//    検索キャンセル
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if searchText.isEmpty{
            
            let downLoad = DownLoad()
            downLoad.done = self
            downLoad.load(tag:tag)
            
            tableView.reloadData()
            
        }
        
    }
    
    

//    カスタムセル設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSetArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell

        cell.commentLabel.text = self.dataSetArray[indexPath.row].textView
        cell.nameLable.text = self.dataSetArray[indexPath.row].title
        cell.userImageView.sd_setImage(with: URL(string: self.dataSetArray[indexPath.row].imageString), completed: nil)

        return cell

    }
    
    private func tableview(_ tableview: UITableView, heightForRowAt indexpath: IndexPath) -> CGFloat{
        return 160
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NADInterstitial.sharedInstance()?.showAd(from: self)
        
        
        let hentou3VC = self.storyboard?.instantiateViewController(identifier: "hentou3") as! Hentou3ViewController
        
//        データを渡す
        hentou3VC.titleString = dataSetArray[indexPath.row].title
        hentou3VC.honbunString = dataSetArray[indexPath.row].textView
        hentou3VC.userImage = dataSetArray[indexPath.row].imageString
        hentou3VC.userName = dataSetArray[indexPath.row].userName
        hentou3VC.idString = dataSetArray[indexPath.row].docID
//        下タグの受け渡し？
        hentou3VC.tag = tag

//        画面遷移
        navigationController?.pushViewController(hentou3VC, animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
}
