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
import ASN1Kit

public protocol ASN1TaggedTypeRepresentable {
    static var tag: ASN1DecodedTag? { get }
    static var tagging: ASN1Tagging? { get }
    static var metatype: ASN1Metatype { get }
}

public extension ASN1TaggedTypeRepresentable {
    static var tag: ASN1DecodedTag? { return nil }
    static var tagging: ASN1Tagging? { return nil }
    static var metatype: ASN1Metatype { return ASN1TagMetatype(tag: self.tag, tagging: self.tagging) }
}
