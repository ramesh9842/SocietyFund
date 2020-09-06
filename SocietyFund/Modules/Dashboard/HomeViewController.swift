//
//  HomeViewController.swift
//  SocietyFund
//
//  Created by sanish on 8/29/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialActivityIndicator
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

class HomeViewController: UIViewController, UISearchControllerDelegate {
    
    @IBOutlet weak var viewSignUp: UIView!
    @IBOutlet weak var viewLogin: UIView!
    var searchController: UISearchController!
    var currentPage = 0
    
    let projectsDes = ["1. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ","2. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ","3. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. "]
   
    
    @IBAction func showDrawer(_ sender: UIBarButtonItem) {
        mmDrawerContainer?.toggle(.left, animated: true, completion: nil)
        mmDrawerContainer?.showsStatusBarBackgroundView = false
        
    }
    
    @IBAction func btnSearchPressed(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SearchResultTableViewController") as! SearchResultTableViewController
        searchController = UISearchController(searchResultsController: vc)
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.searchBarStyle = .default
        searchController.searchResultsUpdater = vc
        searchController.searchBar.delegate = vc
        searchController.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    @IBAction func btnLoginPressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSignUpPressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    private let identifier = "trendingProjectCollectionCell"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Log.debug(msg: "viewWillAppear")
        
        if UserDefaults.standard.data(forKey: "profile") != nil {
            userLoggedIn()
        }else {
            userLoggedOut()
        }
        
//        if let token = AccessToken.current,
//            !token.isExpired {
//            userLoggedIn()
//        }else if(isGoogleSignedIn == true) {
//            userLoggedIn()
//        }else {
//            userLoggedOut()
//        }
    }
    
    func userLoggedIn() {
        Log.debug(msg: "Logged In")
        viewLogin.isHidden = true
        viewSignUp.isHidden = true
    }
    
    func userLoggedOut() {
        Log.debug(msg: "Logged Out")
        viewLogin.isHidden = false
        viewSignUp.isHidden = false
    }
    
    override func viewDidLoad() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.alwaysBounceHorizontal = true
        self.collectionView.isScrollEnabled = false
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        addLogoToNavigationBarItem()
        /*
                API Caller: Network
                https://cli.smartcardnepal.com/api/customer/auth
                http://merotv.f1soft.com.np/apiV2/getCableOperators
                let params = ["username": "asf", "password": "asf"]
                APIService.shared.request("http://merotv.f1soft.com.np/apiV2/getCableOperators", method: .GET, params: nil) { (result: Result<Any, APIError>) in
                    switch result {
                    case .success(let result):
                        print(result as! Data)
                    case .failure(let error):
                        self.alert(message: error.rawValue)
                    }
                }
                
                */
    }
    
    
    
}

//MARK: - CollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HomeCollectionCell
        cell.lblProjectDesc.text = projectsDes[indexPath.row]
        collectionViewHeight.constant = collectionView.contentSize.height
        cell.progressBar.setProgress(Float(50.0/100.0), animated: true)
        cell.btnNext.addTarget(self, action: #selector(handleNextPage), for:
            .touchUpInside)
        cell.btnNext.tag = indexPath.row
        cell.btnPrevious.addTarget(self, action: #selector(handlePreviousPage), for:
            .touchUpInside)
        Log.debug(msg: indexPath.row)
        return cell
    }
    
    @objc func handleNextPage(button: UIButton) {
        Log.debug(msg: button.tag)
        if button.tag < projectsDes.count - 1 {
            let nextIndex = IndexPath(row: button.tag + 1, section: 0)
            collectionView.scrollToItem(at: nextIndex, at: .right, animated: true)
            print("currentPage: \(nextIndex.row)")
            currentPage = nextIndex.row
        }
    }
    
    @objc func handlePreviousPage(button: UIButton) {
        Log.debug(msg: currentPage)
        if currentPage != 0 {
            let indexPath = IndexPath(item: currentPage - 1, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            currentPage = indexPath.row
        }
    }
    
}

//MARK: - CollectionViewFLowLayoutDelegate
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 500)
    }
}

