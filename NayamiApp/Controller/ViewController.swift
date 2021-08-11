//
//  ViewController.swift
//  NayamiApp
//
//  Created by yamaguchi iori on 2021/05/23.
//

import UIKit
//ライブラリーをインポート
import Lottie
import FirebaseAuth
import NendAd

class ViewController: UIViewController,NADViewDelegate {
    
//  宣言ゾーン
    @IBOutlet weak var titleLabel: UIImageView!
    @IBOutlet weak var titleLabel2: UILabel!
    @IBOutlet weak var botton1: UIButton!
    @IBOutlet weak var botton2: UIButton!
    @IBOutlet weak var botton3: UIButton!
    @IBOutlet weak var nadView: NADView!
    var animationView:AnimationView = AnimationView()
    
//    画面がよばれた時
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        //        タイトルのフェードイン処理
        titleLabel.alpha = 0.0
        UIView.animate(withDuration: 2.5, delay: 1.0, options: [.curveEaseIn], animations: {self.titleLabel.alpha = 1.0}, completion: nil)
        
        //         ラベルのフェードイン処理
        titleLabel2.alpha = 0.0
        UIView.animate(withDuration: 3.0, delay: 1.0, options: [.curveEaseIn], animations: {self.titleLabel2.alpha = 1.0}, completion: nil)
        titleLabel2.layer.zPosition = 1
        
//        バナー広告
        nadView.setNendID(1037670, apiKey: "3969554bde3db86a175dd285656b6944b75e934d")
        nadView.delegate = self
        nadView.load()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //        バックグラウンドアニメーション作成
                let animationWalk = Animation.named("walkBoy")
                animationView.frame = view.frame
                animationView.animation = animationWalk
                animationView.contentMode = .scaleAspectFit
                animationView.loopMode = .loop
                animationView.play()

        //        パーツを配置
                self.view.addSubview(animationView)
                self.view.addSubview(botton1)
                self.view.addSubview(botton2)
                self.view.addSubview(botton3)
        
//        kiyakuVCへ画面遷移
        
        if Auth.auth().currentUser?.uid != nil{
            
        }else{
            
            performSegue(withIdentifier: "kiyakuVC", sender: nil)
            
            let alert = UIAlertController(title: "個人を特定するような投稿・誹謗中傷するような投稿はお控えください", message: "", preferredStyle: .alert)
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
        
    

//  投稿ボタン
    @IBAction func toukouBotton(_ sender: Any) {
        
//        画面遷移
        let toukouVC = storyboard?.instantiateViewController(identifier: "toukou") as!ToukouViewController
        
        navigationController?.pushViewController(toukouVC, animated: true)
        
    }
//    返答ボタン
    @IBAction func hentouBotton(_ sender: Any) {
        
        //        画面遷移
                let hentou1VC = storyboard?.instantiateViewController(identifier: "hentou1") as!Hentou1ViewController
                
                navigationController?.pushViewController(hentou1VC, animated: true)
                
    }
    
//    プロフィールボタン
    @IBAction func profileBotton(_ sender: Any) {
        
        let profileVC = storyboard?.instantiateViewController(identifier: "profile") as!ProfileViewController
        
        navigationController?.pushViewController(profileVC, animated: true)
        
    }
    
}

