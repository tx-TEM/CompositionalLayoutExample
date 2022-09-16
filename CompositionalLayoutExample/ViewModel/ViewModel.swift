import Foundation

struct ViewModel {
    private let fruits: [Fruit]

    init() {
        fruits = [
            Fruit(title: "りんご"),
            Fruit(title: "みかん"),
            Fruit(title: "ぶどう"),
            Fruit(title: "もも"),
            Fruit(title: "メロン"),

        ]
    }

    func items(for section: Section) -> [Item] {
        switch section {
        case .fruitSection:
            return fruits.map { Item.fruitItem($0) }
        }
    }
}

extension ViewModel {
    enum Section: Int, CaseIterable {
        case fruitSection
    }

    enum Item: Hashable {
        case fruitItem(Fruit)
    }
}

extension ViewModel {
    struct Fruit: Hashable {
        let identifier = UUID()
        let title: String
    }
}
