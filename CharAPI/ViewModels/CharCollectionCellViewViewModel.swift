//
//  CharacterCollectionCellViewViewModel.swift
//  CharAPI
//
//  Created by may on 5/14/23.
//

import Foundation

class CharCollectionCellViewViewModel {

	let name: String
	let alias_names: [String]?
	let species: String?
	let blood_status: String?
	let imageURLString: String?
	
	init(name: String, alias_names: [String]?, species: String?, blood_status: String?, imageURLString: String?) {
		self.name = name
		self.alias_names = alias_names
		self.species = species
		self.blood_status = blood_status
		self.imageURLString = imageURLString
	}
	
	var secondaryComputedTxt: String {
		var str = blood_status ?? ""
		if let spec = species, spec != blood_status {
			str += ", \(spec)"
		}
		
		return str
	}
	
	func fetchImage(imageURL: URL, completion: @escaping(Result<Data, Error>) -> Void){
		let request = URLRequest(url: imageURL)
		let task = URLSession.shared.dataTask(with: request) { data, _, error in
			guard let data = data, error == nil else {
				completion(.failure(URLError(.badURL)))
				return
			}
			completion(.success(data))
			
		}
		task.resume()
	}

}
