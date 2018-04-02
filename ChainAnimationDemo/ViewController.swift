//
//  ViewController.swift
//  ChainAnimationDemo
//
//  Created by Kelvin Fok on 2/4/18.
//  Copyright © 2018 kelvinfok. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var redColor = UIColor(red: 244/255, green: 65/255, blue: 65/255, alpha: 1)
    
    lazy var proceedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = redColor
        button.setTitle("Proceed", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(showMainViewController), for: .touchUpInside)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 40)
        return label
    }()
    
    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel])
    
    lazy var content: [(title: String, description: String)] = [
                                            ("Welcome to Popsical Karaoke", "Hello there! Thanks for much for downloading our app and giving us a try. Make sure to leave us a good review in the AppStore!"),
                                            ("Karaoke with the family today", "Now you can sing to your heart's content with your aunties and uncles without breaking the bank! 💵"),
                                            ("Sing till the cows go home", "Maybe you like animals? How about some fresh milk with cookies? 🍪\n\nOr do you prefer pizza instead?"),
                                            ("Try not to irritate your neighbours", "Our speakers can go very loud. Like Boom Boom Pow Singapore style! 🔈")]
    
    private var currentPage = 0
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = content.count
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .darkGray
        return pageControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        setupLabels(withPage: currentPage)
        setupPageControl()
    }
    
    func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapAnimations))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupPageControl() {
        view.addSubview(pageControl)
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.widthAnchor.constraint(equalToConstant: 240).isActive = true
    }
    
    func setupLabels(withPage page: Int) {
        pageControl.currentPage = page
        titleLabel.text = content[page].title
        bodyLabel.text = content[page].description
        bodyLabel.textColor = .darkGray
        bodyLabel.numberOfLines = 0
        titleLabel.numberOfLines = 0
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        if !stackView.isDescendant(of: view) {
            view.addSubview(stackView)
        }
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -88).isActive = true
        self.view.layoutIfNeeded()
    }
    
    func removeStackView() {
        stackView.removeFromSuperview()
    }

    @objc func handleTapAnimations() {
        // First animation
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.titleLabel.alpha = 0.8
            self.titleLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.titleLabel.alpha = 0
                self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: -550)
            }, completion: nil )
        }
        // Second animation
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.bodyLabel.alpha = 0.8
            self.bodyLabel.transform = CGAffineTransform(translationX: -30, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.bodyLabel.alpha = 0
                self.bodyLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: -550)
            }, completion: { _ in
                self.removeStackView()
                self.titleLabel.alpha = 1
                self.titleLabel.transform = .identity
                self.bodyLabel.alpha = 1
                self.bodyLabel.transform = .identity
                self.currentPage += 1
                if self.currentPage < self.content.count {
                    self.setupLabels(withPage: self.currentPage)
                } else {
                    self.showProceedButton()
                }
            })
        }
    }
    
    func showProceedButton() {
        pageControl.removeFromSuperview()
        view.addSubview(proceedButton)
        proceedButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        proceedButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        proceedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        proceedButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    @objc func showMainViewController() {
        let mainViewController = UIViewController()
        mainViewController.view.backgroundColor = redColor
        mainViewController.title = "Main Page"
        self.present(mainViewController, animated: true, completion: nil)
    }
}
