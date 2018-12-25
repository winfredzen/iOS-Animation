/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

enum StickyEdge: Int {
  case top = 0
  case bottom
}

class StickyEdgesBehavior: UIDynamicBehavior {
  fileprivate var edgeInset: CGFloat
  fileprivate let itemBehavior: UIDynamicItemBehavior
  fileprivate let collisionBehavior: UICollisionBehavior
  fileprivate let item: UIDynamicItem
  fileprivate let fieldBehaviors = [
    UIFieldBehavior.springField(),
    UIFieldBehavior.springField()
  ]
  
  init(item: UIDynamicItem, edgeInset: CGFloat) {
    self.item = item
    self.edgeInset = edgeInset
    
    collisionBehavior = UICollisionBehavior(items: [item])
    collisionBehavior.translatesReferenceBoundsIntoBoundary = true
    
    itemBehavior = UIDynamicItemBehavior(items: [item])
    itemBehavior.density = 0.01
    itemBehavior.resistance = 20
    itemBehavior.friction = 0.0
    itemBehavior.allowsRotation = false
    
    super.init()
    
    addChildBehavior(collisionBehavior)
    addChildBehavior(itemBehavior)
    
    for fieldBehavior in fieldBehaviors {
      fieldBehavior.addItem(item)
      addChildBehavior(fieldBehavior)
    }
  }
  
  func updateFieldsInBounds(_ bounds: CGRect) {
    guard bounds != CGRect.zero else { return }
    let h = bounds.height
    let w = bounds.width
    let itemHeight = item.bounds.height
    
    func updateRegionForField(_ field: UIFieldBehavior, _ point: CGPoint) {
      let size = CGSize(width: w - 2 * edgeInset, height: h - 2 * edgeInset - itemHeight)
      field.position = point
      field.region = UIRegion(size: size)
    }
    
    let top = CGPoint(x: w / 2, y: edgeInset + itemHeight / 2)
    let bottom = CGPoint(x: w / 2, y: h - edgeInset - itemHeight / 2)
    updateRegionForField(fieldBehaviors[StickyEdge.top.rawValue], top)
    updateRegionForField(fieldBehaviors[StickyEdge.bottom.rawValue], bottom)
    
  }
  
  var isEnabled = true {
    didSet {
      if isEnabled {
        for fieldBehavior in fieldBehaviors {
          fieldBehavior.addItem(item)
        }
        collisionBehavior.addItem(item)
        itemBehavior.addItem(item)
      } else {
        for fieldBehavior in fieldBehaviors {
          fieldBehavior.removeItem(item)
        }
        collisionBehavior.removeItem(item)
        itemBehavior.removeItem(item)
      }
    }
  }
  
  func addLinearVelocity(_ velocity: CGPoint) {
    itemBehavior.addLinearVelocity(velocity, for: item)
  }
}
