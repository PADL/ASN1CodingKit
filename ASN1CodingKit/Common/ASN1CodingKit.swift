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

@_exported import ASN1Kit

// FIXME remove when decoder completed

public func __ASN1DumpEncodedData(_ data: Data) {
    do {
        let asn1 = try ASN1Kit.ASN1Decoder.decode(asn1: data)
        print("ASN.1: \(asn1)")
    } catch {
        print("Error \(error)")
    }
}
