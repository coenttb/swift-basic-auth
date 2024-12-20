//
//  File.swift
//  swift-basic-auth
//
//  Created by Coen ten Thije Boonkkamp on 20/12/2024.
//

import Foundation
import URLRouting

extension BasicAuth {
    public struct Router: ParserPrinter {
        
        public var body: some URLRouting.Router<BasicAuth> {
            Parse(.memberwise(BasicAuth.init)) {
                Headers {
                    Field("Authorization") {
                        "Basic "
                        Parse(.string)
                            .map(
                                .convert(
                                    apply: { (base64String: String) -> (String, String)? in
                                        guard
                                            let data = Data(base64Encoded: base64String),
                                            let decoded = String(data: data, encoding: .utf8)
                                        else {
                                            return nil
                                        }
                                        let components = decoded.split(separator: ":", maxSplits: 1)
                                        guard components.count == 2 else {
                                            return nil
                                        }
                                        return (String(components[0]), String(components[1]))
                                    },
                                    unapply: { (username, password) -> String in
                                        let combined = "\(username):\(password)"
                                        return Data(combined.utf8).base64EncodedString()
                                    }
                                )
                            )
                    }
                }
            }
        }
    }
}
