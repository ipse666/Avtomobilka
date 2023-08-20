//
//  CardViewController.swift
//  Avtomobilka
//
//  Created by v.vaskin on 31/07/2023.
//

import UIKit

class CardViewController: UIViewController {
    
    enum CardSection: Int {
        case car
        case post
    }
    
    @IBOutlet weak var tableView: UITableView!

    var output: CardViewOutput!
    var card: CardItem?
    var posts = [PostItem]()
    var loading = false

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    // MARK: IBActions
    @IBAction func backButtonPressed(_ sender: Any) {
        output.backPressed(animated: true)
    }
}

// MARK:- <CardViewInput>
extension CardViewController: CardViewInput {
    func setupInitialState() {
    }
    
    func updateCard(card: CardItem) {
        self.card = card
        title = card.car.name
        tableView.reloadData()
    }
    
    func updatePots(posts: [PostItem]) {
        if Set(self.posts.map{$0.id}).intersection(posts.map{$0.id}).count == 0 {
            self.posts += posts
            self.tableView.reloadData()
            self.loading = false
        }
    }
}

extension CardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch CardSection(rawValue: section)! {
        case .car:
            return self.card != nil ? 1 : 0
        case .post:
            return self.posts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch CardSection(rawValue: indexPath.section)! {
        case .car:
            let carCard = card!.car
            let carUser = card!.user
            let cell = tableView.dequeueReusableCell(withIdentifier: "carCardCell", for: indexPath) as! CardCarCell
            cell.photoCarImageView.kf.setImage(with: carCard.firstImage)
            cell.userAvatarImageView.kf.setImage(with: carUser.avatar)
            cell.carNameLabel.text = "\(carCard.brandName) \(carCard.modelName)"
            cell.carEngineLabel.text = "\(carCard.engine) \(carCard.transmissionName) \(carCard.year)"
            cell.userNameLabel.text = carUser.name
            return cell
        case .post:
            let postItem: PostItem = posts[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cardPostCell", for: indexPath) as! CardPostCell
            cell.photoCarImageView.kf.setImage(with: postItem.img)
            cell.createdAtLabel.text = postItem.createdAt
            cell.commentTextLabel.text = postItem.text
            cell.likeCountLabel.text = String(postItem.likeCount)
            cell.commentCountLabel.text = String(postItem.commentCount)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = self.posts.count - 1
        if indexPath.row == lastIndex && !loading {
            loading = true
            output.nextPostItems()
        }
    }
}
