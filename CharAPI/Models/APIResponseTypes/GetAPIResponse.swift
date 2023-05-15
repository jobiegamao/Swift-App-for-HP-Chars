//
//  GetAllCharactersResponse.swift
//  CharAPI
//
//  Created by may on 5/11/23.
//

import Foundation



struct GetAllCharactersResponse: Codable {
	let data: [APIDataStructure<Character>]
	let links: LinksPagination
}

struct APIDataStructure<DataType: Codable> : Codable {
	let id: String
	let type: String
	let attributes: DataType
}


struct LinksPagination: Codable {
	let current: String
	let first: String?
	let prev: String?
	let next: String?
	let last: String?
}
