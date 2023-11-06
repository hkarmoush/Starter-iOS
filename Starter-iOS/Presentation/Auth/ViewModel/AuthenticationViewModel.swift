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
    
    let emailValid: Observable<Bool>
    let passwordValid: Observable<Bool>
    
    let isSignInActive: Observable<Bool>
    let isSignUpActive: Observable<Bool>
    
    private let authenticationUseCase: AuthenticationUseCaseProtocol
    private let validationService: ValidationServiceProtocol
    
    private let disposeBag = DisposeBag()
    
    init(authenticationUseCase: AuthenticationUseCaseProtocol, validationService: ValidationServiceProtocol) {
        self.authenticationUseCase = authenticationUseCase
        self.validationService = validationService
        
        emailValid = email
            .flatMapLatest { email in
                validationService.validateEmail(email)
                    .map { result in
                        if case .valid = result {
                            return true
                        } else {
                            return false
                        }
                    }
            }
            .startWith(false)
        
        passwordValid = password
            .flatMapLatest { password in
                validationService.validatePassword(password)
                    .map { strength in
                        strength != .weak
                    }
            }
            .startWith(false)
        
        isSignInActive = Observable.combineLatest(emailValid, passwordValid) { $0 && $1 }
        
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
