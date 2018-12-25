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

private let reuseIdentifier = "PhotoCell"


class PhotosCollectionViewController: UICollectionViewController {
  var photoData: [PhotoPair] = retrievePhotoData()
  
  var fullPhotoViewController: FullPhotoViewController!
  var fullPhotoView: UIView!
  //1. Add a UIDynamicAnimator
  var animator: UIDynamicAnimator!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    //2. Initialize the UIDynamicAnimator 设置animator
    animator = UIDynamicAnimator(referenceView: self.view)
    self.installsStandardGestureForInteractiveMovement = true
    
    // Add full image view to top view controller
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    fullPhotoViewController = storyBoard.instantiateViewController(withIdentifier: "FullPhotoVC") as? FullPhotoViewController
    fullPhotoView = fullPhotoViewController.view
    
    addChild(fullPhotoViewController)
    view.addSubview(fullPhotoView)
    fullPhotoViewController.didMove(toParent: self)

    fullPhotoView.isHidden = true
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photoData.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
    // Configure the cell
    if let photoCell = cell as? PhotoCollectionViewCell {
      photoCell.imageView.image = photoData[indexPath.item].image
    }
    
    cell.layer.cornerRadius = 10.0;

    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let photo = photoData.remove(at: sourceIndexPath.item)
    photoData.insert(photo, at: destinationIndexPath.item)
  }
  
  // MARK: UICollectionViewDelegate
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    showFullImageView(indexPath.item)
  }
  
  // MARK: Private methods
  
  @IBAction func dismissFullPhoto(_ sender: UIControl) {
    navigationItem.rightBarButtonItem = nil

    UIView.animate(withDuration: 0.5, animations:
      { () -> Void in
        self.fullPhotoView.center = CGPoint(x: self.fullPhotoView.center.x, y: self.fullPhotoView.frame.size.height / -2)
      }, completion: {
        (completed: Bool) -> Void in
        self.fullPhotoView.isHidden = true
    })
  }
  
  func showFullImageView(_ index: Int) {
    //3
    let delayTime = DispatchTime.now() + Double(Int64(0.75 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: delayTime) {
      let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(PhotosCollectionViewController.dismissFullPhoto(_:)))
      self.navigationItem.rightBarButtonItem = doneButton
    }
    
    //4
    fullPhotoViewController.photoPair = photoData[index]
    fullPhotoView.center = CGPoint(x: fullPhotoView.center.x, y: fullPhotoView.frame.height / -2)
    fullPhotoView.isHidden = false
    
    //5
    animator.removeAllBehaviors()
    
    let dynamicItemBehavior = UIDynamicItemBehavior(items: [fullPhotoView])
    dynamicItemBehavior.elasticity = 0.2
    dynamicItemBehavior.density = 400
    animator.addBehavior(dynamicItemBehavior)
    
    let gravityBehavior = UIGravityBehavior(items: [fullPhotoView])
    gravityBehavior.magnitude = 5.0 //加速度
    animator.addBehavior(gravityBehavior)
    
    let collisionBehavior = UICollisionBehavior(items: [fullPhotoView])
    //设置边界
    let left = CGPoint(x: 0, y: fullPhotoView.frame.height + 1.5)
    let right = CGPoint(x: fullPhotoView.frame.width, y: fullPhotoView.frame.height + 1.5)
    collisionBehavior.addBoundary(withIdentifier: "bottom" as NSCopying, from: left, to: right)
    animator.addBehavior(collisionBehavior)
  }
}
