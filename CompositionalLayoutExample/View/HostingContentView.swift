import SwiftUI
import UIKit

final class HostingContentView: UIView, UIContentView {
    var hostingController: UIHostingController<AnyView>
    var configuration: UIContentConfiguration

    init(configuration: HostingContentViewConfiguration) {
        self.configuration = configuration
        hostingController = UIHostingController(rootView: configuration.content())
        super.init(frame: .zero)
        setup(parentVC: configuration.parentVC)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        removeHostingControllerFromParent()
    }
}

extension HostingContentView {
    public func setup(parentVC: UIViewController?) {
        guard let parentVC = parentVC else {
            return
        }
        let vc = hostingController
        vc.view.backgroundColor = .clear
        vc.willMove(toParent: parentVC)
        parentVC.addChild(vc)
        vc.didMove(toParent: parentVC)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(vc.view)
        NSLayoutConstraint.activate([
            vc.view.topAnchor.constraint(equalTo: topAnchor),
            vc.view.bottomAnchor.constraint(equalTo: bottomAnchor),
            vc.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            vc.view.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    public func removeHostingControllerFromParent() {
        hostingController.willMove(toParent: nil)
        hostingController.view.removeFromSuperview()
        hostingController.removeFromParent()
    }
}
