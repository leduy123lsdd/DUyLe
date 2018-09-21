//
//  ViewController.swift
//  English
//
//  Created by Lê Duy on 9/14/18.
//  Copyright © 2018 Lê Duy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MainViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var arrayNameUnit: [String] = ["chua co gi","sdf sd f"]
    var amountUnit = 0
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
        return amountUnit + 1 /*amountUnit+1*/
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let nameGrade = gradeClicked == 0 ? "GRADE ..." : "GRADE \(gradeClicked) - \(amountUnit) UNIT"
        cell.textLabel?.text = indexPath.row == 0 ? nameGrade :  "Unit\(indexPath.row): "+arrayNameUnit[indexPath.row - 1]
        cell.textLabel?.font = indexPath.row == 0 ? UIFont.systemFont(ofSize: 30) : UIFont.systemFont(ofSize: 20)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(arrayNameUnit[indexPath.row - 1])

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
        amountUnit = 0
        gradeClicked =  indexPath.row + 6
        fetchData(grade: "grade\(gradeClicked)")
        print(arrayNameUnit)
        tableView.reloadData()
    }
}

extension MainViewController {
    func fetchData(grade: String) {
        var nameUnit = [String]()
        let ref = Database.database().reference(withPath: "grade").child(grade)
        ref.observe(.value) { (snapshot) in
            for data in snapshot.children {
                guard let value = data as? DataSnapshot else {return}
                if value.key == "amountOfUnit" {
                    guard let amountUnit = value.value as? Int else {return}
                    self.amountUnit = amountUnit
                    self.tableView.reloadData()
                } else {
                    guard let unitInfo = value.value as? [String:AnyObject] else {return}
                    guard let title = unitInfo["title"] as? String else {return}
                    nameUnit.append(title)
                }
            }
            self.arrayNameUnit = nameUnit
            self.amountUnit = nameUnit.count
        }
    }
}









