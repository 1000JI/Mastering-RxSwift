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
 # Observables
 */
// Observables을 생성하는 방법은 2가지가 있다.
// #1
let o1 = Observable<Int>.create { (observer) -> Disposable in
    observer.on(.next(0))
    observer.onNext(1)
    
    observer.onCompleted()
    
    return Disposables.create()
}

// #1-1
o1.subscribe { // Closure가 Observer
    print("== Start ==")
    print($0)
    /*
     next(0)
     next(1)
     completed
     */
    
    if let elem = $0.element {
        print(elem)
    }
    print("== End ==")
}

print("------------------------------------")

// #1-2
o1.subscribe(onNext: { elem in
    print(elem)
    /*
     0
     1
     */
})



// #2
Observable.from([0, 1])


/*
 Observer가 구독을 시작하는 방법은 Observable에서 Subscribe 메소드를 호출하는 것이다.
 Subscribe는 Observer와 Observable을 연결한다.
 
 Observer는 동시에 두개 이상의 이벤트를 처리하지 않는다.
 Observable은 Observer가 하나의 이벤트를 처리한 후에 이어지는 이벤트를 전달한다. 여러 이벤트를 동시에 전달하지 않는다.
 */









