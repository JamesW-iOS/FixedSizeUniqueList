import Foundation

enum FixedSizeListError: Error {
    case invalidIndex
}

/**
 This is a class that exposes an array  with a fixed size that
 */
class FixedSizeUniqueList<T: Codable & Equatable>: Codable {
    let size: Int
    private var _list = [T]()
    var list: [T] {
        let copy = _list
        return copy
    }

    init(size: Int) {
        self.size = size
    }

    func append(_ element: T) {
        if _list.count >= size {
            _ = _list.dropLast()
        }

        removeElement(element: element)
        _list.append(element)

    }

    func removeElement(at index: Int) throws {
        if index >= _list.count {
            throw FixedSizeListError.invalidIndex
        } else {
            _ = _list.remove(at: index)
        }
    }

    func removeElement(element: T) {
        _list.removeAll { listElement in
            element == listElement
        }
    }

    private func elementsEqual(elementA: T, elementB: T) -> Bool {
        elementA == elementB
    }
}
