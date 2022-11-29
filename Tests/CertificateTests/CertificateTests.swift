//
//  CertificateTests.swift
//  CertificateTests
//
//  Created by Luke Howard on 22/11/2022.
//

import XCTest

final class CertificateTests: XCTestCase {
    func base64ToCertificate(_ base64: String) -> CertificateRef? {
        guard let data = Data(base64Encoded: base64,
                              options: .ignoreUnknownCharacters) else {
            return nil
        }

        return CertificateCreateWithData(kCFAllocatorDefault, data as CFData)
    }

    func test_certificate_j() {
        let cert = self.base64ToCertificate(certificate_j)

        XCTAssertNotNil(cert)
        guard let cert else { return }

        let cns = CertificateCopyCommonNames(cert)
        XCTAssertNil(cns)

        let data = CertificateCopySerialNumberData(cert, nil)
        XCTAssertNotNil(data)
        guard let data else { return }

        XCTAssertEqual(data as Data, Data([0x02, 0x01, 0x01]))
    }
}

let certificate_j = """
MIIEajCCA1KgAwIBAgIBATANBgkqhkiG9w0BAQUFADBaMQswCQYDVQQGEwJKUDEN
MAsGA1UECgwESlBLSTEpMCcGA1UECwwgUHJlZmVjdHVyYWwgQXNzb2NpYXRpb24g
Rm9yIEpQS0kxETAPBgNVBAsMCEJyaWRnZUNBMB4XDTAzMTIyNzA1MDgxNVoXDTEz
MTIyNjE0NTk1OVowWjELMAkGA1UEBhMCSlAxDTALBgNVBAoMBEpQS0kxKTAnBgNV
BAsMIFByZWZlY3R1cmFsIEFzc29jaWF0aW9uIEZvciBKUEtJMREwDwYDVQQLDAhC
cmlkZ2VDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANTnUmg7K3m8
52vd77kwkq156euwoWm5no8E8kmaTSc7x2RABPpqNTlMKdZ6ttsyYrqREeDkcvPL
yF7yf/I8+innasNtsytcTAy8xY8Avsbd4JkCGW9dyPjk9pzzc3yLQ64Rx2fujRn2
agcEVdPCr/XpJygX8FD5bbhkZ0CVoiASBmlHOcC3YpFlfbT1QcpOSOb7o+VdKVEi
MMfbBuU2IlYIaSr/R1nO7RPNtkqkFWJ1/nKjKHyzZje7j70qSxb+BTGcNgTHa1YA
UrogKB+UpBftmb4ds+XlkEJ1dvwokiSbCDaWFKD+YD4B2s0bvjCbw8xuZFYGhNyR
/2D5XfN1s2MCAwEAAaOCATkwggE1MA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MG0GA1UdHwRmMGQwYqBgoF6kXDBaMQswCQYDVQQGEwJKUDENMAsGA1UE
CgwESlBLSTEpMCcGA1UECwwgUHJlZmVjdHVyYWwgQXNzb2NpYXRpb24gRm9yIEpQ
S0kxETAPBgNVBAsMCEJyaWRnZUNBMIGDBgNVHREEfDB6pHgwdjELMAkGA1UEBhMC
SlAxJzAlBgNVBAoMHuWFrOeahOWAi+S6uuiqjeiovOOCteODvOODk+OCuTEeMBwG
A1UECwwV6YO96YGT5bqc55yM5Y2U6K2w5LyaMR4wHAYDVQQLDBXjg5bjg6rjg4Pj
grjoqo3oqLzlsYAwHQYDVR0OBBYEFNQXMiCqQNkR2OaZmQgLtf8mR8p8MA0GCSqG
SIb3DQEBBQUAA4IBAQATjJo4reTNPC5CsvAKu1RYT8PyXFVYHbKsEpGt4GR8pDCg
HEGAiAhHSNrGh9CagZMXADvlG0gmMOnXowriQQixrtpkmx0TB8tNAlZptZWkZC+R
8TnjOkHrk2nFAEC3ezbdK0R7MR4tJLDQCnhEWbg50rf0wZ/aF8uAaVeEtHXa6W0M
Xq3dSe0XAcrLbX4zZHQTaWvdpLAIjl6DZ3SCieRMyoWUL+LXaLFdTP5WBCd+No58
IounD9X4xxze2aeRVaiV/WnQ0OSPNS7n7YXy6xQdnaOU4KRW/Lne1EDf5IfWC/ih
bVAmhZMbcrkWWcsR6aCPG+2mV3zTD6AUzuKPal8Y
"""
