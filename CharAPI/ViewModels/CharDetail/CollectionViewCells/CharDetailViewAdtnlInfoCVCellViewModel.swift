//
//  CharDetailViewAdtnlInfoCVCellViewModel.swift
//  CharAPI
//
//  Created by may on 5/21/23.
//

import Foundation

class CharDetailViewAdtnlInfoCVCellViewModel {
	let gender : String?
	let height : String?
	let weight : String?
	let hair_color : String?
	let eye_color : String?
	let skin_color : String?
	let wiki : String?
	
	init(gender: String?, height: String?, weight: String?, hair_color: String?, eye_color: String?, skin_color: String?, wiki: String?) {
		self.gender = gender
		self.height = height
		self.weight = weight
		self.hair_color = hair_color
		self.eye_color = eye_color
		self.skin_color = skin_color
		self.wiki = wiki
	}
}
