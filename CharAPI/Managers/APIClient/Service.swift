//
//  Service.swift
//  CharAPI
//
//  Created by may on 5/8/23.


import Foundation

/// API Service Caller Object to get HP data
/// a singleton class that we can access anywhere.
final class Service {
	
	static let shared = Service()
	
	enum ServiceErrors: Error {
		case failedToCreateRequest
		case failedToGetData
	}
	
	/// private constructor
	/// - adding a init forces to use shared instance
	private init() {
		
	}
	
	/// Send API Call
	/// - Parameters:
	///   - request: req instance
	///   - type: type of obj to get. Cuz can be String, Character Model, House Model, Wand Model, or etc. This uses Generics
	///   - completion: callback with data or error
	func fetchData<T: Codable>(_ request: Request, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void){

		guard let urlReq = self.urlRequest(from: request)
		else {
			completion(.failure(ServiceErrors.failedToCreateRequest))
			return
		}
		
		let task = URLSession.shared.dataTask(with: urlReq) { data, response, error in
			guard let data = data, error == nil else {
				completion(.failure(error ?? ServiceErrors.failedToGetData))
				return
			}
			
			// Decode the data result
			do {
				let json = try JSONDecoder().decode(type.self, from: data)
				completion(.success(json))
			} catch {
				completion(.failure(error))
			}
		}
		task.resume()
	}
	
	private func urlRequest(from requestData: Request) -> URLRequest? {
		guard let url = requestData.url else { return nil }
		var request = URLRequest(url: url)
		request.httpMethod = request.httpMethod
		
		return request
	}
}



/*
 
 ///test url request json result
 
	 do {
		 let json = try JSONSerialization.jsonObject(with: data)
		 print(String(describing: json))
	 } catch {
		 completion(.failure(error))
 }
 */
