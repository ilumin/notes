---
id: 20210714085105
date: 2021-07-14T00:00
tags:
- bot/trading-bot
---

# Freqtrade

## Installation (Docker)

```sh
# download compose file from https://raw.githubusercontent.com/freqtrade/freqtrade/stable/docker-compose.yml
mkdir freqtrade
cd freqtrade
curl https://raw.githubusercontent.com/freqtrade/freqtrade/stable/docker-compose.yml -o docker-compose.yml
docker-compose pull

# create user data directoy 
docker-compose run --rm freqtrade create-userdir --userdir user_data

# create configuration
docker-compose run --rm freqtrade new-config --config user_data/config.json

# launch bot 
docker-compose up -d

# view logs 
docker-compose logs -f

# run jupyter
mkdir docker
curl https://raw.githubusercontent.com/freqtrade/freqtrade/stable/docker/Dockerfile.jupyter -o docker/Dockerfile.jupyter
curl https://raw.githubusercontent.com/freqtrade/freqtrade/stable/docker/docker-compose-jupyter.yml -o doker/docker-compose-jupyter.yml
docker-compose -f docker/docker-compose-jupyter.yml up -d 

# pull custom docker file
curl https://raw.githubusercontent.com/freqtrade/freqtrade/stable/docker/Dockerfile.custom -o docker/Dockerfile.custom

```

**notes**
- docker image for ARM64 or Mac M1 are `freqtradeorg/freqtrade:custom_arm64`
- since we're using docker, every command run from docker -> it would be better if we just create npm script to run those command
- log store in `user_data/logs/`
- database use sqlite store in `user_data/tradesv3.sqlite`

## Create npm script to run freqtrade command

```sh 
npm init -y 
npm set-script ft "docker-compose run --rm freqtrade"

# create user data dir
yarn ft create-userdir --userdir user_data

# create config
yarn ft new-config --config user_data/config.json

# download historical data
yarn ft download-data --pairs ETH/BTC --exchange binance --days 14 -t 1h 

# run backtest
yarn ft backtesting --config user_data/config.json --strategy SampleStrategy -i 1h

# plot-profit 
yarn ft plot-dataframe --strategy SampleStrategy -p ETH/BTC
```

## Term

- **strategy**: trading strategy, telling the bot what to do
- **trade**: open position
- **open oerder**: order which is currently placed on the exchange and not yet complete
- **pair**: tradable pair in the format of QUOTE/BASE e.g. XRP/USDT
- **timeframe**: candle length to use e.g. `5m`, `1h`
- **indecator**: technical indicators e.g. `SMA`, `EMA`, `RSI`, ...
- **limit order**: limit orders which execute at the defined limit price or better 
- **market order**: guaranteed to fill, may move price depending on the order size

## Add custom strategy [PENDING]

- add custom strategy into `user_data/strategies/`
- add strategy class name into `docker-compose.yml`

strategy repo => [https://github.com/freqtrade/freqtrade-strategies]

```sh
curl https://raw.githubusercontent.com/freqtrade/freqtrade-strategies/master/user_data/strategies/DevilStra.py -o user_data/strategies/DevilStra.py
curl https://raw.githubusercontent.com/freqtrade/freqtrade-strategies/master/user_data/strategies/GodStra.py -o user_data/strategies/GodStra.py
curl https://raw.githubusercontent.com/freqtrade/freqtrade-strategies/master/user_data/strategies/GodStraNew.py -o user_data/strategies/GodStraNew.py
curl https://raw.githubusercontent.com/freqtrade/freqtrade-strategies/master/user_data/strategies/Heracles.py -o user_data/strategies/Heracles.py
curl https://raw.githubusercontent.com/freqtrade/freqtrade-strategies/master/user_data/strategies/Strategy001.py -o user_data/strategies/Strategy001.py
curl https://raw.githubusercontent.com/freqtrade/freqtrade-strategies/master/user_data/strategies/Strategy002.py -o user_data/strategies/Strategy002.py
curl https://raw.githubusercontent.com/freqtrade/freqtrade-strategies/master/user_data/strategies/Strategy003.py -o user_data/strategies/Strategy003.py
curl https://raw.githubusercontent.com/freqtrade/freqtrade-strategies/master/user_data/strategies/Strategy004.py -o user_data/strategies/Strategy004.py
curl https://raw.githubusercontent.com/freqtrade/freqtrade-strategies/master/user_data/strategies/Strategy005.py -o user_data/strategies/Strategy005.py
curl https://raw.githubusercontent.com/freqtrade/freqtrade-strategies/master/user_data/strategies/hlhb.py -o user_data/strategies/hlhb.py
curl https://raw.githubusercontent.com/freqtrade/freqtrade-strategies/master/user_data/strategies/fixed_riskreward_loss.py -o user_data/strategies/fixed_riskreward_loss.py
curl https://raw.githubusercontent.com/freqtrade/freqtrade-strategies/master/user_data/strategies/Swing-High-To-Sky.py -o user_data/strategies/Swing-High-To-Sky.py

yarn ft backtesting --config user_data/config.json --strategy DevilStra -i 1h
```

try to run backtest for BTC/BUSD
```sh
# download historical data
yarn ft download-data --pairs BTC/BUSD --exchange binance --days 30 -t 1w
yarn ft download-data --pairs BTC/BUSD --exchange binance --days 30 -t 1d
yarn ft download-data --pairs BTC/BUSD --exchange binance --days 400 -t 1h 
yarn ft download-data --pairs BTC/BUSD --exchange binance --days 30 -t 30m
yarn ft download-data --pairs BTC/BUSD --exchange binance --days 30 -t 15m
yarn ft download-data --pairs BTC/BUSD --exchange binance --days 30 -t 5m
yarn ft download-data --pairs BTC/BUSD --exchange binance --days 30 -t 1m

# create config for BTC/BUSD
docker-compose run --rm freqtrade new-config --config user_data/config-BTCBUSD.json

# run backtest
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy SampleStrategy -i 30m
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy DevilStra -i 30m
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy GodStraNew -i 30m
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy Strategy001 -i 1h
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy Strategy002 -i 1h
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy Strategy003 -i 1h
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy Strategy004 -i 1h
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy Strategy005 -i 1h
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy hlhb -i 30m
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy fixed_riskreward_loss -i 30m
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy Swing-High-To-Sky -i 30m

yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy EMAPriceCrossoverWithThreshold -i 1h
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy DoubleEMACrossoverWithTrend -i 1h

# BTC/USDT
yarn ft download-data --pairs BTC/USDT --exchange binance --days 400 -t 1h 

curl https://raw.githubusercontent.com/paulcpk/freqtrade-strategies-that-work/main/EMAPriceCrossoverWithThreshold.py -o user_data/strategies/EMAPriceCrossoverWithThreshold.py
curl https://raw.githubusercontent.com/paulcpk/freqtrade-strategies-that-work/main/DoubleEMACrossoverWithTrend.py -o user_data/strategies/DoubleEMACrossoverWithTrend.py
curl https://github.com/i1ya/freqtrade-strategies/raw/main/BigZ03/BigZ03.py -o user_data/strategies/BigZ03.py

docker-compose run --rm freqtrade new-config --config user_data/config-BTCUSDT.json

yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy EMAPriceCrossoverWithThreshold -i 1h
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy DoubleEMACrossoverWithTrend -i 1h
yarn ft backtesting --config user_data/config-BTCBUSD-Big.json --strategy BigZ03 -i 1h

# strategy from i1ya 
# CombinedBinHClucAndMADV3 -> 1y 6.75%
yarn ft backtesting --config user_data/config-i1ya-madv3.json --strategy CombinedBinHClucAndMADV3 -i 1h
```

## Serious backtest

```sh
yarn ft download-data --config user_data/config-BTCBUSD.json --exchange binance --days 400 -t 1h
```

## The best strategy

### EMAPriceCrossoverWithThreshold

```sh
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy EMAPriceCrossoverWithThreshold -i 1h
```

results:

- from: 2020-06-09 00:00:00
- to: 2021-07-14 03:00:00
- profit: 36%

### DoubleEMACrossoverWithTrend

```sh
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy DoubleEMACrossoverWithTrend -i 1h
```

result:
- from: 2020-06-09 00:00:00
- to: 2021-07-14 03:00:00
- profit: 30%

## Run after market breakdown event on May

```sh 
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy EMAPriceCrossoverWithThreshold -i 1h --timerange 20210525-
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy DoubleEMACrossoverWithTrend -i 1h --timerange 20210525-
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy DoubleEMACrossoverWithTrend -i 30m --timerange 20210525-
yarn ft backtesting --config user_data/config-BTCBUSD.json --strategy DoubleEMACrossoverWithTrend -i 15m --timerange 20210525-
```

## Start bot 

```sh 
yarn ft trade --config user_data/config-binance-busd-sandbox.json --strategy DoubleEMACrossoverWithTrend -v 
```

## Note

- to trade with bot -- whatever market trend, only time will win!

## Next 

- run on real trade API
