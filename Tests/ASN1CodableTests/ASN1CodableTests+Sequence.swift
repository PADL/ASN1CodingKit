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

import XCTest
import ASN1Codable

/*
 PersonnelRecord ::= SEQUENCE {
         name     OCTET STRING,
         location INTEGER { homeOffice(0),
                            fieldOffice(1),
                            roving(2)},
         age      INTEGER OPTIONAL
 }
 */

struct PersonnelRecord: Codable, Equatable {
    var name: Data
    var location: Int
    var age: Int?
}

extension ASN1CodableTests {
    func test_encode_PersonnelRecord() {
        self.test_encode(PersonnelRecord(name: Data([0x62, 0x69, 0x67, 0x20, 0x68, 0x65, 0x61, 0x64]),
                                         location: 2,
                                         age: 26),
                         encodedAs: Data([0x30, 0x10, 0x04, 0x08, 0x62, 0x69, 0x67, 0x20, 0x68, 0x65, 0x61, 0x64,
                                          0x02, 0x01, 0x02, 0x02, 0x01, 0x1A]))
    }
    func test_encode_SEQUENCE() {
        test_encode_PersonnelRecord()
    }

}

//        self.test_encode(Color.blue, encodedAs: Data([0x0A, 0x01, 0x01]))

