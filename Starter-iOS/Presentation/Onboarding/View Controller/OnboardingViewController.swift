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
        setupBindings()
    }
}
