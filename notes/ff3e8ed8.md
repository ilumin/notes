---
date: 2021-06-22T18:38
tags:
- bot/trading-bot
---

# Trading Strategies Backtest Result

- duration: 1 month (2021-05-22 - 2021-06-21)
- currency: USDT
- asset: BTC
- start balance: 37940.84000
- candle size: 1 hours
- warmup period: 10

**note**
when I use candle size to 5 hours -> it's mostly win with positive sharp ratio
when I use small candle size (in a minute) -> it's mostly loss
and of cause, if I use large candle size -> it's not trade

## MACD
- trade: 68 (loss: 25 ~ 50%)
- sharp ratio: -18.88 
- start balance: 37940.84000
- final balance: 35396.69793
- profit: -6.70555%

```
short = 10
long = 21
signal = 9

[thresholds]
down = -0.025
up = 0.025
persistence = 1
```

## PPO
- trades: 44 (loss: 16 ~ 50%)
- sharpe ratio: -12.41
- start balance: 37940.84000
- final balance: 36115.26158
- simulated profit: -4.81164%

```
short = 12
long = 26
signal = 9

[thresholds]
down = -0.025
up = 0.025
persistence = 2
```

## RSI
- trades: 7 (win: 100%)
- sharpe ratio: -25.55
- start balance: 37940.84000
- final balance: 35446.23512
- simulated profit: -6.57499%
- **note**: RSI always win but we got negative because it's just start quote and not close yet

```
interval = 14

[thresholds]
low = 30
high = 70
persistence = 1
```

## aroom_public
- trades: 8
- sharpe ratio: -27.02
- start balance: 37940.84000
- final balance: 36219.44059
- simulated profit: -4.53706%
- **note**: just like RSI, we got negative because it's start quote and not close yet

```
interval =14
optInTimePeriod = 46
beardown = 99
bearup = 30
bulldown = 35
bullup = 99
```

## talib-macd
- trades: 65
- sharpe ratio: -16.60
- start balance: 37940.84000
- final balance: 35647.12652
- simulated profit: -6.04550%
- **note**: not so good in bearish market

```
[parameters]
optInFastPeriod = 10
optInSlowPeriod = 21
optInSignalPeriod = 9

[thresholds]
down = -0.025
up = 0.025
```

## tulib-adx 
- trades: 11
- sharpe ratio: -15.91
- start balance: 37940.84000
- final balance: 34109.51737
- simulated profit: -10.09815%
- **note**: some time it cut-loss but try to sell in high return rate

```
historySize = 80
optInTimePeriod = 15
candleSize = 10

[thresholds]
up = 30
down = 20
```

## tulib-macd 
- trades: 65
- sharpe ratio: -13.87
- start balance: 37940.84000
- final balance: 36034.78284
- simulated profit: -5.02376%
- **note**: not good, sell 

```
[parameters]
optInFastPeriod = 10
optInSlowPeriod = 21
optInSignalPeriod = 9

[thresholds]
down = -0.025
up = 0.025
```