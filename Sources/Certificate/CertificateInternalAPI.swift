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
import Network
import ASN1Codable

@_cdecl("CertificateCopyDescriptionsFromSAN")
public func CertificateCopyDescriptionsFromSAN(_ certificate: CertificateRef) -> CFArray?
{
    guard let certificate = Certificate._fromCertificateRef(certificate) else { return nil }
    guard let names = certificate.subjectAltName?.map({ $0.description }), names.count != 0 else {
        return nil
    }
    return names as CFArray
}

@_cdecl("CertificateCopyReencoded")
public func CertificateCopyReencoded(_ certificate: CertificateRef) -> CFData?
{
    let certificate = Certificate._fromCertificateRef(certificate)!
    let asn1Encoder = ASN1Encoder()
    
    do {
        let encoded = try asn1Encoder.encode(certificate)
        
        return encoded as CFData
    } catch {
        return nil
    }
}

@_cdecl("CertificateCopyJSONDescription")
public func CertificateCopyJSONDescription(_ certificate: CertificateRef) -> CFString?
{
    guard let certificate = Certificate._fromCertificateRef(certificate) else { return nil }

    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = .prettyPrinted
    
    do {
        let data = try jsonEncoder.encode(certificate)
        guard let string = String(data: data, encoding: .utf8) else { return nil }
        return string as CFString
    } catch {
    }
    
    return nil
}
