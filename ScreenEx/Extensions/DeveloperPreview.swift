//
//  DeveloperPreview.swift
//  ScreenEx
//
//  Created by Marat Guseynov on 07.02.2025.

//В Swift, Singleton (Одиночка) — это порождающий шаблон проектирования, который гарантирует, что у класса есть только один экземпляр и предоставляет глобальную точку доступа к этому экземпляру



class DeveloperPreview {
    
    static let shared = DeveloperPreview()
    
    private init() {}
    
    let statisticPlaceholder = StatisticModel(title: "Market Cap", value: "20Tr$", percentageChange: 13.67)
    let statisticPlaceholder2 = StatisticModel(title: "Total Volume", value: "12Bl$")
    let statisticPlaceholder3 = StatisticModel(title: "Portfolio Value", value: "48.5k$", percentageChange: -30.67)
    
    let coin = ExchangeModel(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
        currentPrice: 98034,
        marketCap: 1943386358621,
        marketCapRank: 1,
        fullyDilutedValuation: 1285385611303,
        totalVolume: 67190952980,
        high24H: 100097,
        low24H: 95820,
        priceChange24H: 1004.67,
        priceChangePercentage24H: 6.87944,
        marketCapChange24H: 72110681879,
        marketCapChangePercentage24H: 6.74171,
        circulatingSupply: 18653043,
        totalSupply: 21000000,
        maxSupply: 21000000,
        ath: 61712,
        athChangePercentage: -0.97589,
        athDate: "2025-01-20T09:11:54.494Z",
        atl: 67.81,
        atlChangePercentage: 90020.24075,
        atlDate: "2013-07-06T00:00:00.000Z",
        lastUpdated: "2025-02-07T16:28:34.794Z",
        sparklineIn7D: SparklineIn7D(price: [
            104740.66194955219,
            104668.68597425931,
            104614.28446002454,
            104475.41308585052,
            105480.45394517481,
            105071.25945425681,
            104623.76134295262,
            102524.21520732481,
            102310.35586633568,
            101598.16372711949,
            101921.93619140107,
            102231.1283769451,
            102404.93376107872,
            102470.38402887621,
            102512.46698695565,
            102403.77977300351,
            102249.72937645671,
            102293.87636307711,
            102475.68101584575,
            102392.6088536625,
            102185.38756205894,
            101992.51177679887,
            101615.24850144365,
            101592.66990862337,
            102019.51548371714,
            102149.95154515926,
            101860.22271648972,
            101823.14984091595,
            102108.3490479744,
            101882.43146116784,
            102239.73795237648,
            101992.1932854985,
            101476.28084876582,
            101341.21144517073,
            101393.69478953844,
            100522.89746094769,
            100503.92993660411,
            101237.55570873898,
            101161.8529126038,
            100488.42869471373,
            99092.333588406,
            99511.03304807426,
            100272.9911974196,
            100355.30821794734,
            99593.13977161376,
            99794.68350624843,
            99645.40771022183,
            99342.03532242186,
            98933.28243566968,
            98201.26569873706,
            98791.6437249441,
            99259.48949920906,
            99306.8359207168,
            98196.81871091944,
            97157.76217158206,
            96896.82676418213,
            98235.87175043522,
            97793.53821562871,
            96988.74415938454,
            97815.84535257479,
            97652.02866142086,
            96653.10505164102,
            93517.87531879066,
            93529.88153166145,
            94068.23649713039,
            92876.12162304203,
            93885.07988775491,
            93984.49582240354,
            95437.74841070815,
            95431.53785259378,
            95373.35106292863,
            95770.80181571534,
            95184.99000103062,
            94848.74372319518,
            94721.98536030206,
            96874.2426135226,
            99175.4839366473,
            98664.16766125984,
            99427.091812037,
            100109.60169399311,
            102038.29415299969,
            101776.9704902056,
            102011.13759922635,
            101786.57409375272,
            101392.3150300614,
            101177.50269250017,
            101468.37868950945,
            100843.17354271388,
            100696.1326357584,
            100163.72562649935,
            99248.39363079518,
            99414.93416195072,
            98461.65323336356,
            98361.85276813261,
            98707.16429232086,
            98900.15664785431,
            99125.47947716463,
            99369.05940581522,
            99132.60917545018,
            100160.09279025279,
            99503.28222371545,
            99207.7117070122,
            99243.8917964687,
            99359.35824162222,
            98860.42539595038,
            97972.8075370943,
            96386.5143187413,
            97690.61739242118,
            97888.30731950274,
            98360.40524167611,
            97742.4722066188,
            98029.77668903438,
            98006.5293424413,
            98094.7373713875,
            98200.71650096471,
            97513.92279729006,
            97904.93450676241,
            97656.24528073946,
            97450.19613346204,
            97759.8831753512,
            98193.32303841642,
            98045.78183003876,
            98611.46674060835,
            98351.26868548083,
            98192.99346867306,
            98044.92329209218,
            97736.3008613856,
            96709.7362968561,
            97377.74729659544,
            97326.90138999239,
            96870.39922901063,
            96439.88149814382,
            96613.00809483857,
            96839.96420150516,
            97130.53973144067,
            97355.35589817187,
            97355.40414806851,
            97643.75264902429,
            97775.60672474427,
            98402.46047835614,
            98232.29586759426,
            98211.45992465959,
            98692.44773552474,
            98975.0605619712,
            98901.87439582883,
            98359.249482822,
            98548.2185810839,
            97920.76851950152,
            97232.86007013674,
            96581.82206855995,
            96720.71725520355,
            96340.12998876366,
            95967.15004023662,
            96900.66888552891,
            96784.5850446752,
            96928.85157608312,
            96567.63486519158,
            96656.38389228036,
            97463.82094798237,
            97585.5765251919,
            97442.04681675724,
            97459.12539682529,
            97354.27325739387,
            96876.89154634211,
            96765.55824275386,
            97129.2131679456,
            97337.03098963221,
            97316.41651615771
        ]),
        currentHoldings: 1.5)
    
}
