//
//  Wands.swift
//  CharAPI
//
//  Created by may on 5/8/23.
//

import Foundation

struct Spell: Codable {
	let slug: String
	let name: String?
	let incantation: String?
	let category: String?
	let effect: String?
	let light: String?
	let hand: String?
	let creator: String?
	let image: String?
	let wiki: String?
}
