//: Playground - noun: a place where people can play

import UIKit

import PlaygroundSupport

let view = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
view.backgroundColor = UIColor.lightText
PlaygroundPage.current.liveView = view

let whiteSquare = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
whiteSquare.backgroundColor = UIColor.white
view.addSubview(whiteSquare)

let orangeSquare = UIView(frame: CGRect(x: 400, y: 100, width: 100, height: 100))
orangeSquare.backgroundColor = UIColor.orange
view.addSubview(orangeSquare)

let animator = UIDynamicAnimator(referenceView: view)
animator.addBehavior(UIGravityBehavior(items: [orangeSquare]))

let boundaryCollision = UICollisionBehavior(items: [whiteSquare, orangeSquare])
boundaryCollision.translatesReferenceBoundsIntoBoundary = true
animator.addBehavior(boundaryCollision)

let bounce = UIDynamicItemBehavior(items: [orangeSquare])
bounce.elasticity = 0.6
bounce.density = 200
bounce.resistance = 2
animator.addBehavior(bounce)

animator.setValue(true, forKey: "debugEnabled")

let parentBehavior = UIDynamicBehavior()
let viewBehavior = UIDynamicItemBehavior(items: [whiteSquare])
viewBehavior.density = 0.01
viewBehavior.resistance = 10
viewBehavior.friction = 0.0 //摩擦
viewBehavior.allowsRotation = false
parentBehavior.addChildBehavior(viewBehavior)

let fieldBehavior = UIFieldBehavior.springField()
fieldBehavior.addItem(whiteSquare)
fieldBehavior.position = CGPoint(x: 150, y: 350)
fieldBehavior.region = UIRegion(size: CGSize(width: 500, height: 500))
parentBehavior.addChildBehavior(fieldBehavior)

animator.addBehavior(parentBehavior)

let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
DispatchQueue.main.asyncAfter(deadline: delayTime) {
  let pushBehavior = UIPushBehavior(items: [whiteSquare], mode: .instantaneous)
  pushBehavior.pushDirection = CGVector(dx: 0, dy: -1)
  pushBehavior.magnitude = 0.3
  animator.addBehavior(pushBehavior)
}

let attachment = UIAttachmentBehavior(item: orangeSquare, attachedToAnchor: CGPoint(x: 300, y: 100))
attachment.length = 300
animator.addBehavior(attachment)
