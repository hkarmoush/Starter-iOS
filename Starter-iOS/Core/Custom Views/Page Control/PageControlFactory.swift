//
//  PageControlFactory.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 03/11/2023.
//

import UIKit

class PageControlFactory {

    static func create(with configuration: PageControlConfiguration) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = configuration.currentPageIndicatorTintColor
        pageControl.pageIndicatorTintColor = configuration.pageIndicatorTintColor
        pageControl.numberOfPages = configuration.numberOfPages
        pageControl.currentPage = configuration.currentPage
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }

}
