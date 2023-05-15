//
//  extensions.swift
//  CharAPI
//
//  Created by may on 5/14/23.
//

import Foundation
import UIKit

extension UIView {
	func applyShadow(cornerRadius: CGFloat){
		layer.cornerRadius = cornerRadius
		layer.masksToBounds = false
		layer.shadowOffset = CGSize(width: -5, height: 5)
		layer.shadowRadius = 4.0
		layer.shadowOpacity = 0.5
		layer.shadowColor = UIColor.secondaryLabel.cgColor
	}
	
	@IBInspectable
		var cornerRadius: CGFloat {
			get {
				return layer.cornerRadius
			}
			set {
				layer.cornerRadius = newValue
			}
		}

		@IBInspectable
		var borderWidth: CGFloat {
			get {
				return layer.borderWidth
			}
			set {
				layer.borderWidth = newValue
			}
		}
		
		@IBInspectable
		var borderColor: UIColor? {
			get {
				if let color = layer.borderColor {
					return UIColor(cgColor: color)
				}
				return nil
			}
			set {
				if let color = newValue {
					layer.borderColor = color.cgColor
				} else {
					layer.borderColor = nil
				}
			}
		}
		
		@IBInspectable
		var shadowRadius: CGFloat {
			get {
				return layer.shadowRadius
			}
			set {
				layer.shadowRadius = newValue
			}
		}
		
		@IBInspectable
		var shadowOpacity: Float {
			get {
				return layer.shadowOpacity
			}
			set {
				layer.shadowOpacity = newValue
			}
		}
		
		@IBInspectable
		var shadowOffset: CGSize {
			get {
				return layer.shadowOffset
			}
			set {
				layer.shadowOffset = newValue
			}
		}
		
		@IBInspectable
		var shadowColor: UIColor? {
			get {
				if let color = layer.shadowColor {
					return UIColor(cgColor: color)
				}
				return nil
			}
			set {
				if let color = newValue {
					layer.shadowColor = color.cgColor
				} else {
					layer.shadowColor = nil
				}
			}
		}
}
