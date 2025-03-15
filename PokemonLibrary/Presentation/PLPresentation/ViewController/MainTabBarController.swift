import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        
        self.setViewControllers(viewControllers, animated: false)
        self.tabBar.backgroundColor = .systemBackground.withAlphaComponent(0.8)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func setTabBarItem(
        at index: Int,
        itemHandler: (UITabBarItem) -> ()
    ) {
        guard let items = tabBar.items, index < items.count, index >= 0 else { return }
        
        itemHandler(items[index])
    }
}
