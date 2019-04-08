//
//  HomeViewController.swift
//  EatSpector
//
//  Created by Pann Cherry on 10/18/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import UIKit
import AFNetworking
import Firebase
import CoreLocation

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var businesses: [Business] = []
    var searching = false;
    var searchInput: [Business] = [];
    let cellSpacingHeight: CGFloat = 20
    let locationManager: CLLocationManager = CLLocationManager();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.rowHeight = 200
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 650
        
        locationManager.delegate = self;
        locationManager.requestWhenInUseAuthorization();
        locationManager.startUpdatingLocation();
        
        locationManager.distanceFilter = 100;
        //locationManager.stopUpdatingLocation()
        
        tableView.dataSource = self
        fetchBusinesses()
        
        //setupNavBar();
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for currentLocation in locations{
            print("Index: \(index): \(currentLocation)");
            
        }
    }
    
    
    /*:
     # Set up navigation bar
     */
    func setupNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true;
        let searchController = UISearchController(searchResultsController: nil);
        navigationItem.searchController = searchController;
        searchController.delegate = self as? UISearchControllerDelegate;
        navigationItem.hidesSearchBarWhenScrolling = false;
    }
    
    
    /*:
     # Count business
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            print(searchInput.count )
            return searchInput.count ;
        }
        else{
            print(businesses.count);
            return businesses.count;
        }
        
    }
    
    
    /*:
     # Get cell indexPath.row
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        //code to change color of selected cell background
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.orange
        cell.selectedBackgroundView = backgroundView
        cell.contentView.backgroundColor = UIColor.red
        //code to set the cell background
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 175))
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubviewToBack(whiteRoundedView)
        if searchInput.count != 0
        {
            cell.business = searchInput[indexPath.row]
        }
        else
        {
            cell.business = businesses[indexPath.row]
        }
        return cell
    }
    
    
    /*:
     # Fetch business
     */
    func fetchBusinesses () {
        BusinessAPIManager().getBusinesses { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                self.tableView.reloadData()
                //self.activityIndicator.stopAnimating()
                //self.refreshControl.endRefreshing()
            }
        }
    }
    
    
    /*:
     # Custom navigation bar
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255, green: 0/255, blue: 0/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    
    /*:
     # Search bar function
     */
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchInput = businesses.filter({ (Business) -> Bool in
            guard searchBar.text != nil else { return false;}
            return Business.name.lowercased().contains(searchText.lowercased())
        })
        searching = true;
        tableView.reloadData();
    }
    
    
    /*:
     # Search bar cancel function
     */
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false;
        searchInput = []
        tableView.reloadData();
        searchBar.resignFirstResponder()
        
    }
    
    
    
    /*:
     # Connect with detailViewController
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let business = businesses[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.business = business
        }
    }
    
    
    
    /*:
     # Log out function
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
