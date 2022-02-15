import UIKit

class ViewController: UIViewController {
    typealias Section = ViewModel.Section
    typealias Item = ViewModel.Item

    @IBOutlet var collectionView: UICollectionView!

    let viewModel = ViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    private var snapshot: NSDiffableDataSourceSnapshot<Section, Item>!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
}

extension ViewController {
    private func setupCollectionView() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView.collectionViewLayout = layout

        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { cell, indexPath, item in
            var config = UIListContentConfiguration.cell()
            switch item {
            case let .fruitItem(fruit):
                config.text = fruit.title
            }
            cell.contentConfiguration = config
        }

        // データの設定
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: item)
        }

        // データの読み込み
        snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        for section in Section.allCases {
            snapshot.appendItems(viewModel.items(for: section), toSection: section)
        }

        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

