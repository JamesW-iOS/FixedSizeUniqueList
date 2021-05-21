# FixedSizeUniqueList

## Overview
This package implements a list which will grow to a fixed size and then begin pushing out elements added last while also only allowing unique elements. An example use of a list like this would be saving the most recent searches performed by the user, you would want the list to be capped to a certain amount, not have duplicate entries and delete the oldest entries first. 

The list can hold any type that conforms to the Equatable and Codable protocols, FixedSizeUniqueList conforms to Codable itself.

New entries are added to the start of the list. If an element that already exists in the list is added again the element will move to the front of the list. For Example
```swift
let list = try FixedSizeUniqueList<Int>(size: size)
// []

list.prepend(2)
// [2]

list.prepend(3)
// [3, 2]

list.prepend(2)
// [2, 3]
```

## Example usage
### Create a list with a fixed save of 3 and a type of Int
```Swift
let list = try FixedSizeUniqueList<Int>(size: size)
```

### Adding elements to a list
```swift
let list = try FixedSizeUniqueList<Int>(size: size)
// []

list.prepend(2)
// [2]

list.prepend(3)
// [3, 2]

list.prepend(4)
// [4, 3, 2]

list.prepend(5)
// [5, 4, 3]
```

### Removing elements
```swift
let list = try FixedSizeUniqueList<Int>(size: size)
// []

list.prepend(2)
// [2]

list.prepend(3)
// [3, 2]

list.prepend(4)
// [4, 3, 2]

try list.removeElement(at: 1)
// [4, 2]
```

or

```swift
let list = try FixedSizeUniqueList<Int>(size: size)
// []

list.prepend(2)
// [2]

list.prepend(3)
// [3, 2]

list.prepend(4)
// [4, 3, 2]

try list.removeElement(2)
// [4, 3]
```
