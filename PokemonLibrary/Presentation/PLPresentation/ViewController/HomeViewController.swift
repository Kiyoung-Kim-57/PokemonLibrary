import UIKit

final class HomeViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
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
            return createListLayout(appearance: .plain, layoutEnvironment: layoutEnvironment)
        case .grid:
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .absolute(100)
            )
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(200),
                heightDimension: .absolute(100)
            )
            
            let section = createGridLayout(
                style: .horizontal,
                itemSize: itemSize,
                groupSize: groupSize
            )
            
            return section
        }
    }
    
    private func createListLayout(
        appearance: UICollectionLayoutListConfiguration.Appearance,
        layoutEnvironment: NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection {
        let layout = UICollectionLayoutListConfiguration(appearance: appearance)
        
        return NSCollectionLayoutSection.list(
            using: layout,
            layoutEnvironment: layoutEnvironment
        )
    }
    
    private func createGridLayout(
        style: GridStyle,
        itemSize: NSCollectionLayoutSize,
        groupSize: NSCollectionLayoutSize
    ) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        switch style {
        case .horizontal:
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            
            return NSCollectionLayoutSection(group: group)
        case .vertical:
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitems: [item]
            )
            
            return NSCollectionLayoutSection(group: group)
        }
    }
}
