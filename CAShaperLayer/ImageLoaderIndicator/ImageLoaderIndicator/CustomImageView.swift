/**
 * Copyright (c) 2017 Razeware LLC
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
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
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

class CustomImageView: UIImageView {
  
  let progressIndicatorView = CircularLoaderView(frame: .zero)
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    addSubview(progressIndicatorView)
    
    //约束
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v]|",
                                                  options: .init(rawValue: 0),
                                                  metrics: nil,
                                                  views: ["v":progressIndicatorView]))
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v]|",
                                                  options: .init(rawValue: 0),
                                                  metrics: nil,
                                                  views: ["v":progressIndicatorView]))
    progressIndicatorView.translatesAutoresizingMaskIntoConstraints = false
    
    let url = URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530099603353&di=e2498427f187a78a90ea0ed104681649&imgtype=0&src=http%3A%2F%2Fwww.wallcoo.com%2Fnature%2FApple_OSX_Mountain_Lion_Secret_Wallpapers%2Fwallpapers%2F3200x2000%2FCosmos02.jpg")
    sd_setImage(with: url, placeholderImage: nil, options: .cacheMemoryOnly, progress:
      { [weak self] receivedSize, expectedSize, _ in
        // Update progress here
        
        self?.progressIndicatorView.progress = CGFloat(receivedSize) / CGFloat(expectedSize)
        
    }) { [weak self] _, error, _, _ in
      // Reveal image here
      
      if let error = error {
        print(error)
      }
      
      self?.progressIndicatorView.reveal()
      
    }
  }
  
}
