//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Jimmy Palafox on 10/1/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!    
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var heartButton: UIButton!
    
    @IBOutlet weak var rechirpButton: UIButton!
    
    var favorited:Bool = false
    var tweetId:Int = -1
    var retweeted:Bool = false
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if (favorited) {
            heartButton.setImage(UIImage (named: "favor-icon-red"), for: UIControl.State.normal)
        } else{heartButton.setImage(UIImage (named: "favor-icon"), for: UIControl.State.normal)}
    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId,
                                                   success:{self.setFavorite(true)},
                                                   failure: {(error) in print("favorite did not succeed: \(error)")})
        } else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId,
                                                   success:{self.setFavorite(false)},
                                                   failure: {(error) in print("Unfavorite did not succeed: \(error)")})
            
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool){
        if (isRetweeted) {
            rechirpButton.setImage(UIImage (named: "retweet-icon-green"), for: UIControl.State.normal)
            rechirpButton.isEnabled = false
        } else{rechirpButton.setImage(UIImage (named: "retweet-icon"), for: UIControl.State.normal)
            rechirpButton.isEnabled = true
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId,
                                         success: {self.setRetweeted(true)},
                                         failure: {(error) in print("Could not retweet: \(error)")})
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
