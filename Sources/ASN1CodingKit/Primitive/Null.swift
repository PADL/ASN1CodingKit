//
// Copyright (c) 2022 PADL Software Pty Ltd
//
// Licensed under the Apache License, Version 2.0 (the License);
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an 'AS IS' BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

public struct Null {
}

extension Null: ASN1DecodableType, Codable {
    public init(from asn1: ASN1Object) throws {
        guard asn1.tag == .universal(.null) else {
            throw ASN1Error.malformedEncoding("ASN.1 object has incorret tag \(asn1.tag)")
        }
    }
}

extension Null: ASN1EncodableType {
    public func asn1encode(tag: ASN1DecodedTag?) throws -> ASN1Object {
        return ASN1NullObject
    }
}

extension Null: ASN1UniversalTagRepresentable {
    static var tagNo: ASN1Tag { return .null }
}