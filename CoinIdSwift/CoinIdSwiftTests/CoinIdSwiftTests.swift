//
//  CoinIdSwiftTests.swift
//  CoinIdSwiftTests
//
//  Created by Bliss on 17/12/21.
//

import XCTest
@testable import CoinIdSwift

class CoinIdSwiftTests: XCTestCase {

    var coinId: CoinIDProtocol!

    override func setUpWithError() throws {
        super.setUp()
        coinId = CoinId.default
    }

    func testBitcoinCoinCap() throws {
        let coinId = coinId.getID(with: "BTC", provider: .coinCap)
        XCTAssertEqual(coinId, "bitcoin")
    }

    func testEtheriumCoinGecko() throws {
        let coinId = coinId.getID(with: "ETH", provider: .coinGecko)
        XCTAssertEqual(coinId, "ethereum")
    }

    func testCordanoCoinMarketCap() throws {
        let coinId = coinId.getID(with: "ADA", provider: .coinMarketCap)
        XCTAssertEqual(coinId, "2010")
    }

    func testSolanaFromCoinCapToCoinMarketCap() throws {
        let coinId = coinId.convert(id: "solana", provider: .coinCap, to: .coinMarketCap)
        XCTAssertEqual(coinId, "12003")
    }

    func testNonExistentCoinFromCoinCapToCoinMarketCap() throws {
        let coinId = coinId.convert(id: "fsdlkweuoqirlm,vcxlaesoiroisdavjlsadrlk", provider: .coinCap, to: .coinMarketCap)
        XCTAssertEqual(coinId, nil)
    }
}
