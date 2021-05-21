import Foundation

enum FixedSizeListError: Error {
    case invalidIndex
    case invalidSize
}

/**
 This is a class that exposes an array  with a fixed size that
 */
class FixedSizeUniqueList<T: Codable & Equatable>: Codable {
    let size: Int
    private var _list: [T]
    var list: [T] {
        let copy = _list
        return copy
    }

    init(size: Int) throws {
        if size <= 0 {
            throw FixedSizeListError.invalidSize
        }

        self.size = size
        self._list = [T]()

    }

    func prepend(_ element: T) {
        // Remove any occurrences of the element to maintain uniqueness
        removeElement(element: element)
        _list.insert(element, at: 0)

        if _list.count > size {
            _ = _list.removeLast()
        }
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
