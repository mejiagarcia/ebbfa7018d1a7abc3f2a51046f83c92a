import Foundation

protocol RouterProtocol {
   associatedtype Transitions
    func routeTo(transition: Transitions)
}
