import UIKit

final class HomeViewController: UICollectionViewController {
    typealias CellItem = PokemonEntity
    private var diffableDataSource: UICollectionViewDiffableDataSource<Section, CellItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setDiffableDataSource()
        applyInitalSnapshot()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { [unowned self] idx, env in
            let layoutType = LayoutType(rawValue: idx) ?? LayoutType.list
            return createLayouts(type: layoutType, layoutEnvironment: env)
        }
        
        collectionView.collectionViewLayout = layout
    }
    
    private func createLayouts(
        type: LayoutType,
        layoutEnvironment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection {
        switch type {
        case .list:
            return createListLayout()
        case .grid:
            let section = createGridLayout(style: .horizontal)
            section.orthogonalScrollingBehavior = .paging
            return section
        }
    }
    
    private func createListLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(50)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.3)
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func createGridLayout(
        style: GridStyle
    ) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.33),
            heightDimension: .fractionalHeight(1)
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.5)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        switch style {
        case .horizontal:
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            
            let containerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(300)
            )
            
            let containerGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: containerSize,
                repeatingSubitem: group,
                count: 2
            )
            
            return NSCollectionLayoutSection(group: containerGroup)
        case .vertical:
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitems: [item]
            )
            
            return NSCollectionLayoutSection(group: group)
        }
    }
}

// MARK: DiffableDataSource
extension HomeViewController {
    private func listConfiguration() -> UICollectionView.CellRegistration<UICollectionViewListCell, CellItem> {
        let config = UICollectionView.CellRegistration<UICollectionViewListCell, PokemonEntity> {
            cell, indexPath, item in
            var content = UIListContentConfiguration.cell()
            content.text = item.name
            content.secondaryText = "\(item.id)"
            content.image = item.image
            cell.contentConfiguration = content
        }
        
        return config
    }
    
    private func setDiffableDataSource() {
        let listConfiguration = listConfiguration()
        self.collectionView.register(
            PokemonCardCell.self,
            forCellWithReuseIdentifier: PokemonCardCell.reuseIdentifier
        )
        
        self.diffableDataSource = UICollectionViewDiffableDataSource<Section, CellItem>(collectionView: self.collectionView) { [unowned self]
            collectionView,
            indexPath,
            item in
            
            switch indexPath.section {
            case 0:
                return collectionView.dequeueConfiguredReusableCell(
                    using: listConfiguration,
                    for: indexPath,
                    item: item)
            case 1:
                return setGirdCellConfiguration(
                    collectionView: collectionView,
                    for: indexPath,
                    item: item)
            default:
                return collectionView.dequeueConfiguredReusableCell(
                    using: listConfiguration,
                    for: indexPath,
                    item: item)
            }
        }
    }
    
    private func setGirdCellConfiguration(
        collectionView: UICollectionView,
        for indexPath: IndexPath,
        item: CellItem
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PokemonCardCell.reuseIdentifier,
            for: indexPath
        ) as! PokemonCardCell
        
        cell.configure(pokemon: item)
        
        return cell
    }
    
    private func applyInitalSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CellItem>()
        
        snapshot.appendSections(Section.allCases)
        
        snapshot.appendItems(PokemonCardCell.dummyData, toSection: .list)
        snapshot.appendItems(PokemonCardCell.dummyData2, toSection: .grid)
        
        self.diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func applyNewSnapshot(_ items: [CellItem], to section: Section) {
        var snapshot = diffableDataSource.snapshot()
        let prevData = snapshot.itemIdentifiers(inSection: section)
        snapshot.deleteItems(prevData)
        
        snapshot.appendItems(items, toSection: section)
        diffableDataSource.apply(snapshot)
    }
}

enum Section: CaseIterable {
    case list
    case grid
}
