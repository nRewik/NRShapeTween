# NRShapeTween

Morph the shape easier. Animate basic shape tweening by just setting the side.
  
  
  
![picture alt](https://raw.githubusercontent.com/nRewik/NRShapeTween/master/Document/example_1.gif "exmaple_1")   |
------------- |
![picture alt](https://raw.githubusercontent.com/nRewik/NRShapeTween/master/Document/example_2.gif "exmaple_2")  |

## Usage ##

### Initialization
```swift 
var shapeTweenView = NRShapeTweenView(frame: frame)
```
#### Xcode IBDesignable (NRShapeTweenView)
![picture alt](https://raw.githubusercontent.com/nRewik/NRShapeTween/master/Document/Xcode_IBDesignable_1.png "exmaple_1")
![picture alt](https://raw.githubusercontent.com/nRewik/NRShapeTween/master/Document/Xcode_IBDesignable_2.png "exmaple_1")

### Set The Shape  
```swift 
shapeTweenView.side = 1.0 //must be greater than 1

shapeTweenView.side = 3.33

shapeTweenView.side = 4.0
```
  
### Animate The Shape  
```swift 
shapeTweenView.animateToSide(6.0, duration: 3.0)
```

### Change Appearance  
```swift
shapeTweenView.borderColor = UIColor.blackColor()
shapeTweenView.borderWidth = 2.0
shapeTweenView.fillColor = UIColor.blackColor()
```
- - - -
Developed by __[Nutchaphon Rewik](https://github.com/nRewik)__
