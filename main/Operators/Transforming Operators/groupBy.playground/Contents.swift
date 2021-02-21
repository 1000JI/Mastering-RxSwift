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
 # groupBy
 */

let disposeBag = DisposeBag()
let words = ["Apple", "Banana", "Orange", "Book", "City", "Axe"]

Observable.from(words)
    .groupBy { $0.count }
    .subscribe { print($0) }
    .disposed(by: disposeBag)
/* 출력
 next(GroupedObservable<Int, String>(key: 5, source: RxSwift.(unknown context at $10757cc08).GroupedObservableImpl<Swift.String>))
 next(GroupedObservable<Int, String>(key: 6, source: RxSwift.(unknown context at $10757cc08).GroupedObservableImpl<Swift.String>))
 next(GroupedObservable<Int, String>(key: 4, source: RxSwift.(unknown context at $10757cc08).GroupedObservableImpl<Swift.String>))
 next(GroupedObservable<Int, String>(key: 3, source: RxSwift.(unknown context at $10757cc08).GroupedObservableImpl<Swift.String>))
 completed
 */

Observable.from(words)
    .groupBy { $0.count }
    .subscribe(onNext: { groupedObservable in
        print("== \(groupedObservable.key)")
        groupedObservable.subscribe { print("  \($0)") }
    })
    .disposed(by: disposeBag)
/* 출력
 == 5
   next(Apple)
 == 6
   next(Banana)
   next(Orange)
 == 4
   next(Book)
   next(City)
 == 3
   next(Axe)
   completed
   completed
   completed
   completed
 */


Observable.from(words)
    .groupBy { $0.count }
    .flatMap { $0.toArray() }
    .subscribe { print($0) }
    .disposed(by: disposeBag)
/* 출력
 next(["Banana", "Orange"])
 next(["Book", "City"])
 next(["Axe"])
 next(["Apple"])
 completed
 */


Observable.from(words)
    .groupBy { $0.first ?? Character(" ") }
    .flatMap { $0.toArray() }
    .subscribe { print($0) }
    .disposed(by: disposeBag)
/* 출력
 next(["City"])
 next(["Banana", "Book"])
 next(["Apple", "Axe"])
 next(["Orange"])
 completed
 */


Observable.range(start: 1, count: 10)
    .groupBy { $0.isMultiple(of: 2) }
    .flatMap { $0.toArray() }
    .subscribe { print($0) }
    .disposed(by: disposeBag)
/* 출력
 next([1, 3, 5, 7, 9])
 next([2, 4, 6, 8, 10])
 completed
 */
