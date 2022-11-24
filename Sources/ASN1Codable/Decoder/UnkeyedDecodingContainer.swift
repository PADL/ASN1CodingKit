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

extension ASN1DecoderImpl {
    final class UnkeyedContainer: ASN1DecodingContainer {
        private var containers: [ASN1DecodingContainer] = []

        var object: ASN1Object
        var codingPath: [CodingKey]
        var userInfo: [CodingUserInfoKey: Any]
        var context: ASN1DecodingContext

        var currentIndex: Int = 0

        init(object: ASN1Object,
             codingPath: [CodingKey],
             userInfo: [CodingUserInfoKey : Any],
             context: ASN1DecodingContext) throws {
            // there's no point sorting SET OF on decode because the Swift type is unordered
            self.object = object
            self.codingPath = codingPath
            self.userInfo = userInfo
            self.context = context
        }

        struct Index: CodingKey {
            var stringValue: String {
                return "\(self.intValue!)"
            }

            var intValue: Int?

            init?(stringValue: String) {
                return nil
            }

            init?(intValue: Int) {
                self.intValue = intValue
            }
        }

        var nestedCodingPath: [CodingKey] {
            return self.codingPath + [Index(intValue: self.currentIndex)!]
        }
    }
}

extension ASN1DecoderImpl.UnkeyedContainer: UnkeyedDecodingContainer {
    func decodeNil() throws -> Bool {
        let container = self.nestedSingleValueContainer(try self.currentObject(), context: self.context)
        let isNil = container.decodeNil()

        if isNil {
            self.addContainer(container)
        }

        return isNil
    }

    func decodeIfPresent(_ type: Bool.Type) throws -> Bool? {
        return try self.decodeUnkeyedSingleValueIfPresent(type)
    }

    func decodeIfPresent(_ type: String.Type) throws -> String? {
        return try self.decodeUnkeyedSingleValueIfPresent(type)
    }

    func decodeIfPresent(_ type: Double.Type) throws -> Double? {
        return try self.decodeUnkeyedSingleValueIfPresent(type)
    }

    func decodeIfPresent(_ type: Float.Type) throws -> Float? {
        return try self.decodeUnkeyedSingleValueIfPresent(type)
    }

    func decodeIfPresent(_ type: Int.Type) throws -> Int? {
        return try self.decodeUnkeyedSingleValueIfPresent(type)
    }

    func decodeIfPresent(_ type: Int8.Type) throws -> Int8? {
        return try self.decodeUnkeyedSingleValueIfPresent(type)
    }

    func decodeIfPresent(_ type: Int16.Type) throws -> Int16? {
        return try self.decodeUnkeyedSingleValueIfPresent(type)
    }

    func decodeIfPresent(_ type: Int32.Type) throws -> Int32? {
        return try self.decodeUnkeyedSingleValueIfPresent(type)
    }

    func decodeIfPresent(_ type: Int64.Type) throws -> Int64? {
        return try self.decodeUnkeyedSingleValueIfPresent(type)
    }

    func decodeIfPresent(_ type: UInt.Type) throws -> UInt? {
        return try self.decodeUnkeyedSingleValueIfPresent(type)
    }

    func decodeIfPresent(_ type: UInt8.Type) throws -> UInt8? {
        return try self.decodeUnkeyedSingleValueIfPresent(type)
    }

    func decodeIfPresent(_ type: UInt16.Type) throws -> UInt16? {
        return try self.decodeUnkeyedSingleValueIfPresent(type)
    }

    func decodeIfPresent(_ type: UInt32.Type) throws -> UInt32? {
        return try self.decodeUnkeyedSingleValueIfPresent(type)
    }

    func decodeIfPresent(_ type: UInt64.Type) throws -> UInt64? {
        return try self.decodeUnkeyedSingleValueIfPresent(type)
    }

    func decodeIfPresent<T>(_ type: T.Type) throws -> T? where T : Decodable {
        return try self.decodeUnkeyedSingleValueIfPresent(type)
    }

    func decode(_ type: Bool.Type) throws -> Bool {
        return try self.decodeUnkeyedSingleValue(type)
    }

    func decode(_ type: String.Type) throws -> String {
        return try self.decodeUnkeyedSingleValue(type)
    }

    func decode(_ type: Double.Type) throws -> Double {
        return try self.decodeUnkeyedSingleValue(type)
    }

    func decode(_ type: Float.Type) throws -> Float {
        return try self.decodeUnkeyedSingleValue(type)
    }

    func decode(_ type: Int.Type) throws -> Int {
        return try self.decodeUnkeyedSingleValue(type)
    }

    func decode(_ type: Int8.Type) throws -> Int8 {
        return try self.decodeUnkeyedSingleValue(type)
    }

    func decode(_ type: Int16.Type) throws -> Int16 {
        return try self.decodeUnkeyedSingleValue(type)
    }

    func decode(_ type: Int32.Type) throws -> Int32 {
        return try self.decodeUnkeyedSingleValue(type)
    }

    func decode(_ type: Int64.Type) throws -> Int64 {
        return try self.decodeUnkeyedSingleValue(type)
    }

    func decode(_ type: UInt.Type) throws -> UInt {
        return try self.decodeUnkeyedSingleValue(type)
    }

    func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try self.decodeUnkeyedSingleValue(type)
    }

    func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try self.decodeUnkeyedSingleValue(type)
    }

    func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try self.decodeUnkeyedSingleValue(type)
    }

    func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try self.decodeUnkeyedSingleValue(type)
    }

    func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        return try self.decodeUnkeyedSingleValue(type)
    }

    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        let container = try ASN1DecoderImpl.KeyedContainer<NestedKey>(object: try self.currentObject(nestedContainer: true),
                                                                      codingPath: self.nestedCodingPath,
                                                                      userInfo: self.userInfo,
                                                                      context: self.context.decodingNestedContainer())

        self.addContainer(container)

        return KeyedDecodingContainer(container)
    }

    func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        let container = try ASN1DecoderImpl.UnkeyedContainer(object: try self.currentObject(nestedContainer: true),
                                                             codingPath: self.nestedCodingPath,
                                                             userInfo: self.userInfo,
                                                             context: self.context.decodingNestedContainer())

        self.addContainer(container)

        return container
    }

    func superDecoder() throws -> Decoder {
        let context = DecodingError.Context(codingPath: self.codingPath,
                                            debugDescription: "ASN1DecoderImpl.UnkeyedContainer does not yet support super decoders")
        throw DecodingError.dataCorrupted(context)
    }
}

extension ASN1DecoderImpl.UnkeyedContainer {
    private func nestedSingleValueContainer(_ object: ASN1Object, context: ASN1DecodingContext) -> ASN1DecoderImpl.SingleValueContainer {
        let container = ASN1DecoderImpl.SingleValueContainer(object: object,
                                                             codingPath: self.nestedCodingPath,
                                                             userInfo: self.userInfo,
                                                             context: context)

        return container
    }

    private func addContainer(_ container: ASN1DecodingContainer) {
        self.containers.append(container)
        self.currentIndex += 1
    }

    private func decodeUnkeyedSingleValue<T>(_ type: T.Type) throws -> T where T : Decodable {
        let container = self.nestedSingleValueContainer(try self.currentObject(for: type),
                                                        context: self.context.decodingSingleValue(type))

        let value = try container.decode(type)

        if !ASN1DecoderImpl.isNilOrWrappedNil(value) {
            self.addContainer(container)
        }

        return value
    }

    private func decodeUnkeyedSingleValueIfPresent<T>(_ type: T.Type) throws -> T? where T : Decodable {
        let container = self.nestedSingleValueContainer(try self.currentObject(for: type),
                                                        context: self.context.decodingSingleValue(type))
        let value: T?

        if object.isNull {
            value = nil
        } else {
            do {
                value = try container.decode(type)
            } catch {
                if let error = error as? DecodingError, case .typeMismatch(_, _) = error {
                    return nil
                } else {
                    throw error
                }
            }
        }

        // value was explicit NULL or was successfully decoded
        self.addContainer(container)

        return value
    }
}
