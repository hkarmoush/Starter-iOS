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
    
    private let viewModel: OnboardingViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = createCollectionView()
    private lazy var pageControl: UIPageControl = createPageControl()
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
    }
}

// MARK: - UI Setup
private extension OnboardingViewController {
    
    func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    func createPageControl() -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = viewModel.pagesCount
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }
    
    func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

// MARK: - Bindings
private extension OnboardingViewController {
    
    func setupBindings() {
        bindCollectionView()
        bindPageControl()
        observeSizeChanges()
    }
    
    func bindCollectionView() {
        viewModel.pages
            .bind(to: collectionView.rx.items(cellIdentifier: OnboardingCollectionViewCell.identifier, cellType: OnboardingCollectionViewCell.self)) { _, model, cell in
                cell.configure(with: model)
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.didEndDecelerating
            .map { [unowned self] _ in self.currentPageIndex() }
            .subscribe(onNext: viewModel.setCurrentIndex)
            .disposed(by: disposeBag)
    }
    
    func bindPageControl() {
        viewModel.currentIndex
            .observe(on: MainScheduler.instance)
            .bind(to: pageControl.rx.currentPage)
            .disposed(by: disposeBag)
    }
    
    func observeSizeChanges() {
        Observable.merge(
            rx.viewDidLayoutSubviews.map { _ in self.view.bounds.size },
            NotificationCenter.default.rx.notification(UIDevice.orientationDidChangeNotification).map { _ in self.view.bounds.size }
        )
        .distinctUntilChanged()
        .subscribe(onNext: { [unowned self] size in
            self.updateCollectionViewLayout(with: size)
        })
        .disposed(by: disposeBag)
    }
    
    func currentPageIndex() -> Int {
        let pageWidth = collectionView.frame.size.width
        return max(0, Int(collectionView.contentOffset.x / pageWidth))
    }
    
    func updateCollectionViewLayout(with size: CGSize) {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: size.width, height: size.height)
            layout.invalidateLayout()
        }
    }
}
