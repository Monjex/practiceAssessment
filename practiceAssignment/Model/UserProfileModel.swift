//
//  UserProfileModel.swift
//  practiceAssignment
//
//  Created by HIGH ETHICS on 02/07/25.
//

import Foundation

// MARK: - Root Response
struct UserProfileResponse: Codable {
    let invites: Invites
    let likes: Likes
}

// MARK: - Invites
struct Invites: Codable {
    let profiles: [InvitedProfile]
    let totalPages: Int
    let pending_invitations_count: Int
}

// MARK: - Invited Profile
struct InvitedProfile: Codable {
    let general_information: GeneralInformation
    let approved_time: Double
    let disapproved_time: Double
    let photos: [Photo]
    let user_interests: [String]?
    let work: Work?
    let preferences: [Preference]
    let instagram_images: String?
    let last_seen_window: String?
    let is_facebook_data_fetched: Bool
    let icebreakers: String?
    let story: String?
    let meetup: String?
    let verification_status: String
    let has_active_subscription: Bool
    let show_concierge_badge: Bool
    let lat: Double
    let lng: Double
    let lastSeen: String?
    let online_code: Int
    let profile_data_list: [ProfileData]
}

// MARK: - General Information
struct GeneralInformation: Codable {
    let date_of_birth: String
    let date_of_birth_v1: String
    let location: Location
    let drinking_v1: NamedEntity?
    let first_name: String
    let gender: String
    let marital_status_v1: NamedEntity?
    let ref_id: String
    let smoking_v1: NamedEntity?
    let sun_sign_v1: NamedEntity?
    let mother_tongue: NamedEntity?
    let faith: NamedEntity?
    let height: Int
    let cast, kid, diet, politics, pet, settle, mbti: String?
    let age: Int
}

// MARK: - Location
struct Location: Codable {
    let summary: String
    let full: String
}

// MARK: - Named Entity (Used for nested objects like faith, drinking, etc.)
struct NamedEntity: Codable {
    let id: Int
    let name: String
    let name_alias: String?
    let preference_only: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name
        case name_alias = "name_alias"
        case preference_only = "preference_only"
    }
}

// MARK: - Photo
struct Photo: Codable {
    let photo: String
    let photo_id: Int
    let selected: Bool
    let status: String?
}

// MARK: - Work
struct Work: Codable {
    let industry_v1: NamedEntity?
    let monthly_income_v1: String?
    let experience_v1: NamedEntity?
    let highest_qualification_v1: NamedEntity?
    let field_of_study_v1: NamedEntity?
}

// MARK: - Preference
struct Preference: Codable {
    let answer_id: Int
    let id: Int
    let value: Int
    let preference_question: PreferenceQuestion
}

// MARK: - Preference Question
struct PreferenceQuestion: Codable {
    let first_choice: String
    let second_choice: String
}

// MARK: - Profile Data
struct ProfileData: Codable {
    let question: String
    let preferences: [ProfilePreference]
    let invitation_type: String
}

// MARK: - Profile Preference
struct ProfilePreference: Codable {
    let answer_id: Int
    let answer: String
    let first_choice: String
    let second_choice: String
}

// MARK: - Likes
struct Likes: Codable {
    let profiles: [LikeProfile]
    let can_see_profile: Bool
    let likes_received_count: Int
}

// MARK: - Like Profile
struct LikeProfile: Codable {
    let first_name: String
    let avatar: String
}
