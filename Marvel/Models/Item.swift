//
//	Item.swift
//
//	Create by sameh mabrouk on 18/4/2016
//	Copyright © 2016. All rights reserved.
//

import Foundation

struct Item{

	var name : String!
	var resourceURI : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		name = dictionary["name"] as? String
		resourceURI = dictionary["resourceURI"] as? String
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
        dictionary["name"] = name

		if name != nil{
			dictionary["name"] = name
		}
		if resourceURI != nil{
			dictionary["resourceURI"] = resourceURI
		}
		return dictionary
	}

}