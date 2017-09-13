//
//  HomeController.swift
//  UMai Todo
//
//  Created by Zone 3 on 9/12/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit
import SCLAlertView


class HomeController : UIViewController, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout{
    let button1 = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(handleAdd))
    var addButton : UIBarButtonItem?

      override func viewDidLoad() {

        super.viewDidLoad()
        setupNavBar()
        setupMenuBar()
        setupCollectionView()

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 150)

    }
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    
    lazy var menuBar : MenuBar = {
        let mb = MenuBar()
        mb.backgroundColor = .green
        mb.translatesAutoresizingMaskIntoConstraints = false
        mb.homeController = self
        return mb
    }()
    
    let backView : UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = Utilities.getColorWithHexString("#F5F5F5")
        return vw
    }()
    
    func  setupMenuBar(){
        view.addSubview(backView)
        view.addSubview(menuBar)
        
        backView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        backView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        
        menuBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        menuBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        menuBar.bottomAnchor.constraint(equalTo: backView.bottomAnchor).isActive = true
        
        
    }
    
    func setupNavBar(){
        
        navigationController?.navigationBar.barTintColor = Utilities.getColorWithHexString("#F5F5F5")
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setTitleVerticalPositionAdjustment(CGFloat(-50), for: UIBarMetrics.default)
        
        let btn1 =  UIButton(type: .custom)
        
        btn1.setImage(UIImage(named: "addButton"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        btn1.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        addButton = UIBarButtonItem(customView: btn1)
        
        self.navigationItem.rightBarButtonItem  = addButton
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 64, height: 120))
        titleLabel.text = " 💡 UMAI todo"
        titleLabel.numberOfLines = 8
        titleLabel.textColor = Utilities.getColorWithHexString("#00B2B7")
        titleLabel.font =  UIFont (name: "GillSans-UltraBold", size: 24)
        navigationItem.titleView = titleLabel
        
        
    }
    func changeTodoCollectionType(index: Int){
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: [], animated: true)
        homecell?.flag = index
        homecell?.reload()
        
        if index == 1{
            navigationItem.rightBarButtonItem = nil
        }else{
            self.navigationItem.rightBarButtonItem  = addButton

            
        }
        
    }
    
    
    
    
    @objc func handleAdd(){
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "Noteworthy-Bold", size: 20)!,
            kTextFont: UIFont(name: "Noteworthy-Bold", size: 14)!,
            kButtonFont: UIFont(name: "Noteworthy-Bold", size: 14)!,
            showCloseButton: false,
            titleColor: Utilities.getColorWithHexString("#00B2B7")
        )
        
        let alert = SCLAlertView(appearance: appearance)
        let txt = alert.addTextField("What do wanna do")
        alert.addButton("Add Todo") {
            if let text = txt.text  {
                if text != ""{
                    self.addToDb(text : text)
                }
            }
            print("Text value: \(txt.text ?? "")")
        }
        alert.showEdit("Todo", subTitle: "", colorStyle : 45751 )
        
    }
    var homecell : HomeCell?
    
    func addToDb(text: String){
        let todo = Todo()
        todo.title = text
        TodoDAO().save(todo: todo)
        homecell?.reload()
    }
   

    func setupCollectionView(){
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false

//        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .blue
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "Mycell")
        view.addSubview(collectionView)
        
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: backView.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        
        
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("123")
    }
    
    
    
    
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Mycell", for: indexPath) as! HomeCell
        if homecell == nil{
            homecell = cell
        }
        cell.flag = indexPath.row
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 200)
    }
    
    
}








