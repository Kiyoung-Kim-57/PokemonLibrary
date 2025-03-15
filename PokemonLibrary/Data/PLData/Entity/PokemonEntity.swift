import Foundation
import UIKit

public struct PokemonEntity: Hashable, Sendable {
    public var id: Int
    public var name: String
    public var image: UIImage
}
