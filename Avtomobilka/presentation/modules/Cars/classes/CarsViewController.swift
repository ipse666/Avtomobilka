//
//  CarsViewController.swift
//  Avtomobilka
//
//  Created by v.vaskin on 25/07/2023.
//

import UIKit
import Kingfisher

class CarsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var output: CarsViewOutput!
    var items = [CarItem]()
    var loading = false
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        CarsBuilder().configure(viewController: self)
        output.viewIsReady()
    }
    
    // MARK: IBActions
    @IBAction func backButtonPressed(_ sender: Any) {
        output.backPressed(animated: true)
    }
}

// MARK:- <CarsViewInput>
extension CarsViewController: CarsViewInput {
    func setupInitialState() {
        tableView.contentInset = UIEdgeInsets(top: 4,left: 0,bottom: 0,right: 0)
    }
    
    func updateCars(items: [CarItem]) {
        if Set(self.items.map{$0.id}).intersection(items.map{$0.id}).count == 0 {
            self.items += items
            self.tableView.reloadData()
            self.loading = false
        }
    }
}

extension CarsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carCell", for: indexPath) as! CarCell
        let item: CarItem = items[indexPath.row]
        cell.photoImageView.kf.setImage(with: item.image)
        cell.titleLabel.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.openCard(carId: items[indexPath.row].id)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = self.items.count - 1
        if indexPath.row == lastIndex && !loading {
            loading = true
            output.nextCarItems()
        }
    }
}


