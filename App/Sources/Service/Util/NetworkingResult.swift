import Foundation

enum NetworkingResult: Int {
    case OK = 200
    case CREATED = 201
    case NOCONTENT = 204
    case BADREQUEST = 400
    case UNAUTHORIZED = 401
    case NOTFOUND = 404
    case INTERNALSERVERERROR = 500
    case DEFAULT = 0
}
