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
 # Scheduler
 */

let bag = DisposeBag()
let backgroundScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())

Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)
    .filter { num -> Bool in
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> filter")
        return num.isMultiple(of: 2)
    }
    .map { num -> Int in
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> map")
        return num * 2
    }
    .subscribe {
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> subscribe")
        print($0)
    }
    .disposed(by: bag)

/* 출력
 Main Thread >> filter
 Main Thread >> filter
 Main Thread >> map
 Main Thread >> subscribe
 next(4)
 Main Thread >> filter
 Main Thread >> filter
 Main Thread >> map
 Main Thread >> subscribe
 next(8)
 Main Thread >> filter
 Main Thread >> filter
 Main Thread >> map
 Main Thread >> subscribe
 next(12)
 Main Thread >> filter
 Main Thread >> filter
 Main Thread >> map
 Main Thread >> subscribe
 next(16)
 Main Thread >> filter
 Main Thread >> subscribe
 completed
 */


Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)
    .filter { num -> Bool in
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> filter")
        return num.isMultiple(of: 2)
    }
    .observeOn(backgroundScheduler) // 이어지는 연산자들이 작업을 실행할 Scheduler를 지정한다.
    .map { num -> Int in
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> map")
        return num * 2
    }
    .subscribe {
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> subscribe")
        print($0)
    }
    .disposed(by: bag)

/* 출력
 Main Thread >> filter
 Main Thread >> filter
 Main Thread >> filter
 Background Thread >> map
 Main Thread >> filter
 Background Thread >> subscribe
 Main Thread >> filter
 next(4)
 Main Thread >> filter
 Main Thread >> filter
 Main Thread >> filter
 Background Thread >> map
 Main Thread >> filter
 Background Thread >> subscribe
 next(8)
 Background Thread >> map
 Background Thread >> subscribe
 next(12)
 Background Thread >> map
 Background Thread >> subscribe
 next(16)
 Background Thread >> subscribe
 completed
 */


Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)
    .filter { num -> Bool in
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> filter")
        return num.isMultiple(of: 2)
    }
    .observeOn(backgroundScheduler) // 이어지는 연산자들이 작업을 실행할 Scheduler를 지정한다.(호출 시점 중요 X)
    .map { num -> Int in
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> map")
        return num * 2
    }
    .subscribeOn(MainScheduler.instance) // Observable이 실행되는 시점에 어떤 Scheduler를 사용할 지 지정하는 것이다.(호출 시점 중요)
    .observeOn(MainScheduler.instance)
    .subscribe {
        print(Thread.isMainThread ? "Main Thread" : "Background Thread", ">> subscribe")
        print($0)
    }
    .disposed(by: bag)
/* 출력
 Main Thread >> filter
 Main Thread >> filter
 Main Thread >> filter
 Background Thread >> map
 Main Thread >> filter
 Main Thread >> filter
 Background Thread >> map
 Main Thread >> filter
 Main Thread >> filter
 Background Thread >> map
 Main Thread >> filter
 Background Thread >> map
 Main Thread >> filter
 Main Thread >> subscribe
 next(4)
 Main Thread >> subscribe
 next(8)
 Main Thread >> subscribe
 next(12)
 Main Thread >> subscribe
 next(16)
 Main Thread >> subscribe
 completed
 */
