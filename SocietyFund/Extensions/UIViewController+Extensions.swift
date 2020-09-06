
//
//  UIViewController+Extensions.swift
//  SocietyFund
//
//  Created by sanish on 8/28/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit
import Lottie
import JGProgressHUD
import MMDrawerController
import MaterialComponents.MDCActivityIndicator

var vSpinner: UIView?

extension UIViewController {
    func addOverlayView(with color: UIColor) {
        PlainColoredView.uiView.backgroundColor = color
        self.view.addSubview(PlainColoredView.uiView)
        PlainColoredView.uiView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            PlainColoredView.uiView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            PlainColoredView.uiView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            PlainColoredView.uiView.topAnchor.constraint(equalTo: self.view.topAnchor),
            PlainColoredView.uiView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
    }
    
    func removeOverlayView() {
        PlainColoredView.uiView.removeFromSuperview()
    }
    
    func alert(message: String, title: String = "Error!") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        alertController.isSpringLoaded = true
        DispatchQueue.main.async {
          self.present(alertController, animated: true, completion: nil)
        }
       
    }
    typealias CompletionHandler = (Result<Data, Error>) -> Void
    func setProfileImage(_ url: String, completion: @escaping CompletionHandler){
        if let url = URL(string: url) {
           URLSession.shared.dataTask(with: url) { (data, response, error) in
               guard error == nil else {
                completion(.failure(error!))
                return }
               guard let data = data, let response = response else {
                completion(.failure(error!))
                   return
               }
            if let response = response as? HTTPURLResponse {
                if (200...299).contains(response.statusCode) {
                    completion(.success(data))
                }else{
                     completion(.failure(error!))
                }
            }
            
           }.resume()
        }
    }
   
    
    func showNoDataLabel(inView: UIView, text: String? = "No Data Found.") {
        let label = Label.noDataFoundLabel
        label.text = text ?? "No Data Found."
        label.font = FontConfig().regularFont
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        self.view.addSubview(label)
        
        label.widthAnchor.constraint(equalTo: inView.widthAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: inView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: inView.centerYAnchor).isActive = true
    }
    
    func hideNoDataLabel() {
        Label.noDataFoundLabel.isHidden = true
    }
    
    func showLoading() {
        let container = LoadingIndicator.container
        container.frame = self.view.frame
        container.center = self.view.center
        container.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = self.view.center
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd = LoadingIndicator.loadingIndicator
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        actInd.style = .whiteLarge
        actInd.hidesWhenStopped = true
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2,
                                y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        self.view.addSubview(container)
        actInd.startAnimating()
    }
    
    func showLoadingWhite() {
        let container = LoadingIndicator.container
        container.frame = self.view.frame
        container.center = self.view.center
        container.backgroundColor = UIColor.clear
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        loadingView.center = self.view.center
        loadingView.backgroundColor = UIColor.clear
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd = LoadingIndicator.loadingIndicator
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        actInd.style = .gray
        actInd.hidesWhenStopped = true
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2,
                                y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        self.view.addSubview(container)
        actInd.startAnimating()
    }
    
    func hideLoading() {
        LoadingIndicator.loadingIndicator.stopAnimating()
        LoadingIndicator.container.removeFromSuperview()
    }
    
    @objc func showFromDatePicker() {
        let datePicker = DatePicker.fromDatePicker
        datePicker.tag = 0
        self.setupAndShowDatePicker(datePicker: datePicker)
    }
    
    @objc func showToDatePicker() {
        let datePicker = DatePicker.toDatePicker
        datePicker.tag = 1
        self.setupAndShowDatePicker(datePicker: datePicker)
    }
    
    private func setupAndShowDatePicker(datePicker: UIDatePicker) {
        let toolBar = DatePicker.toolBar
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = ColorConfig.BorderColor
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(endEditing))
        doneButton.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): FontConfig(fontSize: 18).regularFont!], for: .normal)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.isUserInteractionEnabled = true
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        self.view.addSubview(datePicker)
        datePicker.backgroundColor = .white
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        //datePicker.date = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        datePicker.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        datePicker.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.view.addSubview(toolBar)
        toolBar.bottomAnchor.constraint(equalTo: datePicker.topAnchor).isActive = true
        toolBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        toolBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
    
    func addDoneToolbar(inView: UIView) {
        let toolBar = DatePicker.toolBar
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = ColorConfig.BorderColor
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(endEditing))
        doneButton.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): FontConfig(fontSize: 18).regularFont!], for: .normal)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.isUserInteractionEnabled = true
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        self.view.addSubview(toolBar)
        toolBar.bottomAnchor.constraint(equalTo: inView.topAnchor).isActive = true
        toolBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        toolBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
    
    @objc
    func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateUtils.dateFormat4
        let date = dateFormatter.string(from: datePicker.date)
        dateChanged(datePicker: datePicker, selectedDate: date)
    }
    
    @objc
    func dateChanged(datePicker: UIDatePicker, selectedDate: String) {
        
    }
    
    @objc
    func endEditing() {
        DatePicker.toolBar.removeFromSuperview()
        DatePicker.fromDatePicker.removeFromSuperview()
        DatePicker.toDatePicker.removeFromSuperview()
    }
    
    func showAnimation(with name: String, in view: UIView, completion: ((AnimationView) -> ())?) {
        let animationView = LottieAnimation.animationView
        let animation = Animation.named(name, subdirectory: "Animations")
        
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        self.view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        completion?(animationView)
    }
    
    func setTrim(Val: String, trimChar: String) -> String{
        let seperator = Val.components(separatedBy: trimChar)
        return seperator[0]
    }
    
    func showSimpleHUD(title: String, description: String? = nil, progressHudView: (JGProgressHUD)->()) {
        let hud = JGProgressHUD(style: .dark)
        hud.vibrancyEnabled = true
        hud.textLabel.text = title
        hud.textLabel.font = FontConfig().regularFont
        hud.detailTextLabel.text = description
        hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
        hud.show(in: self.view)
        progressHudView(hud)
    }
    
    func showSuccessHUD(hud: JGProgressHUD, message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            UIView.animate(withDuration: 0.1, animations: {
                hud.textLabel.text = "Success"
                hud.textLabel.font = FontConfig().regularFont
                hud.detailTextLabel.text = message
                hud.detailTextLabel.font = FontConfig().regularFont
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            })
            hud.dismiss(afterDelay: 2.0)
        }
    }
    
    func showFailureHUD(hud: JGProgressHUD, message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            UIView.animate(withDuration: 0.1, animations: {
                hud.textLabel.text = "Failure"
                hud.textLabel.font = FontConfig().regularFont
                hud.detailTextLabel.text = message
                hud.detailTextLabel.font = FontConfig().regularFont
                hud.indicatorView = JGProgressHUDErrorIndicatorView()
            })
            
            hud.dismiss(afterDelay: 2.0)
        }
    }
    
    func showFailure(text: String, progressHudView: (JGProgressHUD)->()) {
        let hud = JGProgressHUD(style: .dark)
        hud.vibrancyEnabled = true
        hud.textLabel.text = text
        hud.textLabel.font = FontConfig().regularFont
        hud.detailTextLabel.text = nil
        hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
        hud.indicatorView = JGProgressHUDErrorIndicatorView()
        hud.show(in: self.view)
        progressHudView(hud)
    }
    
    func messageAlert(message: String, title: String = "Error!") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        self.removeSpinner()
    }
    
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    func isValidFullName(fullNameStr:String) -> Bool {
        let fullnameRegEx = "^([A-z\\'\\.-ᶜ]*(\\s))+[A-z\\'\\.-ᶜ]+$"
        let fullNamePred = NSPredicate(format:"SELF MATCHES %@", fullnameRegEx)
        return fullNamePred.evaluate(with: fullNameStr)
    }
 
    func isValidMobileNumber(mobileStr:String) -> Bool {
        let mobileRegEx = "[1-9]{1}[0-9]{7,11}$"
        let mobilePred = NSPredicate(format:"SELF MATCHES %@", mobileRegEx)
        return mobilePred.evaluate(with: mobileStr)
    }
    
    func isValid(regex: String, value: String) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: value)
    }
    
    func setDate(date: String) -> String {
        // create dateFormatter with UTC time format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+mm:ss"
        let dateVal = dateFormatter.date(from: date)
        
        // change to a readable time format and change to local time zone
        dateFormatter.dateFormat = "EEE,d MMM, yyyy h:mm a"
        dateFormatter.timeZone = NSTimeZone.local
        let timeStamp = dateFormatter.string(from: dateVal!)
        return timeStamp
    }
    
    func secondsToHoursMinutesSeconds (seconds : Double) -> (hr: Double, min: Double, sec: Double) {
        let (hr,  minf) = modf (seconds / 3600)
        let (min, secf) = modf (60 * minf)
        return  (hr, min, 60 * secf)
    }
    
    func cellActivityIndicator(show: Bool, collectionView: UICollectionView? = nil, loadingIndicator: MDCActivityIndicator) {
        
//        loadingIndicator.style = UIActivityIndicatorView.Style.gray
//        loadingIndicator.color = ColorConfig.BorderColor
        
        if let collectionView = collectionView {
            collectionView.addSubview(loadingIndicator)
            loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
            loadingIndicator.heightAnchor.constraint(equalToConstant: 150).isActive = true
            loadingIndicator.widthAnchor.constraint(equalToConstant: 150).isActive = true
            loadingIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
            loadingIndicator.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 10).isActive = true
        }
        
        if show == true {
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
            
        } else {
            loadingIndicator.isHidden = true
//            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.stopAnimating()
        }
    }


    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = .clear
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.color = ColorConfig.ButtonPrimary
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    // Set Navigation Bar Item Image for TabBar
    func setNavigationBarItem() {
        guard let menuImage = UIImage(systemName: "line.horizontal.3") else {
            print("Not found menu or notification image")
            return
        }
        
        guard let searchImage = UIImage(systemName: "magnifyingglass") else {
            print("Not found menu or search image")
            return
        }
        guard let logo = UIImage(named: "smallLogo") else {
            print("Not found logo image")
            return
        }
        addLeftBarButtonWithImage(menuImage)
        addRightBarButtonWithImage(searchImage)
        addBarButtonsWithTitleAndImage(menuImage,searchImage,logo)
     }
    
     func addLogoToNavigationBarItem() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "smallLogo")
        //imageView.backgroundColor = .lightGray
        let contentView = UIView()
        self.navigationItem.titleView = contentView
        self.navigationItem.titleView?.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    public func addBarButtonsWithTitleAndImage(_ buttonImage1: UIImage, _ buttonImage2: UIImage, _ buttonImage3: UIImage) {
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage1, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.toggle))
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage2, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.showSearchBar))
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.titleView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.width/2, width: 100, height: 100))
    }
    
    @objc public func toggle() {
        mmDrawerContainer?.toggle(.left, animated: true, completion: nil)
    }
    
    @objc public func showSearchBar() {
        
    }
    
//    func startActivityIndicator() {
//        
//        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
//        
//        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.style = UIActivityIndicatorView.Style.gray
//        loadingIndicator.startAnimating()
//        alert.view.addSubview(loadingIndicator)
//        present(alert, animated: true, completion: nil)
//    }
//    
//    func stopActivityIndicator() {
//        self.dismiss(animated: false, completion: nil)
//    }
//    

}

