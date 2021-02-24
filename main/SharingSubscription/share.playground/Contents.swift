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
 # share
 */

let bag = DisposeBag()
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).debug().share(replay: 5, scope: .forever)

let observer1 = source
    .subscribe { print("🔵", $0) }

let observer2 = source
    .delaySubscription(.seconds(3), scheduler: MainScheduler.instance)
    .subscribe { print("🔴", $0) }

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    observer1.dispose()
    observer2.dispose()
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
    let observer3 = source.subscribe { print("⚫️", $0) }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        observer3.dispose()
    }
}
/* 출력
 2021-02-24 01:05:53.178: share.playground:31 (__lldb_expr_27) -> subscribed
 2021-02-24 01:05:54.214: share.playground:31 (__lldb_expr_27) -> Event next(0)
 🔵 next(0)
 2021-02-24 01:05:55.215: share.playground:31 (__lldb_expr_27) -> Event next(1)
 🔵 next(1)
 2021-02-24 01:05:56.215: share.playground:31 (__lldb_expr_27) -> Event next(2)
 🔵 next(2)
 🔴 next(0)
 🔴 next(1)
 🔴 next(2)
 2021-02-24 01:05:57.215: share.playground:31 (__lldb_expr_27) -> Event next(3)
 🔵 next(3)
 🔴 next(3)
 2021-02-24 01:05:58.214: share.playground:31 (__lldb_expr_27) -> Event next(4)
 🔵 next(4)
 🔴 next(4)
 2021-02-24 01:05:58.716: share.playground:31 (__lldb_expr_27) -> isDisposed
 ⚫️ next(0)
 ⚫️ next(1)
 ⚫️ next(2)
 ⚫️ next(3)
 ⚫️ next(4)
 2021-02-24 01:06:00.915: share.playground:31 (__lldb_expr_27) -> subscribed
 2021-02-24 01:06:01.915: share.playground:31 (__lldb_expr_27) -> Event next(0)
 ⚫️ next(0)
 2021-02-24 01:06:02.915: share.playground:31 (__lldb_expr_27) -> Event next(1)
 ⚫️ next(1)
 2021-02-24 01:06:03.917: share.playground:31 (__lldb_expr_27) -> Event next(2)
 ⚫️ next(2)
 2021-02-24 01:06:03.917: share.playground:31 (__lldb_expr_27) -> isDisposed
 */
