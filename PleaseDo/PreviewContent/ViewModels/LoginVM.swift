//
//  LoginVM.swift
//  PleaseDo
//
//  Created by R K on 3/21/24.
//

import Foundation
import Observation

@Observable final class LoginVM {
    enum Status {
        case unknown, loggedIn, loggedOut
    }
    
    var loginStatus: Status = .unknown
}
