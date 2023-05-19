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
	
	private let endpoint: API_URL_Endpoints
	private let addtnlParams: [String]
	
	var url: URL? {
		var urlString = API_Constants.base_url + endpoint.rawValue
		
		if !addtnlParams.isEmpty {
			urlString += "?"
		
			let addtnl = addtnlParams.compactMap{$0}.joined(separator: "&")
			
			urlString +=  addtnl
		}
		
		print(urlString)
		return URL(string: urlString)
	}
	
	init(endpoint: API_URL_Endpoints, addtnlParams: [String] = []) {
		self.endpoint = endpoint
		self.addtnlParams = addtnlParams
	}
	
	// use this if have the complete URL already
	// chops up the formed URL
	convenience init?(urlString: String) {
		var endpoint_found: API_URL_Endpoints
		var addtnlParams_found: [String]
		
		// replaces \u{0026} with  &
		var trimmed = urlString.replacingOccurrences(of:"\u{0026}", with: "&")
		
		// 1. chop base url
		trimmed = trimmed.replacingOccurrences(of: API_Constants.base_url, with: "")
		
		// 2. chop endpoint and addtnlparams
		
		// url with just an endpoint no addtnlParams
		if !trimmed.contains("?"){
			if let ep = API_URL_Endpoints(rawValue: trimmed) {
				endpoint_found = ep
				self.init(endpoint: endpoint_found)
				return
			}
		} else {
			// there are addtnlParams
			let components = trimmed.components(separatedBy: "?")
			if let ep = API_URL_Endpoints(rawValue: components[0]) {
				endpoint_found = ep
			} else {
				fatalError("wrong url, Request convenience init")
			}
			//chop endpoint + ?
			trimmed = trimmed.replacingOccurrences(of: components[0] + "?", with: "")
			// addtnl params are whats left
			addtnlParams_found = trimmed.components(separatedBy: "&")
			
			self.init(endpoint: endpoint_found, addtnlParams: addtnlParams_found)
			print("convenience init", self.endpoint, self.addtnlParams)
			return
		}
		
		return nil
	}

	
	private struct API_Constants {
		static let base_url: String = "https://api.potterdb.com/v1/"
		// https: //docs.potterdb.com/apis/rest
	}
	
	
	
	
	
	
}

extension Request {
	static let listCharactersRequest = Request(endpoint: .characters, addtnlParams: [
			"filter[name_not_cont]=1",
			"filter[species_not_null]",
			"sort=blood_status",
			"page[number=1]&page[size=20]"
		]
	)
	static let listPotionsRequest = Request(endpoint: .potions)
	static let listSpellsRequest = Request(endpoint: .spells)
	
}


/*
 
 convenience init?(urlString: String) {
	 var endpoint_found: API_URL_Endpoints
	 var addtnlParams_found: [String]
	 
	 // replaces \u{0026} with  &
	 var trimmed = urlString.replacingOccurrences(of:"\u{0026}", with: "&")
	 
	 // 1. chop base url
	 trimmed = trimmed.replacingOccurrences(of: API_Constants.base_url, with: "")

	 // 2. chop endpoint and addtnlparams
	 
	 // url with just an endpoint no addtnlParams
	 if !trimmed.contains("?"){
		 if let ep = API_URL_Endpoints(rawValue: trimmed) {
			 endpoint_found = ep
			 self.init(endpoint: endpoint_found)
			 return
		 }
	 } else {
		 // there are addtnlParams
		 let components = trimmed.components(separatedBy: "?")
		 if let ep = API_URL_Endpoints(rawValue: components[0]) {
			 endpoint_found = ep
		 } else {
			 fatalError("wrong url, Request convenience init")
		 }
		 //chop endpoint + ?
		 trimmed = trimmed.replacingOccurrences(of: components[0] + "?", with: "")
		 // addtnl params are whats left
		 addtnlParams_found = trimmed.components(separatedBy: "&")
		 
		 self.init(endpoint: endpoint_found, addtnlParams: addtnlParams_found)
		 return
	 }
	 
	 return nil
 }
 */
