//
//  GetAllCharactersResponse.swift
//  CharAPI
//
//  Created by may on 5/11/23.
//

import Foundation



struct GetAllCharactersResponse: Codable {
	let data: [APIDataStructure<Character>]
	let meta: Meta
}

struct APIDataStructure<DataType: Codable> : Codable {
	let id: String
	let type: String
	let attributes: DataType
}

struct Meta: Codable {
	let pagination: Pagination
}

struct Pagination: Codable {
	let current: Int
	let next: Int
	let last: Int
	let records: Int
}
