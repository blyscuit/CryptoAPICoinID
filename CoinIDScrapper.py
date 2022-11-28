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

def rankSort(e):
  return e['rank']

# CoinMarketCap
r = requests.get('https://pro-api.coinmarketcap.com/v1/cryptocurrency/map?CMC_PRO_API_KEY='+os.environ.get("coinmarketcap"))
coinmarketcap = r.json()["data"]
coinmarketcap.sort(reverse=True, key=rankSort)
# print(len(coinmarketcap))
for coin in coinmarketcap:
    add_id(coin['symbol'], str(coin['id']), 'coin_market_cap')


# CoinGecko
cg = requests.get('https://api.coingecko.com/api/v3/coins/list')
# print(len(cg.json()))

for coin in reversed(cg.json()):
    if "wrapped-" not in coin['id'] and "wormhole-" not in coin['id'] and "-peg-" not in coin['id'] and "oec-" not in coin['id']:
        add_id(coin['symbol'], coin['id'], 'coin_gecko')


# CoinCap
r = requests.get('https://api.coincap.io/v2/assets?limit=2000')
# print(len(r.json()["data"]))

for coin in reversed(r.json()["data"]):
    if any(x['id'] == coin['id'] for x in cg.json()):
        add_id(coin['symbol'], coin['id'], 'coin_gecko')
        add_id(coin['symbol'], coin['id'], 'coin_cap')
    else:
        add_id(coin['symbol'], coin['id'], 'coin_cap')

with open('data.json', 'w') as outfile:
    json.dump(data, outfile)
