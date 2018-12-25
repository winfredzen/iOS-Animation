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
import QuartzCore

class FullPhotoViewController: UIViewController {
  @IBOutlet fileprivate var containerView: UIView!
  @IBOutlet fileprivate var imageView: UIImageView!
  @IBOutlet fileprivate var tagView: UIView!
  @IBOutlet fileprivate var photoDateLabel: UILabel!
  @IBOutlet fileprivate var photoFilenameLabel: UILabel!
  @IBOutlet fileprivate var photoDimensionLabel: UILabel!
  
  fileprivate var animator: UIDynamicAnimator!
  var stickyBehavior: StickyEdgesBehavior!
  
  fileprivate var offset = CGPoint.zero
  
  var photoPair: PhotoPair? {
    didSet {
      if let photoPair = photoPair {
        imageView.image = photoPair.image
        photoFilenameLabel.text = photoPair.filename
        
        let size = photoPair.image.size
        photoDimensionLabel.text = "Size: \(size.width) x \(size.height) px"
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        let dateText = dateFormatter.string(from: photoPair.date as Date)
        photoDateLabel.text = dateText
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tagView.layer.borderWidth = 0.5
    tagView.layer.cornerRadius = 15
    
    let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(FullPhotoViewController.pan(_:)))
    tagView.addGestureRecognizer(gestureRecognizer)
    
    animator = UIDynamicAnimator(referenceView: containerView)
    animator.setValue(true, forKey: "debugEnabled")
    stickyBehavior = StickyEdgesBehavior(item: tagView, edgeInset: 8)
    animator.addBehavior(stickyBehavior)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    stickyBehavior.isEnabled = false
    stickyBehavior.updateFieldsInBounds(containerView.bounds)
  }
  
  @objc func pan(_ pan: UIPanGestureRecognizer) {
    var location = pan.location(in: containerView)
    
    switch pan.state {
    case .began:
      let center = tagView.center
      offset.x = location.x - center.x
      offset.y = location.y - center.y
      
      stickyBehavior.isEnabled = false
      
    case .changed:
      let referenceBounds = containerView.bounds
      let referenceWidth = referenceBounds.width
      let referenceHeight = referenceBounds.height
      
      let itemBounds = tagView.bounds
      let itemHalfWidth = itemBounds.width / 2.0
      let itemHalfHeight = itemBounds.height / 2.0
      
      location.x -= offset.x
      location.y -= offset.y
      
      location.x = max(itemHalfWidth, location.x)
      location.x = min(referenceWidth - itemHalfWidth, location.x)
      location.y = max(itemHalfHeight, location.y)
      location.y = min(referenceHeight - itemHalfHeight, location.y)
      
      tagView.center = location
    case .cancelled, .ended:
      let velocity = pan.velocity(in: containerView)
      stickyBehavior.isEnabled = true
      stickyBehavior.addLinearVelocity(velocity)
    default: ()
    }
  }
}
