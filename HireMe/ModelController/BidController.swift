//
//  BidController.swift
//  HireMe
//
//  Created by AJ Bronson on 1/29/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

class BidController {

	static let shared = BidController()

	var bids: [Bid] = []

	init() {
		var bidder = Bidder(id: 0, firstName: "AJ", lastName: "Bronson", numberOfStars: 4)
		var job = JobController.shared.jobs[0]
		let bid = Bid(id: 0, bidder: bidder, job: job, price: 225, description: "Lorem ipsum dolor sit amet, laoreet proin mauris dui hymenaeos mi dictumst, etiam consectetuer lectus morbi turpis vulputate, lectus rutrum a landit, eu tincidunt ridiculus. Inceptos feugiat justo vitae pellentesque congue, diam non nam, pulvinar eu, pharetra torquent. Sollicitudin proin arcu vestibulum ac, a tristique ante vel. Aliquam sit eros scelerisque, ut adipiscing fermentum fusce felis suspendisse aenean. Luctus nisl libero wisi odio porttitor, sit nulla, lectus tristique turpis augue eleifend, sed dictum dui ut orci cras, est neque convallis imperdiet suscipit auctor morbi. Luctus dignissim vulputate, venenatis ultrices wisi ultrices pellentesque faucibus leo, odio vitae sed sociosqu quis est. Orci in sagittis nunc mi, nec lacinia, magnis commodo pede vitae rutrum. Conubia vivamus ut orci lectus nulla. Quis ridiculus consectetuer mollis aliquam mauris, non laoreet tortor hendrerit gravida sed arcu, tellus ligula. Integer nulla scelerisque fusce vulputate, porttitor blandit faucibus tortor, ut non dolor sagittis cursus, ad amet urna eget, ad sollicitudin consectetuer imperdiet magna sem.Dolor phasellus lectus nibh nisl, suspendisse orci, pellentesque in eu condimentum suscipit lorem temporibus. Turpis tempor velit vel a et eros, sit accumsan eu, duis lectus aenean nisl rutrum diam sociosqu, odio blandit id arcu, eleifend mattis et a phasellus vestibulum lacus. Ullamcorper porta elementum nec tempor nibh imperdiet, sagittis consectetuer et wisi vestibulum, justo nec placerat a est proin. Molestie ullamcorper aenean eget a dui bibendum, orci viverra mi enim tristique ligula, eu ut sed suspendisse, posuere integer, tellus vel quam donec. Libero risus nullam orci aliquet, imperdiet in imperdiet aute et. Luctus bibendum nunc lobortis sed velit. Aenean quisque lobortis duis quis vestibulum, sit faucibus sed pulvinar praesent dui. Laoreet libero mauris nibh vestibulum purus sed, sagittis nec sed bibendum, nam elit aliquam. END", status: BidStatus.PendingResponse.rawValue)

		bidder = Bidder(id: 0, firstName: "Tom", lastName: "Meservy", numberOfStars: 3)
		job = JobController.shared.jobs[1]

		let bid2 = Bid(id: 0, bidder: bidder, job: job, price: 235, description: "Lorem ipsum dolor sit amet, laoreet proin mauris dui hymenaeos mi dictumst, etiam consectetuer lectus morbi turpis vulputate, lectus rutrum a landit, eu tincidunt ridiculus. Inceptos feugi END")

		bidder = Bidder(id: 0, firstName: "David", lastName: "Payne", numberOfStars: 1)
		job = JobController.shared.jobs[2]

		let bid3 = Bid(id: 0, bidder: bidder, job: job, price: 2425.889, description: "Lorem ipsum dolor sit amet, laoreet proin mauris dui hymenaeos mi dictumst, etiam consectetuer lectus morbi turpis vulputate, lectus rutrum a landit, eu tincidunt ridiculus. Inceptos feugiat justo vitae pellentesque congue, diam non nam, pulvinar eu, pharetra torquent. Sollicitudin proin arcu vestibulum ac, a tristique ante vel. Aliquam sit eros scelerisque, ut adipiscing fermentum fusce felis suspendisse aenean. Luctus nisl libero wisi odio porttitor, sit nulla, lectus tristique turpis augue eleifend, sed dictum dui ut orci cras, est neque convallis imperdiet suscipit auctor morbi. Luctus dignissim vulputate, venenatis ultrices wisi ultrices pellentesque faucibus leo, odio vitae sed sociosqu quis est. Orci in sagittis nunc mi, nec lacinia, magnis commodo pede vitae rutrum. Con END")

		bidder = Bidder(id: 0, firstName: "Nate", lastName: "Johnson", numberOfStars: 5)
		job = JobController.shared.jobs[3]

		let bid4 = Bid(id: 0, bidder: bidder, job: job, price: 2225.99, description: "Lorem ipsum dolor sit amet, laoreet proin mauris dui hymenaeos mi dictumst, etiam consectetuer lectus morbi turpis vulputate, lectus rutrum a landit, eu tincidunt ridiculus. Inceptos feugiat justo vitae pellentesque congue, diam non nam, pulvinar eu, pharetra torquent. Sollicitudin proin arcu vestibulum ac, a tristique ante vel. Aliquam sit eros scelerisque, ut adipiscing fermentum fusce felis suspendisse aenean. Luctus nisl libero wisi odio porttitor, sit nulla, lectus tristique turpis augue eleifend, sed dictum dui ut orci cras, est neque convallis imperdiet suscipit auctor morbi. Luctus dignissim vulputate, venenatis ultrices wisi ultrices pellentesque faucibus leo, odio vitae sed sociosqu quis est. Orci in sagittis nunc mi, nec lacinia, magnis commodo pede vitae rutrum. Conubia vivamus ut orci lectus nulla. Quis ridiculus consectetuer mollis aliquam mauris, non laoreet tortor hendrerit gravida sed arcu, tellus ligula. Integer nulla scelerisque fusce vulputate, porttitor blandit faucibus tortor, ut non dolor sagittis cursus, ad amet urna eget, ad sollicitudin consectetuer imperdiet magna sem.Dolor phasellus lectus nibh nisl, suspendisse orci, pellentesque in eu condimentum suscipit lorem temporibus. Turpis tempor velit vel a et eros, sit accumsan eu, duis lectus aenean nisl rutrum diam sociosqu, odio blandit id arcu, eleifend mattis et a phasellus vestibulum lacus. Ullamcorper po END")

		bidder = Bidder(id: 0, firstName: "Rob", lastName: "Bryan", numberOfStars: 2)
		job = JobController.shared.jobs[3]

		let bid5 = Bid(id: 0, bidder: bidder, job: job, price: 2225.35, description: "I can do this pretty well END", status: BidStatus.PendingResponse.rawValue)

		bids = [bid, bid2, bid3, bid4, bid5]
        job.selectedBid = bid // job4
	}

	func removeBids(passedBids: [Bid]) {
		for bid in passedBids {
			if let index = bids.index(of: bid) {
				bids.remove(at: index)
			}
		}
	}

	func refresh(completion: @escaping (_ bids: [Bid]?) -> Void) {
		let params = ["token" : "abcdefg"]
		if let url = URL(string: "") {
			NetworkConroller.performURLRequest(url, method: .Get, urlParams: params, body: nil, completion: { (data, error) in
				if let error = error {
					print("An error has occured: \(error.localizedDescription)")
				} else if let data = data,
					let rawJSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
					let json = rawJSON as? [String: AnyObject],
					let resultDict = json["results"] as? [[String: AnyObject]] {
					completion(self.bids)
				}
			})
		}
	}
}
