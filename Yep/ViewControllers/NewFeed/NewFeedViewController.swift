//
//  NewFeedViewController.swift
//  Yep
//
//  Created by nixzhu on 15/9/29.
//  Copyright © 2015年 Catch Inc. All rights reserved.
//

import UIKit
import Proposer
import CoreLocation

class NewFeedViewController: UIViewController {

    @IBOutlet weak var messageTextView: UITextView!

    @IBOutlet weak var mediaCollectionView: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("New Feed", comment: "")

        let postButton = UIBarButtonItem(title: NSLocalizedString("Post", comment: ""), style: .Plain, target: self, action: "post:")

        navigationItem.rightBarButtonItem = postButton

        messageTextView.text = "What's up?"

        messageTextView.backgroundColor = UIColor.lightGrayColor()
        mediaCollectionView.backgroundColor = UIColor.blueColor()

        // try turn on location

        let locationResource = PrivateResource.Location(.WhenInUse)

        if locationResource.isNotDeterminedAuthorization {

            proposeToAccess(.Location(.WhenInUse), agreed: {

                YepLocationService.turnOn()

            }, rejected: {
                self.alertCanNotAccessLocation()
            })

        } else {
            proposeToAccess(.Location(.WhenInUse), agreed: {

                YepLocationService.turnOn()

            }, rejected: {
            })
        }
    }

    // MARK: Actions

    func post(sender: UIBarButtonItem) {

        let coordinate = YepLocationService.sharedManager.currentLocation?.coordinate

        createFeedWithMessage(messageTextView.text, attachments: nil, coordinate: coordinate, skill: nil, allowComment: true, failureHandler: { reason, errorMessage in
            defaultFailureHandler(reason, errorMessage: errorMessage)
        }, completion: { data in
            println(data)
        })
    }
}

