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
 # refCount
 */

let bag = DisposeBag()
let source = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).debug().publish().refCount()

let observer1 = source
    .subscribe { print("🔵", $0) }

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    observer1.dispose()
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
    let observer2 = source.subscribe { print("🔴", $0) }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        observer2.dispose()
    }
}
/* 출력
 2021-02-24 00:53:59.335: refCount.playground:31 (__lldb_expr_21) -> subscribed
 2021-02-24 00:54:00.367: refCount.playground:31 (__lldb_expr_21) -> Event next(0)
 🔵 next(0)
 2021-02-24 00:54:01.366: refCount.playground:31 (__lldb_expr_21) -> Event next(1)
 🔵 next(1)
 2021-02-24 00:54:02.366: refCount.playground:31 (__lldb_expr_21) -> Event next(2)
 🔵 next(2)
 2021-02-24 00:54:02.659: refCount.playground:31 (__lldb_expr_21) -> isDisposed
 2021-02-24 00:54:07.064: refCount.playground:31 (__lldb_expr_21) -> subscribed
 2021-02-24 00:54:08.065: refCount.playground:31 (__lldb_expr_21) -> Event next(0)
 🔴 next(0)
 2021-02-24 00:54:09.065: refCount.playground:31 (__lldb_expr_21) -> Event next(1)
 🔴 next(1)
 2021-02-24 00:54:10.065: refCount.playground:31 (__lldb_expr_21) -> Event next(2)
 🔴 next(2)
 2021-02-24 00:54:10.065: refCount.playground:31 (__lldb_expr_21) -> isDisposed
 */


