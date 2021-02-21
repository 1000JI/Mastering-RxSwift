//
//  Copyright (c) 2019 KxCoding <kky0317@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import RxSwift

/*:
 # window
 */

let disposeBag = DisposeBag()

Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .window(timeSpan: .seconds(2), count: 3, scheduler: MainScheduler.instance)
    .take(5)
    .subscribe { print($0) }
    .disposed(by: disposeBag)
/* 출력문
 next(RxSwift.AddRef<Swift.Int>)
 next(RxSwift.AddRef<Swift.Int>)
 next(RxSwift.AddRef<Swift.Int>)
 next(RxSwift.AddRef<Swift.Int>)
 next(RxSwift.AddRef<Swift.Int>)
 completed
 */


Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .window(timeSpan: .seconds(2), count: 3, scheduler: MainScheduler.instance)
    .take(5)
    .subscribe {
        print($0)
        
        if let observable = $0.element {
            observable.subscribe { print(" inner: ", $0) }
        }
    }
    .disposed(by: disposeBag)
/* 출력문
 next(RxSwift.AddRef<Swift.Int>)
  inner:  next(0)
  inner:  completed
 next(RxSwift.AddRef<Swift.Int>)
  inner:  next(1)
  inner:  next(2)
  inner:  next(3)
  inner:  completed
 next(RxSwift.AddRef<Swift.Int>)
  inner:  next(4)
  inner:  next(5)
  inner:  completed
 next(RxSwift.AddRef<Swift.Int>)
  inner:  next(6)
  inner:  next(7)
  inner:  completed
 next(RxSwift.AddRef<Swift.Int>)
 completed
  inner:  next(8)
  inner:  next(9)
  inner:  completed
 */
