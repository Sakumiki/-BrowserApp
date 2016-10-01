//
//  CollectionViewController.swift
//  BrowserApp
//
//  Created by Tatsuo Yamashita on 2016/09/16.
//  Copyright © 2016年 Sakumiki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import WebKit

// MARK: - タブを保持するコンテナクラス
class TabData
{
    var webView:WKWebView!
    var image:UIImage!
    
    deinit{
        webView = nil
        image = nil
    }
}

class TabViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //var collectionView : UICollectionView!
    var tabDataList:[TabData] = []
    var myTabIndexPathRow : Int = 0
    
    
    @IBOutlet weak var tabview: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // CollectionViewを作成する
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width/2,height: (self.view.frame.height-64)/2)
        layout.minimumInteritemSpacing = 0.0;
        layout.minimumLineSpacing = 0.0;
        tabview = UICollectionView(frame:CGRect(x: 0,y: 0,width: self.view.frame.width,height: self.view.frame.height), collectionViewLayout: layout)
        tabview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        
        tabview.delegate = self
        tabview.dataSource = self
        tabview.isPagingEnabled = true
        tabview.clipsToBounds = true
        
        self.view.addSubview(tabview)
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: "onClickAddBarButton:")
        self.navigationItem.setLeftBarButton(addBarButton, animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tabview.reloadData()
    }
    
    // MARK: - TableViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // セル選択時
        return
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // DataSourceの件数を返す
        return self.tabDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell",
                                                                                                for: indexPath) as UICollectionViewCell
        
        // Cellの再利用
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // タイトルラベル
        let textView = UITextView(frame: CGRect(x: 0,y: 10,width: cell.frame.width,height: 50))
        if(tabDataList[(indexPath as NSIndexPath).row].webView != nil){
            textView.text = tabDataList[(indexPath as NSIndexPath).row].webView.title
        }
        textView.font = UIFont.systemFont(ofSize: CGFloat(10))
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor.white
        textView.textAlignment = NSTextAlignment.center
        textView.isEditable = false
        cell.contentView.addSubview(textView)
        
        // UIImageView
        let thumbNailImage = UIImageView(frame: CGRect(x: (cell.frame.width - cell.frame.width*0.75)/2,y: 55,width: cell.frame.width*0.75,height: cell.frame.height*0.75))
        thumbNailImage.image = tabDataList[(indexPath as NSIndexPath).row].image
        thumbNailImage.backgroundColor = UIColor.white
        cell.contentView.addSubview(thumbNailImage)
        
        // 削除ボタン
        let btnDeleteImage:UIImage!
        btnDeleteImage = UIImage(named: "closeTab")! as UIImage
        
        let btnDelete   = UIButton()
        btnDelete.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        btnDelete.layer.position = CGPoint(x: (cell.frame.width - cell.frame.width*0.75)/2, y:55)
        btnDelete.setImage(btnDeleteImage, for: UIControlState())
        btnDelete.addTarget(self, action: "onClickDelete:", for:.touchUpInside)
        btnDelete.tag = (indexPath as NSIndexPath).row
        cell.contentView.addSubview(btnDelete);
        
        return cell
    }

}
