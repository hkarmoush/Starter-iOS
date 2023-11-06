//
//  AuthenticationViewModel.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 06/11/2023.
//
import RxSwift

class AuthenticationViewModel {
    
    let email = BehaviorSubject<String>(value: "")
    let password = BehaviorSubject<String>(value: "")
    let name = BehaviorSubject<String>(value: "")
    
    let isSignInActive: Observable<Bool>
    let isSignUpActive: Observable<Bool>
    
    private let authenticationUseCase: AuthenticationUseCaseProtocol
    
    private let disposeBag = DisposeBag()
    
    init(authenticationUseCase: AuthenticationUseCaseProtocol) {
        self.authenticationUseCase = authenticationUseCase
        
        isSignInActive = Observable.combineLatest(email, password) { email, password in
            return !email.isEmpty && !password.isEmpty
        }
        
        isSignUpActive = Observable.combineLatest(name, email, password) { name, email, password in
            return !name.isEmpty && !email.isEmpty && !password.isEmpty
        }
    }
    
    func signIn() -> Observable<User> {
        return Observable.create { [unowned self] observer in
            do {
                let emailValue = try self.email.value()
                let passwordValue = try self.password.value()
                let disposable = self.authenticationUseCase.signIn(email: emailValue, password: passwordValue)
                    .subscribe(onNext: { user in
                        observer.onNext(user)
                    }, onError: { error in
                        observer.onError(error)
                    })
                return Disposables.create {
                    disposable.dispose()
                }
            } catch {
                observer.onError(error)
                return Disposables.create()
            }
        }
    }
    
    func signUp() -> Observable<User> {
        return Observable.create { [unowned self] observer in
            do {
                let nameValue = try self.name.value()
                let emailValue = try self.email.value()
                let passwordValue = try self.password.value()
                let disposable = self.authenticationUseCase.signUp(name: nameValue, email: emailValue, password: passwordValue)
                    .subscribe(onNext: { user in
                        observer.onNext(user)
                    }, onError: { error in
                        observer.onError(error)
                    })
                return Disposables.create {
                    disposable.dispose()
                }
            } catch {
                observer.onError(error)
                return Disposables.create()
            }
        }
    }
    
    func recoverPassword() -> Observable<Void> {
        return Observable.create { [unowned self] observer in
            do {
                let emailValue = try self.email.value()
                let disposable = self.authenticationUseCase.recoverPassword(email: emailValue)
                    .subscribe(onNext: {
                        observer.onNext(())
                    }, onError: { error in
                        observer.onError(error)
                    })
                return Disposables.create {
                    disposable.dispose()
                }
            } catch {
                observer.onError(error)
                return Disposables.create()
            }
        }
    }
}
