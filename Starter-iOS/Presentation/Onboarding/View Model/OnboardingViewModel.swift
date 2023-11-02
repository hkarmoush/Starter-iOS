//
//  OnboardingViewModel.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 02/11/2023.
//

import RxSwift

class OnboardingViewModel {
    
    private let pagesSubject = BehaviorSubject<[OnboardingPage]>(value: [])
    private let currentIndexSubject = BehaviorSubject<Int>(value: 0)
    
    var pages: Observable<[OnboardingPage]> {
        return pagesSubject.asObserver()
    }
    
    var currentIndex: Observable<Int> {
        return currentIndexSubject.asObserver()
    }
    
    init() {
        let initialPages = [
            OnboardingPage(title: "Welcome", description: "Welcome to our app"),
            OnboardingPage(title: "Explore", description: "Explore the features"),
        ]
        pagesSubject.onNext(initialPages)
    }
    
    func nextPage() {
        currentIndexSubject
            .take(1)
            .subscribe(onNext: { [weak self] index in
                guard let `self` = self else { return }
                let nextIndex = index + 1
                self.currentIndexSubject.onNext(nextIndex)
            })
            .dispose()
    }
    
    func previousPage() {
        currentIndexSubject
            .take(1)
            .subscribe(onNext: { [weak self] index in
                guard let `self` = self else { return }
                let prevIndex = max(index - 1, 0)
                self.currentIndexSubject.onNext(prevIndex)
            })
            .dispose()
    }
}
