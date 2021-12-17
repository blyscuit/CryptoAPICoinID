//
//  CoinId.swift
//  CoinIDGlobal
//
//  Created by Bliss on 16/12/21.
//

import Foundation

public protocol CoinIDProtocol {

    func getID(with symbol: String, provider: CoinAPIProvider) -> String?
    func convert(id: String, provider: CoinAPIProvider, to resultProvider: CoinAPIProvider) -> String?
}

public enum CoinAPIProvider: String {
    
    case coinMarketCap = "coin_market_cap"
    case coinCap = "coin_cap"
    case coinGecko = "coin_gecko"
}

public class CoinId {

    public static var `default` = CoinId()

    let coinIds: [String: Any]

    init() {
        coinIds = CoinId.loadData()
    }

    private static func loadData() -> [String: Any] {
        guard let file = Bundle.main.url(forResource: "data", withExtension: "json"),
              let data = try? Data(contentsOf: file),
              let coins = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                  print("Could not load Data")
                  return [:]
              }
        return coins
    }
}

extension CoinId: CoinIDProtocol {

    public func getID(with symbol: String, provider: CoinAPIProvider) -> String? {
        guard let coin = coinIds[symbol.uppercased()] as? [String: Any],
        let id = coin[provider.rawValue] as? String else { return nil }
        return id
    }

    public func convert(id: String, provider: CoinAPIProvider, to resultProvider: CoinAPIProvider) -> String? {
        for coin in coinIds {
            if let coinId = ((coin.value as? [String: Any])?[provider.rawValue] as? String),
               coinId == id {
                return ((coin.value as? [String: Any])?[resultProvider.rawValue] as? String)
            }
        }
        return nil
    }
}
