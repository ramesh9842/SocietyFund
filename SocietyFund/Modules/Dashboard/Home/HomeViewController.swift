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
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var viewSignUp: UIView!
    @IBOutlet weak var viewLogin: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var searchController: UISearchController!
    var current = 0
    var timer: Timer!
    var homeVM = HomeViewModel()
    var projects = [CategoricalProject]()
    private let identifier = "trendingProjectCollectionCell"
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Log.debug(msg: "viewWillAppear")
        
        if UserDefaults.standard.data(forKey: "profile") != nil {
            userLoggedIn()
        }else {
            userLoggedOut()
        }
        /*
         if let token = AccessToken.current,
         !token.isExpired {
         userLoggedIn()
         }else if(isGoogleSignedIn == true) {
         userLoggedIn()
         }else {
         userLoggedOut()
         }
         */
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
        setUpView()
        addLogoToNavigationBarItem()
        showSpinner(onView: self.view)
        homeVM.setUpView()
        setTimer()
        
        homeVM.delegate = self
    }
    
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScroll), userInfo: nil,
                                     repeats: true)
    }
    
    // create auto scroll
    @objc func autoScroll() {
        current += 1
        self.pageControl.currentPage = current
        if current < projects.count {
            let indexPath = IndexPath(item: current, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            
        } else {
            current = 0
            self.pageControl.currentPage = current
            self.collectionView.scrollToItem(at: IndexPath(item: current, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    @IBAction func scrollRight(_ sender: UIButton) {
        timer.invalidate()
        if current < self.projects.count - 1 {
            current += 1
            self.pageControl.currentPage = current
            let indexPath = IndexPath(item: current, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
            
        }else {
            self.pageControl.currentPage = 0
            current = 0
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
            
        }
    }
    
    
    @IBAction func scrollLeft(_ sender: UIButton) {
        timer.invalidate()
        Log.debug(msg: current)
        if current == 0 {
            current = projects.count - 1
            self.pageControl.currentPage = current
            let indexPath = IndexPath(item: current, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }else {
            current -= 1
            self.pageControl.currentPage = current
            let indexPath = IndexPath(item: current, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        }
    }
    
    func setUpView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.alwaysBounceHorizontal = true
        self.collectionView.isScrollEnabled = false
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        containerView.isHidden = true
    }
    
}

// MARK: - HomeViewDelegate
extension HomeViewController: HomeViewDelegate {
    func onSuccess(_ projects: [CategoricalProject]) {
        removeSpinner()
        self.projects = projects
        DispatchQueue.main.async {
            self.pageControl.currentPage = 0
            self.pageControl.numberOfPages = projects.count
            self.containerView.isHidden = false
            self.collectionView.reloadData()
        }
    }
    
    func onFailure(msg: String) {
        removeSpinner()
        DispatchQueue.main.async {
            self.collectionView.isHidden = true
        }
        alert(message: msg, title: "")
    }
}

//MARK: - CollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HomeCollectionCell
        let project = self.projects[indexPath.row]
        let raisedAmt = project.raisedAmount ?? 0
        let goalAmt = project.goalAmount ?? 0
        cell.lblTitle.text = project.title
        cell.lblProjectDesc.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
        collectionViewHeight.constant = collectionView.contentSize.height
        cell.progressBar.setProgress(Float(raisedAmt/goalAmt), animated: true)
        cell.lblSupporters.text = "\(String(describing: project.donor!.count))"
        cell.lblRaisedStat.text = "Rs. \(raisedAmt) of Rs. \(goalAmt)"
        cell.lblActive.text = (project.status! == 1 ? "Active" : "Inactive")
    
        return cell
    }
    
}

//MARK: - CollectionViewFLowLayoutDelegate
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 500)
    }
}

