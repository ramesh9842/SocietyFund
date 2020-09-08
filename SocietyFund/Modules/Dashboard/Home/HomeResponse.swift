//
//  HomeResponse.swift
//  SocietyFund
//
//  Created by sanish on 9/7/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import Foundation

struct HomeModel: Codable {
    var success: Bool?
    var data: [AllProjectData]?
}

struct AllProjectData: Codable {
    var category: String?
    var projects: [CategoricalProject]?
    var totalprojects: Int?
}

struct CategoricalProject: Codable {
    var status: Int?
    var projectId: Int?
    var projectLeader: String?
    var donor: [Donor]?
    var publishDate: String?
    var expiryDate: String?
    var goalAmount: Float?
    var raisedAmount: Float?
    var title: String?
    var images: ProjectImages?
    var projectOverview: ProjectOverview?
    var projectAbout: ProjectAbout?
    
    enum CodingKeys: String, CodingKey {
        case status
        case projectId = "project-id"
        case projectLeader = "project-leader"
        case donor
        case publishDate = "published-date"
        case expiryDate = "expiry-date"
        case goalAmount = "goal-amount"
        case raisedAmount = "raised-amount"
        case title
        case images
        case projectOverview = "project-overview"
        case projectAbout = "project-about"
    }
}

struct ProjectImages: Codable {
    var mainImg: String?
    var subImg: [String]?
    
    enum CodingKeys: String, CodingKey {
        case mainImg = "main-img"
        case subImg = "sub-img"
    }
}

struct ProjectAbout: Codable {
    var mission: String
    var vision: String?
    var result: String?
}

struct ProjectOverview: Codable {
    var problem: String?
    var solution: String?
    var output: String?
}

struct Donor: Codable {
    var name: String?
    var donatedAmount: Float?
    var email: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case donatedAmount = "donated-amount"
        case email
    }
}
