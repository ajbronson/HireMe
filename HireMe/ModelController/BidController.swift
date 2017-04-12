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

		//--------------------------------
		var job = JobController.shared.jobs[0]

		var bidder = BidderController.shared.bidders[0]

		let bid = Bid(id: "0", bidder: bidder, job: job, price: 25, description: "I've always been pretty good at anything that I set my mind to. I'd like to place a bid on this job for consideration given my extensive backgorund and such. Price point seemed okay to me, although I would like to see if you could negotiate at all on the price. One time I purchased this vehicle from KSL classifieds, and I got a pretty good deal because I simply was willing to negotiate on the price, and I wanted to know if you would be interested in giving me a good deal. At this point I'm just rambling on, because I'm not quite sure what else to say. I like cooking, cleaning, vacuuming especailly is a favorite of mine. Please consider my services and what I can offer you, because I will do such a great job. I've lived in Utah basically my entire life, and I'm positive that I'll provide you with great success in whatever it is that you're trying to do.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[1]

		let bid1 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "I can do this pretty well, please check out my list of skills and my ratings. People have hired me for much less.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[2]

		let bid2 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "Price seemed right, I'm your person. Hook me up, and I hook you up, that's what my mother always taught me. I'm good for the job, if you're good for the money. Reach out to me ASAP or check out my profile to continue. You can always give me a ring-a-ling and I'll come by to check out your place. Thx for the consideration and all.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[3]

		let bid3 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "I'm good for the job, if you're good for the money. Reach out to me ASAP or check out my profile to continue. You can always give me a ring-a-ling and I'll come by to check out your place. Thx for the consideration and all.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[4]

		let bid4 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "Listen, I've got skills, and that's what this job is going to take. Check out my star rating for more, there's nothing more to add to it, and my friend, you won't be disappointed in the work that I provide.", status: BidStatus.PendingResponse.rawValue)

		//--------------------------------
		job = JobController.shared.jobs[1]

		bidder = BidderController.shared.bidders[0]

		let bid5 = Bid(id: "0", bidder: bidder, job: job, price: 25, description: "I've always been pretty good at anything that I set my mind to. I'd like to place a bid on this job for consideration given my extensive backgorund and such. Price point seemed okay to me, although I would like to see if you could negotiate at all on the price. One time I purchased this vehicle from KSL classifieds, and I got a pretty good deal because I simply was willing to negotiate on the price, and I wanted to know if you would be interested in giving me a good deal. At this point I'm just rambling on, because I'm not quite sure what else to say. I like cooking, cleaning, vacuuming especailly is a favorite of mine. Please consider my services and what I can offer you, because I will do such a great job. I've lived in Utah basically my entire life, and I'm positive that I'll provide you with great success in whatever it is that you're trying to do.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[1]

		let bid6 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "I can do this pretty well, please check out my list of skills and my ratings. People have hired me for much less.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[2]

		let bid7 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "Price seemed right, I'm your person. Hook me up, and I hook you up, that's what my mother always taught me. I'm good for the job, if you're good for the money. Reach out to me ASAP or check out my profile to continue. You can always give me a ring-a-ling and I'll come by to check out your place. Thx for the consideration and all.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[3]

		let bid8 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "I'm good for the job, if you're good for the money. Reach out to me ASAP or check out my profile to continue. You can always give me a ring-a-ling and I'll come by to check out your place. Thx for the consideration and all.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[4]

		let bid9 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "Listen, I've got skills, and that's what this job is going to take. Check out my star rating for more, there's nothing more to add to it, and my friend, you won't be disappointed in the work that I provide.", status: BidStatus.PendingResponse.rawValue)

		//--------------------------------
		job = JobController.shared.jobs[2]

		bidder = BidderController.shared.bidders[0]

		let bid10 = Bid(id: "0", bidder: bidder, job: job, price: 25, description: "I've always been pretty good at anything that I set my mind to. I'd like to place a bid on this job for consideration given my extensive backgorund and such. Price point seemed okay to me, although I would like to see if you could negotiate at all on the price. One time I purchased this vehicle from KSL classifieds, and I got a pretty good deal because I simply was willing to negotiate on the price, and I wanted to know if you would be interested in giving me a good deal. At this point I'm just rambling on, because I'm not quite sure what else to say. I like cooking, cleaning, vacuuming especailly is a favorite of mine. Please consider my services and what I can offer you, because I will do such a great job. I've lived in Utah basically my entire life, and I'm positive that I'll provide you with great success in whatever it is that you're trying to do.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[1]

		let bid11 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "I can do this pretty well, please check out my list of skills and my ratings. People have hired me for much less.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[2]

		let bid12 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "Price seemed right, I'm your person. Hook me up, and I hook you up, that's what my mother always taught me. I'm good for the job, if you're good for the money. Reach out to me ASAP or check out my profile to continue. You can always give me a ring-a-ling and I'll come by to check out your place. Thx for the consideration and all.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[3]

		let bid13 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "I'm good for the job, if you're good for the money. Reach out to me ASAP or check out my profile to continue. You can always give me a ring-a-ling and I'll come by to check out your place. Thx for the consideration and all.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[4]

		let bid14 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "Listen, I've got skills, and that's what this job is going to take. Check out my star rating for more, there's nothing more to add to it, and my friend, you won't be disappointed in the work that I provide.", status: BidStatus.PendingResponse.rawValue)

		//--------------------------------
		job = JobController.shared.jobs[3]

		bidder = BidderController.shared.bidders[0]

		let bid15 = Bid(id: "0", bidder: bidder, job: job, price: 25, description: "I've always been pretty good at anything that I set my mind to. I'd like to place a bid on this job for consideration given my extensive backgorund and such. Price point seemed okay to me, although I would like to see if you could negotiate at all on the price. One time I purchased this vehicle from KSL classifieds, and I got a pretty good deal because I simply was willing to negotiate on the price, and I wanted to know if you would be interested in giving me a good deal. At this point I'm just rambling on, because I'm not quite sure what else to say. I like cooking, cleaning, vacuuming especailly is a favorite of mine. Please consider my services and what I can offer you, because I will do such a great job. I've lived in Utah basically my entire life, and I'm positive that I'll provide you with great success in whatever it is that you're trying to do.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[1]

		let bid16 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "I can do this pretty well, please check out my list of skills and my ratings. People have hired me for much less.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[2]

		let bid17 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "Price seemed right, I'm your person. Hook me up, and I hook you up, that's what my mother always taught me. I'm good for the job, if you're good for the money. Reach out to me ASAP or check out my profile to continue. You can always give me a ring-a-ling and I'll come by to check out your place. Thx for the consideration and all.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[3]

		let bid18 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "I'm good for the job, if you're good for the money. Reach out to me ASAP or check out my profile to continue. You can always give me a ring-a-ling and I'll come by to check out your place. Thx for the consideration and all.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[4]

		let bid19 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "Listen, I've got skills, and that's what this job is going to take. Check out my star rating for more, there's nothing more to add to it, and my friend, you won't be disappointed in the work that I provide.", status: BidStatus.PendingResponse.rawValue)

		//--------------------------------
		job = JobController.shared.jobs[3]

		bidder = BidderController.shared.bidders[0]

		let bid20 = Bid(id: "0", bidder: bidder, job: job, price: 25, description: "I've always been pretty good at anything that I set my mind to. I'd like to place a bid on this job for consideration given my extensive backgorund and such. Price point seemed okay to me, although I would like to see if you could negotiate at all on the price. One time I purchased this vehicle from KSL classifieds, and I got a pretty good deal because I simply was willing to negotiate on the price, and I wanted to know if you would be interested in giving me a good deal. At this point I'm just rambling on, because I'm not quite sure what else to say. I like cooking, cleaning, vacuuming especailly is a favorite of mine. Please consider my services and what I can offer you, because I will do such a great job. I've lived in Utah basically my entire life, and I'm positive that I'll provide you with great success in whatever it is that you're trying to do.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[1]

		let bid21 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "I can do this pretty well, please check out my list of skills and my ratings. People have hired me for much less.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[2]

		let bid22 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "Price seemed right, I'm your person. Hook me up, and I hook you up, that's what my mother always taught me. I'm good for the job, if you're good for the money. Reach out to me ASAP or check out my profile to continue. You can always give me a ring-a-ling and I'll come by to check out your place. Thx for the consideration and all.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[3]

		let bid23 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "I'm good for the job, if you're good for the money. Reach out to me ASAP or check out my profile to continue. You can always give me a ring-a-ling and I'll come by to check out your place. Thx for the consideration and all.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[4]

		let bid24 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "Listen, I've got skills, and that's what this job is going to take. Check out my star rating for more, there's nothing more to add to it, and my friend, you won't be disappointed in the work that I provide.", status: BidStatus.PendingResponse.rawValue)

		//--------------------------------
		job = JobController.shared.jobs[5]

		bidder = BidderController.shared.bidders[0]

		let bid25 = Bid(id: "0", bidder: bidder, job: job, price: 25, description: "I've always been pretty good at anything that I set my mind to. I'd like to place a bid on this job for consideration given my extensive backgorund and such. Price point seemed okay to me, although I would like to see if you could negotiate at all on the price. One time I purchased this vehicle from KSL classifieds, and I got a pretty good deal because I simply was willing to negotiate on the price, and I wanted to know if you would be interested in giving me a good deal. At this point I'm just rambling on, because I'm not quite sure what else to say. I like cooking, cleaning, vacuuming especailly is a favorite of mine. Please consider my services and what I can offer you, because I will do such a great job. I've lived in Utah basically my entire life, and I'm positive that I'll provide you with great success in whatever it is that you're trying to do.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[1]

		let bid26 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "I can do this pretty well, please check out my list of skills and my ratings. People have hired me for much less.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[2]

		let bid27 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "Price seemed right, I'm your person. Hook me up, and I hook you up, that's what my mother always taught me. I'm good for the job, if you're good for the money. Reach out to me ASAP or check out my profile to continue. You can always give me a ring-a-ling and I'll come by to check out your place. Thx for the consideration and all.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[3]

		let bid28 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "I'm good for the job, if you're good for the money. Reach out to me ASAP or check out my profile to continue. You can always give me a ring-a-ling and I'll come by to check out your place. Thx for the consideration and all.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[4]

		let bid29 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "Listen, I've got skills, and that's what this job is going to take. Check out my star rating for more, there's nothing more to add to it, and my friend, you won't be disappointed in the work that I provide.", status: BidStatus.PendingResponse.rawValue)
		//--------------------------------
		job = JobController.shared.jobs[4]

		bidder = BidderController.shared.bidders[0]

		let bid30 = Bid(id: "0", bidder: bidder, job: job, price: 25, description: "I've always been pretty good at anything that I set my mind to. I'd like to place a bid on this job for consideration given my extensive backgorund and such. Price point seemed okay to me, although I would like to see if you could negotiate at all on the price. One time I purchased this vehicle from KSL classifieds, and I got a pretty good deal because I simply was willing to negotiate on the price, and I wanted to know if you would be interested in giving me a good deal. At this point I'm just rambling on, because I'm not quite sure what else to say. I like cooking, cleaning, vacuuming especailly is a favorite of mine. Please consider my services and what I can offer you, because I will do such a great job. I've lived in Utah basically my entire life, and I'm positive that I'll provide you with great success in whatever it is that you're trying to do.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[1]

		let bid31 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "I can do this pretty well, please check out my list of skills and my ratings. People have hired me for much less.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[2]

		let bid32 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "Price seemed right, I'm your person. Hook me up, and I hook you up, that's what my mother always taught me. I'm good for the job, if you're good for the money. Reach out to me ASAP or check out my profile to continue. You can always give me a ring-a-ling and I'll come by to check out your place. Thx for the consideration and all.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[3]

		let bid33 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "I'm good for the job, if you're good for the money. Reach out to me ASAP or check out my profile to continue. You can always give me a ring-a-ling and I'll come by to check out your place. Thx for the consideration and all.", status: BidStatus.PendingResponse.rawValue)

		bidder = BidderController.shared.bidders[4]

		let bid34 = Bid(id: "0", bidder: bidder, job: job, price: 2260, description: "Listen, I've got skills, and that's what this job is going to take. Check out my star rating for more, there's nothing more to add to it, and my friend, you won't be disappointed in the work that I provide.", status: BidStatus.PendingResponse.rawValue)

		bids = [bid, bid1, bid2, bid3, bid4, bid5, bid6, bid7, bid8, bid9, bid10, bid11, bid12, bid13, bid14, bid15, bid16, bid17, bid18, bid19, bid20, bid21, bid22, bid23, bid24, bid25, bid26, bid27, bid28, bid29, bid30, bid31, bid32, bid33, bid34]
        
        for job in JobController.shared.jobs {
            job.selectedBid = bid
        }
	}

	func removeBids(passedBids: [Bid]) {
		for bid in passedBids {
			if let index = bids.index(of: bid) {
				bids.remove(at: index)
			}
		}
	}

	func createBid(job: Job, price: Double?, description: String) {
		let newBid = Bid(id: UUID().uuidString, bidder: BidderController.shared.bidders[0], job: job, price: price, description: description)
		bids.append(newBid)
	}

	func updateBid(bid: Bid, price: Double?, description: String) {
		bid.price = price
		bid.description = description
	}

	func refresh(completion: @escaping (_ bids: [Bid]?) -> Void) {
		// TODO: implement
	}
}
