//
//  Namer.swift
//  Handshake
//
//  Created by Ben Syverson on 2016/2/20.
//  Copyright © 2016 Pox. All rights reserved.
//

import Foundation


class Namer : NSObject {
	var nouns : [String]? = nil
	var adjectives : [String]? = nil
	
	func splitFile(fileName: String) -> [String]? {
		let path : String?
		let nounString : String?
		
		path = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt")
		guard path != nil else {
			return nil
		}
		
		do {
			nounString = try NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding) as String
		} catch _ {
			nounString = nil
		}
		
		guard nounString != nil else {
			return nil
		}
		return nounString!.characters.split("\n").map(String.init)
	}
	
	func name() -> Pseudonym? {
		
		if nouns == nil {
			nouns = splitFile("nouns")
		}
		if adjectives == nil {
			adjectives = splitFile("adjectives")
		}
		
		guard (nouns != nil && adjectives != nil) else {
			return nil
		}
		
		let randomIndexN = Int(arc4random_uniform(UInt32(nouns!.count)))
		let randomIndexA = Int(arc4random_uniform(UInt32(adjectives!.count)))

		let aNoun = nouns![randomIndexN]
		let anAdjective = adjectives![randomIndexA]
		
		return Pseudonym(firstName: anAdjective, lastName: aNoun)
	}
}

