//
//  CharDetailViewPhotoCVCellViewModel.swift
//  CharAPI
//
//  Created by may on 5/21/23.
//

import Foundation

class CharDetailViewPhotoCVCellViewModel {
	let image: String?
	let name : String
	let alias_names: String
	let titles: [String]?
	let born : String?
	let died : String?
	
	
	// MARK: - Init
	init(image: String?, name: String, alias_names: [String]?, titles: [String]?, born: String?, died: String?) {
		self.image = image
		self.name = name
		self.alias_names = alias_names?.joined(separator: "+") ?? ""
		self.titles = titles
		self.born = born
		self.died = died
	}
	
	// MARK: - Functions
	func fetchImage(completion: @escaping(Result<Data, Error>) -> Void){
		guard let imageString = image,
			let imageURL = URL(string: imageString)
		else {
			completion(.failure(URLError(.badURL)))
			return
		}
		
		ImageLoader.shared.downloadImage(imageURL: imageURL, completion: completion)
	}
}
