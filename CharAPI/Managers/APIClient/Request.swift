//
//  Request.swift
//  CharAPI
//
//  Created by may on 5/8/23.
//

import Foundation

@frozen enum API_URL_Endpoints: String {
	case characters
	case potions
	case spells
}

/// Object class that represents a single API Call
final class Request{
	
	/// cache the data onced called as there is no filter parameters
	/// and data is large and is immutable anyways, so to avoid multiple calls to API
	private let cache = UserDefaults.standard
	private let endpoint: API_URL_Endpoints
	private let filters: [URLQueryItem]
	private let addtnlParams: [String]
	
	init(endpoint: API_URL_Endpoints, filters: [URLQueryItem] = [], addtnlParams: [String] = []) {
		self.endpoint = endpoint
		self.filters = filters
		self.addtnlParams = addtnlParams
	}
	
	private struct API_Constants {
		static let base_url: String = "https://api.potterdb.com/v1/"
		// https: //docs.potterdb.com/apis/rest
	}
	
	// MARK: - Public
	var url: URL? {
		var urlString = API_Constants.base_url + endpoint.rawValue
		
		if !filters.isEmpty || !addtnlParams.isEmpty {
			urlString += "?"
			
			let fil = filters.compactMap({
				let query = "filter[\($0.name)]"
				if let value = $0.value {
					return query + "=\(value)"
				}

				return query
			}).joined(separator: "&")
			
			let addtnl = addtnlParams.compactMap{$0}.joined(separator: "&")
			
			let addOP = !filters.isEmpty ? "&" : ""
			
			urlString += fil + addOP + addtnl
		}
		
		
		
		print(urlString)
		return URL(string: urlString)
	}
	
	
	
}

extension Request {
	static let listCharactersRequest = Request(endpoint: .characters, filters: [
		URLQueryItem(name: "name_not_cont", value: "1"),
		URLQueryItem(name: "species_not_null", value: nil)
		], addtnlParams: [
			"sort=blood_status",
			"page[number=1]&page[size=20]"
		]
	)
	static let listPotionsRequest = Request(endpoint: .potions)
	static let listSpellsRequest = Request(endpoint: .spells)
	
}
