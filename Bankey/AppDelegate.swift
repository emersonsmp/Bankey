import UIKit

let appColor: UIColor = .systemTeal
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let dummyViewController = DummyViewController()
    let mainViewController = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        dummyViewController.logoutDelegate = self
        //window?.rootViewController = onboardingContainerViewController
        //window?.rootViewController = OnboardingContainerViewController()
        //window?.rootViewController = loginViewController
        //window?.rootViewController = mainViewController
        window?.rootViewController = AccountSummaryViewController()
        mainViewController.selectedIndex = 1
        
        return true
    }
    
}

extension AppDelegate: LoginViewControllerDelegate{
    
    func didLogin() {
        setRootViewController(onboardingContainerViewController)
        
        if LocalState.hasOnboarded{
            setRootViewController(dummyViewController)
        }else {
            setRootViewController(onboardingContainerViewController)
        }
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate{
    func didDoneOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(dummyViewController)
    }
    
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(loginViewController)
    }
}

extension AppDelegate: LogoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true){
        
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
    
}


