//
//  Product.swift
//  Order
//
//  Created by Леонид Шайхутдинов on 31.10.2024.
//

import Foundation

struct Product {
    
    let title: String
    let size: Float?
    let imageUrl: String
    let price: Float
    let baseDiscountPercent: Int
    let count: Int
    
    init(title: String, size: Float? = nil, price: Float, count: Int, imageUrl: String, baseDiscountPercent: Int) {
        self.title = title
        self.imageUrl = imageUrl
        self.size = size
        self.baseDiscountPercent = baseDiscountPercent
        self.price = price
        self.count = count
    }
}

let testProducts: [Product] = [
    Product(title: "Золотое плоское обручальное кольцо 4 мм", size: 17, price: 5000, count: 1, imageUrl: "https://s3-alpha-sig.figma.com/img/0107/0af6/3297f40e81f4a6e2f72d2ce876867dac?Expires=1734912000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=egIYaCrnirIMW0xs776XVqu7dM8uTUMJNW~~HdhAQrXa~2Cdiiveu~39PC3vmrFBNzJ003vXeGxrRVhNU2T-yqmJdQ-REQiw53NIhl-eYO7CKssTHJT7hrcUwTUL-Ji7Wv6Mriv6sH9cxEAXygurZoUUUoWNl~UmtW1Hsq7f~rvodRBbskjKXdUWx6ub9oUtyOo7CCPI6V2z~sVQfAcsD3T02EOSpumKSa~8XmvttdpaWgS07vdaR6JX6mWReXhX0xhhPbvQRRV9EQ3YDw57bNgGTSrggovoe3qmNuHh~YkObodoMw-iui1dlkxzl~QmRR9nIrIf8x0DrPPc5zc7CQ__", baseDiscountPercent: 30),
    
    Product(title: "Золотое плоское обручальное кольцо c бриллиантом 4 мм", size: 17, price: 6000, count: 2, imageUrl: "https://s3-alpha-sig.figma.com/img/8417/f71d/4319833a81e19f434566798fb6f6c5d8?Expires=1734912000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=EZAOL7QPhI4BQyXJvvoHheKJ8rRiBzqq5YxKVzVbIzefeKDRFpGJfvUOyFMNYfTz~PdexXQ4iM~YryYLfDEarIEo0A3VMnDKPY0YGbMtsjaNokmKy~qOCUqz3gdVb8ubplRXcVcVVnXVURwskYqU63McSS2tPGH8p-sk5SxYyz4NsY0BfVXyqTpxJlJEL7eLrrpaCG1MaM0hkZb61dhRJeo0ZEKPguvHWLb2D6Op~oGTwK1pLLa1LjJ1~wRZen6Kpji07rEo7tFIk8XhBXfXjhZgAQKJ~GuyShFi~izrG33z2uv7B0WaJ4VJ3MU6DkUQZDTwRInL0EEO9z448ZfvzA__", baseDiscountPercent: 30),
    
    Product(title: "Серебрянное плоское обручальное кольцо", size: 17, price: 3000, count: 3, imageUrl: "https://s3-alpha-sig.figma.com/img/1872/894f/058de0bea04d50ed6858533562b1149d?Expires=1734912000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ZVRBIXxe2ShfgcxacvxO4S2a-R4lMQuxpn9ilrR04rdHwJLiKlhyfMEk7tMdswRjyG30rdgV4aGSk0qtMELS98qy5NF57R1Daqf6BrESdNAzhhlVDuC1W~D-yi8T9UJXXIrjrRbsKKKuJKpgBkFs5NBk~cSB-x62bM1szX~Gfxq7xHKrZflsBvcIeSJQfKKtLT68tM-LCr51mSBbnqRbQV4b467uJzGeCt2-99mfsvbQ~RVZrvzeX9ay8Fhx0JTvma5AlXXycNnpFnlmJ-MJVBPvkpJdKtVMK3NSW0Am5FPuKXFHfPb3RHlAYaFSX6YR0~wbDq4qWDR-H11~tCwoAw__", baseDiscountPercent: 30),
    
    Product(title: "Тонкое злотое обручальное кольцо", size: 17, price: 7000, count: 1, imageUrl: "https://s3-alpha-sig.figma.com/img/45eb/3169/c70b275259d9f61e160fe8ff9c7df36f?Expires=1734912000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=dxEkCga~PlHAryIQ-UpYdeBpHOE7cRPEbIBhi7UsmscQR9BfkDD-Zow9YM6ne2p5d1rl2rrVcroZrkHZpO9~GjaRmdzAIpWe0g0cRDxe4Jh0PVkHhCk2j7qCMHVDmKFv0AB6zn6q9PyXfQX-it8emhJwsab7YTkxdjhFtNVYPb0bqd-gIj52k-Uuo1OqAop9IPn3XmSO7QLl2gv47eppqy8qO4oy-0ETYzqDw34GOa3VIGwTa1zIzMBUGbCVldeA1VZkTqfQ1xJS1bH4mmvva20XNuwjGkohHEHUKJ-AtfmDiPAEKgv7EujE5q5vJOCwc8NEa9PFlgNgiUOBMl97UA__", baseDiscountPercent: 30),
    Product(title: "iPhone 16 Pro Max", price: 16113, count: 1, imageUrl: "https://avatars.mds.yandex.net/get-mpic/5207395/2a00000192afdbd6a4feebbe708d88c90cf1/180x240", baseDiscountPercent: 12),
]
