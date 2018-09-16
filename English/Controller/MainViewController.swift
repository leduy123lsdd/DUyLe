//
//  ViewController.swift
//  English
//
//  Created by Lê Duy on 9/14/18.
//  Copyright © 2018 Lê Duy. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var arrayNameUnit = [String]()
    
    let imageArray: [String] = ["6","7","8","9","10","11","12"]
    var gradeClicked = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemWidth = UIScreen.main.bounds.width*(3/4)
        let itemHeight = UIScreen.main.bounds.height/4 + 10
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 3, 3, 3)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
    
  
}
extension MainViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        //cell.textLabel?.sizeToFit()
        let nameGrade = gradeClicked == 0 ? "GRADE ..." : "GRADE \(gradeClicked)"
        
        cell.textLabel?.text = indexPath.row == 0 ? nameGrade : "lalalaa"
        cell.textLabel?.font = indexPath.row == 0 ? UIFont.systemFont(ofSize: 30) : UIFont.systemFont(ofSize: 20)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
}

extension MainViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCell
        cell.imageCell.image = UIImage(named: "grade" + imageArray[indexPath.row])
        return cell
    }
    
    
    //MARK: - Number of view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gradeClicked = indexPath.row + 6
        tableView.reloadData()
    }
    
}











