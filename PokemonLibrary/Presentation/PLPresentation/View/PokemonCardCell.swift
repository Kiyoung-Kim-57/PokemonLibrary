import UIKit
import SnapKit
import PLData

final class PokemonCardCell: UICollectionViewCell {
    static let reuseIdentifier = "PokemonCardCell"
    private let nameLabel = UILabel()
    private let pokemonImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(pokemon: PokemonEntity) {
        nameLabel.text = pokemon.name
        nameLabel.textAlignment = .center
        
        pokemonImageView.image = pokemon.image
        pokemonImageView.contentMode = .scaleAspectFit
        
        contentView.clipsToBounds = true
    }
    
    private func addSubviews() {
        [nameLabel, pokemonImageView].forEach { self.contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        pokemonImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(pokemonImageView)
        }
    }
}


extension PokemonCardCell {
    static let dummyData: [PokemonEntity] = [
        PokemonEntity(id: 1, name: "Kiyoung", image: UIImage(systemName: "globe") ?? UIImage()),
        PokemonEntity(id: 2, name: "Sunny", image: UIImage(systemName: "house") ?? UIImage()),
        PokemonEntity(id: 3, name: "Tynee", image: UIImage(systemName: "star") ?? UIImage()),
        PokemonEntity(id: 4, name: "Zzamong", image: UIImage(systemName: "person") ?? UIImage()),
    ]
    
    static let dummyData2: [PokemonEntity] = [
        PokemonEntity(id: 5, name: "Kiyoung", image: UIImage(systemName: "globe") ?? UIImage()),
        PokemonEntity(id: 6, name: "Sunny", image: UIImage(systemName: "house") ?? UIImage()),
        PokemonEntity(id: 7, name: "Tynee", image: UIImage(systemName: "star") ?? UIImage()),
        PokemonEntity(id: 8, name: "Zzamong", image: UIImage(systemName: "person") ?? UIImage()),
        PokemonEntity(id: 9, name: "Kiyoung", image: UIImage(systemName: "globe") ?? UIImage()),
        PokemonEntity(id: 10, name: "Sunny", image: UIImage(systemName: "house.fill") ?? UIImage()),
        PokemonEntity(id: 11, name: "Tynee", image: UIImage(systemName: "star") ?? UIImage()),
        PokemonEntity(id: 12, name: "Zzamong", image: UIImage(systemName: "person") ?? UIImage()),
    ]
}
