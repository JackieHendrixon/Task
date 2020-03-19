//
//  PageViewController.swift
//  Task
//
//  Created by Franek on 19/03/2020.
//  Copyright © 2020 Frankie. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    // MARK: - Properties
    
    var places = [PlaceModel]()
    private lazy var orderedViewControllers: [UIViewController] = {
        return places.map(newViewController)
    }()
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
        self.view.backgroundColor = .white
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }

    // MARK: - Private functions
    
    private func newViewController(place: PlaceModel) -> UIViewController{
        let pageContentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageContentViewController") as! PageContentViewController
        
        pageContentViewController.placeModel = place
        return pageContentViewController
    }
}

// MARK: - DataSource extension

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil}
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard previousIndex < orderedViewControllers.count else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else { return nil}
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex > 0 else {
            return nil
        }
        
        guard nextIndex < orderedViewControllers.count else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return places.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}

// MARK: Delegate extension

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let pageContentViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: pageContentViewController)   {
        }
    }
}
