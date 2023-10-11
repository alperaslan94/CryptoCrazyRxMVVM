//
//  CryptoViewModel.swift
//  CryptoCrazyRxMVVM
//
//  Created by Alperaslan on 7.10.2023.
//

import Foundation
import RxSwift
import RxCocoa


class CryptoViewModel {
    
    
    let cryptos : PublishSubject<[Crypto]> = PublishSubject()
    let error : PublishSubject<String> = PublishSubject()
    let loading : PublishSubject<Bool> = PublishSubject()
    
    func requestData() {
        self.loading.onNext(true)
        let url = URL(string: "http://raw.githubsercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        Webservice().downlandCurrencies(url: url) { result in
            self.loading.onNext(false)
            switch result {
            case .success(let cryptos):
                self.cryptos.onNext(cryptos)
                
               /* self.cryptoList = cryptos
                print(cryptos)
                
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                } */
                
            case.failure(let error):
                switch error {
                case .parsingError:
                    self.error.onNext("Parsing Error")
                case .serverError:
                    self.error.onNext("Server Error")
                }
            }
        }
    }
    
    
}
