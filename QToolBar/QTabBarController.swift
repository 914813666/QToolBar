//
//  QTabBarController.swift
//  QToolBar
//
//  Created by qzp on 15/11/20.
//  Copyright © 2015年 qzp. All rights reserved.
//

import UIKit

let QImageRidio: CGFloat = 0.7


class QTabBarController: UITabBarController {

    var items: [UITabBarItem]!  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setChildViewControllers()
        setUpTabBar()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpTabBar() {
        let tabBar = QTabBar(frame: self.tabBar.frame)
        tabBar.backgroundColor = UIColor.whiteColor()
        tabBar.tabBarItems = self.items
        self.view.addSubview(tabBar)
        self.tabBar.removeFromSuperview()
        
        tabBar.qCenterButtonClick = {
        
        }
        
        tabBar.qTabBarClick = {(index: Int)  in
            print(index)
        }
    
    }
    
    
    func setChildViewControllers() {
        
        let home = UIViewController()
        home.view.backgroundColor = UIColor.redColor()
        self.setUpOneChildViewController(home, image: UIImage(named: "tabbar_home")!, selectedImage: UIImage(named: "tabbar_home_selected")!, title: "首页", hadNavgation: true)
        
        let home2 = UIViewController()
        home2.view.backgroundColor = UIColor ( red: 0.5647, green: 0.4534, blue: 0.3571, alpha: 1.0 )
        self.setUpOneChildViewController(home2, image: UIImage(named: "tabbar_home")!, selectedImage: UIImage(named: "tabbar_home_selected")!, title: "首页", hadNavgation: true)
        
        let home3 = UIViewController()
        home3.view.backgroundColor = UIColor ( red: 0.1435, green: 0.2514, blue: 0.1502, alpha: 1.0 )
        self.setUpOneChildViewController(home3, image: UIImage(named: "tabbar_home")!, selectedImage: UIImage(named: "tabbar_home_selected")!, title: "首页", hadNavgation: true)
        
        let home4 = UIViewController()
        home4.view.backgroundColor = UIColor ( red: 0.1912, green: 0.6379, blue: 0.2615, alpha: 1.0 )
        self.setUpOneChildViewController(home4, image: UIImage(named: "tabbar_home")!, selectedImage: UIImage(named: "tabbar_home_selected")!, title: "首页", hadNavgation: true)
        
        
    
    }
    
    
    func setUpOneChildViewController(vc: UIViewController, image: UIImage, selectedImage: UIImage, title: String, hadNavgation: Bool) {
        vc.title = title
        vc.tabBarItem.image = image
        vc.tabBarItem.selectedImage = selectedImage
        
        self.items.append(vc.tabBarItem)
        if hadNavgation == true {
            let nav = UINavigationController(rootViewController: vc)
            self.addChildViewController(nav)
        } else {
            self.addChildViewController(vc)
        }
        
    }

}


class QTabBar: UIView {
 /// 点击第几个tabbar
    var qTabBarClick: ((index: Int) -> Void)?
 /// 点击中间按钮
    var qCenterButtonClick: (()->())?
    
    private var buttons: [QTabBarButton]? = []
    private var selectedButton: UIButton!
//    private var plusButton: UIButton! = UIButton() {
//        didSet {
//            let btn = UIButton(type: .Custom)
//            btn.setImage(UIImage(named: "tabbar_mainbtn"), forState: .Normal)
//            btn.setImage(UIImage(named: "fabu_pressed"), forState: .Highlighted)
//            btn.setBackgroundImage(UIImage(named: "tabbar_mainbtn"), forState: .Normal)
//            btn.setBackgroundImage(UIImage(named: "tabbar_mainbtn"), forState: .Highlighted)
//            btn.sizeToFit()
//            
//            btn.addTarget(self, action: "qTabBarCenterButtonClick:", forControlEvents: .TouchUpInside)
//            
//            plusButton = btn
//            self.addSubview(plusButton)
//        }
//    }
//    
    private var plusButton: UIButton!
    
    var tabBarItems: [UITabBarItem]! {
        didSet{
            for tabbarItem in tabBarItems {
                let btn = QTabBarButton(type: .Custom)
                btn.item = tabbarItem
                btn.tag = (self.buttons?.count)!
                btn.addTarget(self, action: "qTabBarButtonClick:", forControlEvents: .TouchUpInside)
                if btn.tag == 0 {
                    self.qTabBarButtonClick(btn)
                }
                self.addSubview(btn)
                buttons?.append(btn)
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let btn = UIButton(type: .Custom)
        btn.setImage(UIImage(named: "tabbar_mainbtn"), forState: .Normal)
        btn.setImage(UIImage(named: "fabu_pressed"), forState: .Highlighted)
        btn.setBackgroundImage(UIImage(named: "tabbar_mainbtn"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_mainbtn"), forState: .Highlighted)
        btn.sizeToFit()
        
        btn.addTarget(self, action: "qTabBarCenterButtonClick:", forControlEvents: .TouchUpInside)
            plusButton = btn
        self.addSubview(plusButton)
   

    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func qTabBarButtonClick(btn: UIButton) {
       print("点击按钮");
            selectedButton = btn
        selectedButton.selected = false
        btn.selected = true
   
        if qTabBarClick != nil{
            qTabBarClick!(index: btn.tag)
        }
        
        
    }

    func qTabBarCenterButtonClick(btn: UIButton) {
        print("点击中间按钮");
        
        if qCenterButtonClick != nil {
            qCenterButtonClick!()
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let w = CGRectGetWidth(self.bounds)
        let h = CGRectGetHeight(self.bounds)
        
        var btnX: CGFloat = 0
        let btnY: CGFloat = 0
        let btnW: CGFloat = w / CGFloat(self.tabBarItems.count + 1)
        let btnH: CGFloat = h
        
        var i: Int = 0
        
        for tabBarButton in self.buttons! {
            if i == 2 {
                i = 3
            }
            btnX = CGFloat(i) * btnW
            tabBarButton.frame  = CGRectMake(btnX, btnY, btnW, btnH)
            i++
         }
        self.plusButton.center = CGPointMake(w * 0.5, h * 0.5 - 5)
        
    }

}


class  QTabBarButton: UIButton {
    var item: UITabBarItem! {
        didSet {
            self.observeValueForKeyPath(nil , ofObject: nil, change: nil, context: nil)
            
            //KVO 时刻监听一个对象的属性有没有改变
            item.addObserver(self, forKeyPath: "title", options: .New, context: nil)
            item.addObserver(self, forKeyPath: "image", options: .New, context: nil)
            item.addObserver(self, forKeyPath: "selectedImage", options: .New, context: nil)
            item.addObserver(self, forKeyPath: "badgeValue", options: .New, context: nil)
            
        }
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(UIColor.blackColor(), forState: .Normal)
        setTitleColor(UIColor.orangeColor(), forState: .Selected)
        self.imageView?.contentMode = .Center
        self.titleLabel?.textAlignment = .Center
        self.titleLabel?.font = UIFont.systemFontOfSize(12)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 只要监听的属性一有新值，就会调用
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        self.setTitle(item.title, forState: .Normal)
        self.setImage(item.image, forState: .Normal)
        self.setImage(item.selectedImage, forState: .Normal)
      }
    // 修改按钮内部子控件的frame
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //1.imageView
        let imageX: CGFloat = 0
        let imageY: CGFloat = 0
        let imageW: CGFloat = CGRectGetWidth(self.bounds)
        let imageH: CGFloat = CGRectGetHeight(self.bounds) * QImageRidio
        
        self.imageView?.frame = CGRectMake(imageX, imageY, imageW, imageH)
        
        //2.title
        let titleX: CGFloat = 0
        let titleY: CGFloat = imageH - 3
        let titleW: CGFloat = imageW
        let titleH: CGFloat = CGRectGetHeight(self.bounds) - titleY
        self.titleLabel?.frame = CGRectMake(titleX, titleY, titleW, titleH)
        
        
        
    }
    
    
    
}