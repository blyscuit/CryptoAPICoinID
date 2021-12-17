
## CoinIDGlobal

Crypto ID by corresponding ticker. For searching coin across API platforms.

- CoinMarketCap
- CoinGecko
- CoinCap

## What's available?

- JSON

### Library

- Swift

## What does it look like?

*data.json*

```
{
    
    "BTC": {"coin_market_cap": "1", "coin_gecko": "bitcoin", "coin_cap": "bitcoin"}, 
    
    "LTC": {"coin_market_cap": "2", "coin_gecko": "litecoin", "coin_cap": "litecoin"},
    
    // ...
}
```

## Regenerate

1. Rename `.example.env` to `.env`
2. Fill `.env` value
3. `pip3 install -r requirements.txt`
4. `python3 CoinIDScrapper.py`