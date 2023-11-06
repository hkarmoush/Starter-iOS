//
//  OnboardingViewController.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 02/11/2023.
//

import UIKit
import RxSwift
import RxCocoa

class OnboardingViewController: UIViewController {
    
    let viewModel: OnboardingViewModel
    let disposeBag = DisposeBag()
    
    lazy var collectionView: UICollectionView = createCollectionView()
    lazy var pageControl: UIPageControl = createPageControl()
    lazy var nextButton: UIButton = createNextButton()
    
    weak var coordinatorDelegate: OnboardingCoordinator?
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("Deallocating OnboardingViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupReactiveBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
}
