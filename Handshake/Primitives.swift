//
//  Primitives.swift
//  Handshake
//
//  Created by Ben Syverson on 2016/2/20.
//  Copyright © 2016 Pox. All rights reserved.
//

import Foundation

protocol Representable {
	init?(dictionary: [String : AnyObject])
	func dictionaryRepresentation() -> [String : AnyObject]
}

struct Pseudonym : Representable {
	var firstName : String!
	var lastName : String!

	init?(dictionary: [String : AnyObject]) {
		guard let aFirst = dictionary["firstName"] as? String,
			let aLast = dictionary["lastName"] as? String else {
				return nil
		}
		self.firstName = aFirst
		self.lastName = aLast
	}
	
	init?(firstName: String, lastName: String) {
		self.firstName = firstName
		self.lastName = lastName
	}
	
	func dictionaryRepresentation() -> [String : AnyObject] {
		return ["firstName" : firstName, "lastName"  : lastName]
	}
}

struct User : Representable {
	let uuid : String!
	let name : Pseudonym!
	let pad : NSData!
	var offset : Int64!
	
	init?(dictionary: [String : AnyObject]) {
		guard let aUUID = dictionary["uuid"] as? String,
			let aName = dictionary["name"] as? [String : AnyObject],
			let aPseudonym = Pseudonym(dictionary: aName),
			let dataString = dictionary["pad"] as? String,
			let someData = NSData(base64EncodedString: dataString, options: NSDataBase64DecodingOptions()),
			let offsetVar = dictionary["offset"] as? NSNumber else {
			return nil
		}

		self.uuid = aUUID
		self.name = aPseudonym
		self.pad = someData
		self.offset = offsetVar.longLongValue
	}
	
	func dictionaryRepresentation() -> [String : AnyObject] {
		return [
			"uuid": uuid,
			"name": name.dictionaryRepresentation(),
			"pad": pad.base64EncodedStringWithOptions(NSDataBase64EncodingOptions()),
			"offset": NSNumber(longLong: offset)
		]
	}
}

struct Conversation : Representable {
	let me : User!
	let them : User!
	
	init?(dictionary: [String : AnyObject]) {
		guard let aMe = dictionary["uuid"] as? [String : AnyObject],
			let aMeUser = User(dictionary: aMe),
			let aThem = dictionary["name"] as? [String : AnyObject],
			let aThemUser = User(dictionary: aThem) else {
				return nil
		}
		
		self.me = aMeUser
		self.them = aThemUser
	}
	
	func dictionaryRepresentation() -> [String : AnyObject] {
		return ["me": me.dictionaryRepresentation(), "them": them.dictionaryRepresentation()]
	}
}

