import requests
import json
from dotenv import load_dotenv
import os

load_dotenv()

data = {}


def add_id(_symbol, id, brand):
    symbol = _symbol.upper()
    if symbol not in data:
        data[symbol] = {}
    data[symbol][brand] = id

# CoinMarketCap
r = requests.get('https://pro-api.coinmarketcap.com/v1/cryptocurrency/map?CMC_PRO_API_KEY='+os.environ.get("coinmarketcap"))
coinmarketcap = r.json()["data"]

for coin in coinmarketcap:
    add_id(coin['symbol'], coin['id'], 'coin_market_cap')


# CoinGecko
r = requests.get('https://api.coingecko.com/api/v3/coins/list')

for coin in r.json():
    add_id(coin['symbol'], coin['id'], 'coin_gecko')


# CoinCap
r = requests.get('https://api.coincap.io/v2/assets')
for coin in r.json()["data"]:
    add_id(coin['symbol'], coin['id'], 'coin_cap')

with open('data.json', 'w') as outfile:
    json.dump(data, outfile)