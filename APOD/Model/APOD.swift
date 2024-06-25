//
//  APOD.swift
//  APOD
//
//  Created by Brayden Harris on 6/25/24.
//

import Foundation

/*
 [
     {
         "date": "2024-05-24",
         "explanation": "Star formation can be messy. To help find out just how messy, ESA's new Sun-orbiting Euclid telescope recently captured the most detailed image ever of the bright star forming region M78. Near the image center, M78 lies at a distance of only about 1,300 light-years away and has a main glowing core that spans about 5 light-years.  The featured image was taken in both visible and infrared light. The purple tint in M78's center is caused by dark dust preferentially reflecting the blue light of hot, young stars.  Complex dust lanes and filaments can be traced through this gorgeous and revealing skyscape. On the upper left is associated star forming region NGC 2071, while a third region of star formation is visible on the lower right.  These nebulas are all part of the vast Orion Molecular Cloud Complex which can be found with even a small telescope just north of Orion's belt.   More Euclid Sky Candy: Recent images released from Euclid",
         "hdurl": "https://apod.nasa.gov/apod/image/2405/M78_Euclid_5532.jpg",
         "media_type": "image",
         "service_version": "v1",
         "title": "M78 from the Euclid Space Telescope",
         "url": "https://apod.nasa.gov/apod/image/2405/M78_Euclid_960.jpg"
     }
 ]
 */
struct APOD: Decodable {
    enum MediaType: String, Decodable {
        case image, video
    }
    
    enum CodingKeys: String, CodingKey {
        case date
        case title
        case explanation
        case url
        case hdurl
        case mediaType = "media_type"
    }
    
    let date: String?
    let title: String?
    let explanation: String?
    let url: URL?
    let hdurl: URL?
    let mediaType: MediaType?
    
    init(date: String, title: String, explanation: String?, url: URL?, hdurl: URL?, mediaType: MediaType?) {
        self.date = date
        self.title = title
        self.explanation = explanation
        self.url = url
        self.hdurl = hdurl
        self.mediaType = mediaType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let dateString = try container.decodeIfPresent(String.self, forKey: .date) {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd"
            date = dateString
        } else {
            date = nil
        }
        title = try container.decodeIfPresent(String.self, forKey: .title)
        explanation = try container.decodeIfPresent(String.self, forKey: .explanation)
        if let urlString = try container.decodeIfPresent(String.self, forKey: .url) {
            url = URL(string: urlString)
        } else {
            url = nil
        }
        if let hdurlString = try container.decodeIfPresent(String.self, forKey: .hdurl) {
            hdurl = URL(string: hdurlString)
        } else {
            hdurl = nil
        }
        if let mediaTypeString = try container.decodeIfPresent(String.self, forKey: .mediaType) {
            mediaType = MediaType(rawValue: mediaTypeString)
        } else {
            mediaType = nil
        }
    }
}

extension APOD: Identifiable {
    var id: String {
        title ?? ""
    }
}
