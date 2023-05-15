//
//  CharDetailViewViewModel.swift
//  CharAPI
//
//  Created by may on 5/15/23.
//

import Foundation

class CharDetailViewViewModel{
	private let star: Character
	
	init(star: Character) {
		self.star = star
	}
	
	var title: String {
		star.name.capitalized
	}
}
