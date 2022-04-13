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

    func testLunaCoinCoinCap() throws {
        let coinId = coinId.getID(with: "LUNA", provider: .coinCap)
        XCTAssertEqual(coinId, "terra-luna")
    }

    func testEtheriumCoinGecko() throws {
        let coinId = coinId.getID(with: "ETH", provider: .coinGecko)
        XCTAssertEqual(coinId, "ethereum")
    }

    func testLunaCoinGecko() throws {
        let coinId = coinId.getID(with: "LUNA", provider: .coinGecko)
        XCTAssertEqual(coinId, "terra-luna")
    }

    func testCROCoinCoinCap() throws {
        let coinId = coinId.getID(with: "CRO", provider: .coinCap)
        XCTAssertEqual(coinId, "crypto-com-coin")
    }

    func testCROCoinGecko() throws {
        let coinId = coinId.getID(with: "CRO", provider: .coinGecko)
        XCTAssertEqual(coinId, "crypto-com-chain")
    }

    func testCordanoCoinMarketCap() throws {
        let coinId = coinId.getID(with: "ADA", provider: .coinMarketCap)
        XCTAssertEqual(coinId, "2010")
    }

    func testSolanaFromCoinCapToCoinMarketCap() throws {
        let coinId = coinId.convert(id: "solana", provider: .coinCap, to: .coinMarketCap)
        XCTAssertEqual(coinId, "5426")
    }

    func testNonExistentCoinFromCoinCapToCoinMarketCap() throws {
        let coinId = coinId.convert(id: "fsdlkweuoqirlm,vcxlaesoiroisdavjlsadrlk", provider: .coinCap, to: .coinMarketCap)
        XCTAssertEqual(coinId, nil)
    }
}
