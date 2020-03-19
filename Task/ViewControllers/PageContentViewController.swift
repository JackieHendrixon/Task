//
//  Page.swift
//  Task
//
//  Created by Franek on 19/03/2020.
//  Copyright © 2020 Frankie. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {
   
    // MARK: - Properties
    
    var placeModel: PlaceModel?
    
    // MARK: - Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        imageLeadingConstraint.constant = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = .zero
        if let place = placeModel {
        NetworkingClient.instance.fetchImage(from: place.icon) {
            self.imageView.image = $0
            self.textView.addSubview(self.imageView)
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.excludeImage()
        }
        textView.text = place.description
        }
    }
    
    // MARK: - Private functions
    
    private func excludeImage(){
        let imagePath = UIBezierPath(rect: self.view.convert(imageView.frame, to: textView))
        textView.textContainer.exclusionPaths = [imagePath]
    }
}
