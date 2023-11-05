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
    
    var pagesCount: Int {
        return (try? pagesSubject.value().count) ?? 0
    }
    
    init() {
        let onboardingPages = [
            OnboardingPage(title: "Welcome", description: "Welcome to our app. Discover a seamless experience tailored for you.", imageName: "OnboardingArtwork1"),
            OnboardingPage(title: "Explore", description: "Explore the features. Find tools and insights to help you achieve more.", imageName: "OnboardingArtwork2"),
            OnboardingPage(title: "Stay Connected", description: "Stay connected with your friends and colleagues. Never miss out on an important update.", imageName: "OnboardingArtwork3"),
            OnboardingPage(title: "Organize", description: "Organize your tasks and projects efficiently. Boost your productivity.", imageName: "OnboardingArtwork4"),
            OnboardingPage(title: "Achieve", description: "Set your goals and track your progress. Achieve your dreams step by step.", imageName: "OnboardingArtwork5"),
        ]
        pagesSubject.onNext(onboardingPages)
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
    
    func setCurrentIndex(to index: Int) {
            currentIndexSubject.onNext(index)
        }
}
