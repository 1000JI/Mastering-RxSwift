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
 # Disposables
 */


let subscription1 = Observable.from([1, 2, 3])
    .subscribe(onNext: { elem in
        print("Next", elem)
    }, onError: { error in
        print("Error", error.localizedDescription)
    }, onCompleted: {
        print("Completed")
    }, onDisposed: {
        print("Disposed")
    })

subscription1.dispose() // 해당 방식으로 메모리에서 해제 할 수 있다.

/*
 Print
 ------
 Next 1
 Next 2
 Next 3
 Completed
 Disposed
 */

var bag = DisposeBag() // DisposeBag에 담아 한번에 메모리에서 해제 할 수 있도록 한다.(애플 문서 권장), ARC에서 autorelease pool과 같은 느낌이라고 보면 된다.

Observable.from([1, 2, 3])
    .subscribe {
        print($0)
    }
    .disposed(by: bag)
    
/*
 Print
 ------
 Next 1
 Next 2
 Next 3
 Completed
 */

bag = DisposeBag() // 이전에 있던 Dispose가 해제 된다.



let subscription2 = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
    .subscribe(onNext: { elem in
        print("Next", elem)
    }, onError: { error in
        print("Error", error.localizedDescription)
    }, onCompleted: {
        print("Completed")
    }, onDisposed: {
        print("Disposed")
    })

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    subscription2.dispose() // comPleted 이벤트가 호출되지 않았으므로 주의하여 개발해야 한다.
}






