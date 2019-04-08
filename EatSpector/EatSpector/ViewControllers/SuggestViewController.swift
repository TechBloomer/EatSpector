//
//  SuggestViewController.swift
//  EatSpector
//
//  Created by WaiYanPhyo Hein on 12/1/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import UIKit
import ImageSlideshow
import FirebaseAuth

class SuggestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ImageView: ImageSlideshow!

    var handle: AuthStateDidChangeListenerHandle?
    
    let localSource = [ImageSource(imageString: "hd-201401-r-sausage-and-broccoli-rabe-with-polenta")!, ImageSource(imageString: "beef-noodle-soup-8")!, ImageSource(imageString: "1371606132101")!, ImageSource(imageString: "182_3_9296_jpeg_ad23f8cb-854b-41ea-85b6-e1afd54da69a")!]
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Set slide show interval time 5 seconds
        ImageView.slideshowInterval = 5.0
        
        // Set page controller postion
        ImageView.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        ImageView.contentScaleMode = UIView.ContentMode.scaleAspectFill
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.black
        ImageView.pageIndicator = pageControl
        
        // Optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        ImageView.activityIndicator = DefaultActivityIndicator()
        ImageView.currentPageChanged = { page in
            print("current page:", page)
        }
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        ImageView.setImageInputs(localSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(SuggestViewController.didTap))
        ImageView.addGestureRecognizer(recognizer)
    }
    
    
    /*:
     # Set UIInterface orientation mask to portrait
     */
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    /*:
     # Present fullscreen image on tap
     */
    @objc func didTap() {
        let fullScreenController = ImageView.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }

    /*:
     # Log out current user
     */

    @IBAction func OnLogout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Main") as! SignInViewController
        self.present(newViewController, animated: true, completion: nil)

    }

}
