//
//  ImageLoader.swift
//  CharAPI
//
//  Created by may on 5/20/23.
//

import Foundation

class ImageLoader {
	static let shared = ImageLoader()
	
	/// NSCache<key, result>
	/// Images that are cached, will automatically decached when space is needed
	private var imageDataCache = NSCache<NSString, NSData>()
	
	private init() {}
	
	
	/// Get image URL data
	/// - Parameters:
	///   - imageURL: url of image
	///   - completion: callback
	func downloadImage(imageURL: URL, completion: @escaping (Result<Data, Error>) -> Void){
		// check if image is in cache
		let key = imageURL.absoluteString as NSString
		if let data = imageDataCache.object(forKey: key) {
			completion(.success(data as Data))
			return
		}
		
		// download image (if not in cache yet)
		let request = URLRequest(url: imageURL)
		let task = URLSession.shared.dataTask(with: request) { data, _, error in
			guard let data = data, error == nil else {
				completion(.failure(URLError(.badURL)))
				return
			}
			
			// save in cache
			let value = data as NSData
			self.imageDataCache.setObject(value, forKey: key)
			
			
			completion(.success(data))
			
		}
		task.resume()
	}
}
