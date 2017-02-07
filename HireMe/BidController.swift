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
		let bid = Bid(user: "AJ", price: 225, description: "Lorem ipsum dolor sit amet, laoreet proin mauris dui hymenaeos mi dictumst, etiam consectetuer lectus morbi turpis vulputate, lectus rutrum a landit, eu tincidunt ridiculus. Inceptos feugiat justo vitae pellentesque congue, diam non nam, pulvinar eu, pharetra torquent. Sollicitudin proin arcu vestibulum ac, a tristique ante vel. Aliquam sit eros scelerisque, ut adipiscing fermentum fusce felis suspendisse aenean. Luctus nisl libero wisi odio porttitor, sit nulla, lectus tristique turpis augue eleifend, sed dictum dui ut orci cras, est neque convallis imperdiet suscipit auctor morbi. Luctus dignissim vulputate, venenatis ultrices wisi ultrices pellentesque faucibus leo, odio vitae sed sociosqu quis est. Orci in sagittis nunc mi, nec lacinia, magnis commodo pede vitae rutrum. Conubia vivamus ut orci lectus nulla. Quis ridiculus consectetuer mollis aliquam mauris, non laoreet tortor hendrerit gravida sed arcu, tellus ligula. Integer nulla scelerisque fusce vulputate, porttitor blandit faucibus tortor, ut non dolor sagittis cursus, ad amet urna eget, ad sollicitudin consectetuer imperdiet magna sem.Dolor phasellus lectus nibh nisl, suspendisse orci, pellentesque in eu condimentum suscipit lorem temporibus. Turpis tempor velit vel a et eros, sit accumsan eu, duis lectus aenean nisl rutrum diam sociosqu, odio blandit id arcu, eleifend mattis et a phasellus vestibulum lacus. Ullamcorper porta elementum nec tempor nibh imperdiet, sagittis consectetuer et wisi vestibulum, justo nec placerat a est proin. Molestie ullamcorper aenean eget a dui bibendum, orci viverra mi enim tristique ligula, eu ut sed suspendisse, posuere integer, tellus vel quam donec. Libero risus nullam orci aliquet, imperdiet in imperdiet aute et. Luctus bibendum nunc lobortis sed velit. Aenean quisque lobortis duis quis vestibulum, sit faucibus sed pulvinar praesent dui. Laoreet libero mauris nibh vestibulum purus sed, sagittis nec sed bibendum, nam elit aliquam.")

		let bid2 = Bid(user: "Nate", price: 235, description: "Lorem ipsum dolor sit amet, laoreet proin mauris dui hymenaeos mi dictumst, etiam consectetuer lectus morbi turpis vulputate, lectus rutrum a landit, eu tincidunt ridiculus. Inceptos feugi")

		let bid3 = Bid(user: "David", price: 2425.889, description: "Lorem ipsum dolor sit amet, laoreet proin mauris dui hymenaeos mi dictumst, etiam consectetuer lectus morbi turpis vulputate, lectus rutrum a landit, eu tincidunt ridiculus. Inceptos feugiat justo vitae pellentesque congue, diam non nam, pulvinar eu, pharetra torquent. Sollicitudin proin arcu vestibulum ac, a tristique ante vel. Aliquam sit eros scelerisque, ut adipiscing fermentum fusce felis suspendisse aenean. Luctus nisl libero wisi odio porttitor, sit nulla, lectus tristique turpis augue eleifend, sed dictum dui ut orci cras, est neque convallis imperdiet suscipit auctor morbi. Luctus dignissim vulputate, venenatis ultrices wisi ultrices pellentesque faucibus leo, odio vitae sed sociosqu quis est. Orci in sagittis nunc mi, nec lacinia, magnis commodo pede vitae rutrum. Con")

		let bid4 = Bid(user: "Tom", price: 2225.99, description: "Lorem ipsum dolor sit amet, laoreet proin mauris dui hymenaeos mi dictumst, etiam consectetuer lectus morbi turpis vulputate, lectus rutrum a landit, eu tincidunt ridiculus. Inceptos feugiat justo vitae pellentesque congue, diam non nam, pulvinar eu, pharetra torquent. Sollicitudin proin arcu vestibulum ac, a tristique ante vel. Aliquam sit eros scelerisque, ut adipiscing fermentum fusce felis suspendisse aenean. Luctus nisl libero wisi odio porttitor, sit nulla, lectus tristique turpis augue eleifend, sed dictum dui ut orci cras, est neque convallis imperdiet suscipit auctor morbi. Luctus dignissim vulputate, venenatis ultrices wisi ultrices pellentesque faucibus leo, odio vitae sed sociosqu quis est. Orci in sagittis nunc mi, nec lacinia, magnis commodo pede vitae rutrum. Conubia vivamus ut orci lectus nulla. Quis ridiculus consectetuer mollis aliquam mauris, non laoreet tortor hendrerit gravida sed arcu, tellus ligula. Integer nulla scelerisque fusce vulputate, porttitor blandit faucibus tortor, ut non dolor sagittis cursus, ad amet urna eget, ad sollicitudin consectetuer imperdiet magna sem.Dolor phasellus lectus nibh nisl, suspendisse orci, pellentesque in eu condimentum suscipit lorem temporibus. Turpis tempor velit vel a et eros, sit accumsan eu, duis lectus aenean nisl rutrum diam sociosqu, odio blandit id arcu, eleifend mattis et a phasellus vestibulum lacus. Ullamcorper po")

		let bid5 = Bid(user: "Bryan de la joya de la maria que me pario entonces tu sabes lo que pasa", price: 2225.35, description: "I can do this pretty well")

		bids = [bid, bid2, bid3, bid4, bid5]
	}
}
