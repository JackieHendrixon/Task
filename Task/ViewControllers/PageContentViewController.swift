//
//  Page.swift
//  Task
//
//  Created by Franek on 19/03/2020.
//  Copyright © 2020 Frankie. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController, PlaceViewModelDelegate {
   
    var placeViewModel: PlaceViewModel?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var imageLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        imageLeadingConstraint.constant = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = .zero
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    private func excludeImage(){
        let imagePath = UIBezierPath(rect: self.view.convert(imageView.frame, to: textView))
        textView.textContainer.exclusionPaths = [imagePath]
    }

    func refreshViews(){
        if let placeViewModel = placeViewModel, let image = placeViewModel.image {
            imageView.image = image
            textView.text = placeViewModel.description
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            excludeImage()
        }
    }

}
