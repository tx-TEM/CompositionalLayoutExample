import SwiftUI
import UIKit

final class HostingContentViewConfiguration: UIContentConfiguration {
    private(set) weak var parentVC: UIViewController?
    private(set) var content: () -> AnyView

    init(parentVC: UIViewController?, @ViewBuilder content: @escaping () -> AnyView) {
        self.parentVC = parentVC
        self.content = content
    }

    func makeContentView() -> UIView & UIContentView {
        return HostingContentView(configuration: self)
    }

    func updated(for _: UIConfigurationState) -> Self {
        return self
    }
}
