//
//  ViewController.swift
//  OKXApiManager
//
//  Created by Роман Сенкевич on 5.02.23.
//

import UIKit
import PromiseKit
import Alamofire

class ViewController: UIViewController {
    
    private lazy var session: Session = {
        return ConnectionSettings.sessionManager()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let key = "***"
        let passphrase = "***"
        let secretKey = "***"
        
        let apiKeys = APIKeys(key: key, passphrase: passphrase, secretKey: secretKey)
        
        getTime()
        getBalance(apiKeys: apiKeys)
        placeOrder(apiKeys: apiKeys)
    }

    func getTime() {
        let apiKeys = APIKeys(key: "", passphrase: "", secretKey: "")
        let apiRouterStruct = APIRouterStruct(.public(.time), apiKeys)
        let timePromise:  Promise<Time> = session.request(apiRouterStruct)
        
        firstly {
            timePromise
        }
        .then { time -> Promise<Time> in
            guard let ts = time.data.first?.ts else { throw InternalError.unexpected }
            print(ts)
            return Promise<Time>.value(time)
        }
        .catch { error in
            print("error in ViewController: \(error)")
        }
        .finally {
            print("finally done")
        }
    }
    
    func getBalance(apiKeys: APIKeys) {
        let apiRouterStruct = APIRouterStruct(.account(.balance(ccy: "USDT,SOL,ETH,BTC,FITFI")), apiKeys)
        let balancePromise:  Promise<Balance> = session.request(apiRouterStruct)
        
        firstly {
            balancePromise
        }
        .then { balance -> Promise<Balance> in
            print(balance)
            return Promise<Balance>.value(balance)
        }
        .catch { error in
            print("error in ViewController: \(error)")
        }
        .finally {
            print("finally done")
        }
    }
    
    func placeOrder(apiKeys: APIKeys) {
        let postOrder = PostOrder(instID: "FITFI-USDT", tdMode: "cash", side: "buy", ordType: "limit", px: "0.01", sz: "1")
        let apiRouterStruct = APIRouterStruct(.trade(.order(postOrder: postOrder)), apiKeys)
        let orderPromise:  Promise<Order> = session.request(apiRouterStruct)
        
        firstly {
            orderPromise
        }
        .then { order -> Promise<Order> in
            print("order: \(order)")
            return Promise<Order>.value(order)
        }
        .catch { error in
            print("error in ViewController: \(error)")
        }
        .finally {
            print("finally done")
        }
    }
}

