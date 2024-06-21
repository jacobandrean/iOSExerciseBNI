//
//  PromoService.swift
//  APIModule
//
//  Created by J Andrean on 19/06/24.
//

import Combine
import Foundation
import NetworkModule

public protocol PromoService {
    func getPromos() -> AnyPublisher<PromoDataResponse, Error>
}

class PromoAPI: BaseAPI, PromoService {
    func getPromos() -> AnyPublisher<PromoDataResponse, Error> {
        return request(.get, path: "/promos")
    }
}

public struct PromoDataResponse: Codable {
    public let promos: [PromoResponse]
}

public struct PromoResponse: Codable {
    public let id: Int?
    public let name: String?
    public let imageUrlString: String?
    public let detailUrlString: String?
    
    public init(id: Int?, name: String?, imageUrlString: String?, detailUrlString: String?) {
        self.id = id
        self.name = name
        self.imageUrlString = imageUrlString
        self.detailUrlString = detailUrlString
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrlString = "images_url"
        case detailUrlString = "detail"
    }
}
/*
 {
     "promos": [
         {
             "id": 1,
             "name": "BNI Mobile Banking",
             "images_url": "https://www.bni.co.id/Portals/1/BNI/Beranda/Images/Beranda-MobileBanking-01-M-Banking1.png",
             "detail": "https://www.bni.co.id/id-id/individu/simulasi/bni-deposito"
         },
         {
             "id": 2,
             "name": "BNI Wholesale",
             "images_url": "https://bit.ly/MarcommBNIFleksi-2023",
             "detail": "https://www.bni.co.id/id-id/korporasi/solusi-wholesale/tentang-kami"
         }
     ]
 }

 */
