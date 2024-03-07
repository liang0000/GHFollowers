//


import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String? // if optional of changeable then must var
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
}
