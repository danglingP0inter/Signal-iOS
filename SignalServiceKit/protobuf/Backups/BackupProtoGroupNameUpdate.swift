//
// Copyright 2024 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

// Code generated by Wire protocol buffer compiler, do not edit.
// Source: BackupProto.BackupProtoGroupNameUpdate in Backup.proto
import Foundation
import Wire

public struct BackupProtoGroupNameUpdate {

    @ProtoDefaulted
    public var updaterAci: Foundation.Data?
    /**
     * Null value means the group name was removed.
     */
    @ProtoDefaulted
    public var newGroupName: String?
    public var unknownFields: UnknownFields = .init()

    public init(configure: (inout Self) -> Swift.Void = { _ in }) {
        configure(&self)
    }

}

#if !WIRE_REMOVE_EQUATABLE
extension BackupProtoGroupNameUpdate : Equatable {
}
#endif

#if !WIRE_REMOVE_HASHABLE
extension BackupProtoGroupNameUpdate : Hashable {
}
#endif

extension BackupProtoGroupNameUpdate : Sendable {
}

extension BackupProtoGroupNameUpdate : ProtoDefaultedValue {

    public static var defaultedValue: BackupProtoGroupNameUpdate {
        BackupProtoGroupNameUpdate()
    }
}

extension BackupProtoGroupNameUpdate : ProtoMessage {

    public static func protoMessageTypeURL() -> String {
        return "type.googleapis.com/BackupProto.BackupProtoGroupNameUpdate"
    }

}

extension BackupProtoGroupNameUpdate : Proto3Codable {

    public init(from protoReader: ProtoReader) throws {
        var updaterAci: Foundation.Data? = nil
        var newGroupName: String? = nil

        let token = try protoReader.beginMessage()
        while let tag = try protoReader.nextTag(token: token) {
            switch tag {
            case 1: updaterAci = try protoReader.decode(Foundation.Data.self)
            case 2: newGroupName = try protoReader.decode(String.self)
            default: try protoReader.readUnknownField(tag: tag)
            }
        }
        self.unknownFields = try protoReader.endMessage(token: token)

        self._updaterAci.wrappedValue = updaterAci
        self._newGroupName.wrappedValue = newGroupName
    }

    public func encode(to protoWriter: ProtoWriter) throws {
        try protoWriter.encode(tag: 1, value: self.updaterAci)
        try protoWriter.encode(tag: 2, value: self.newGroupName)
        try protoWriter.writeUnknownFields(unknownFields)
    }

}

#if !WIRE_REMOVE_CODABLE
extension BackupProtoGroupNameUpdate : Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringLiteralCodingKeys.self)
        self._updaterAci.wrappedValue = try container.decodeIfPresent(stringEncoded: Foundation.Data.self, forKey: "updaterAci")
        self._newGroupName.wrappedValue = try container.decodeIfPresent(String.self, forKey: "newGroupName")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringLiteralCodingKeys.self)

        try container.encodeIfPresent(stringEncoded: self.updaterAci, forKey: "updaterAci")
        try container.encodeIfPresent(self.newGroupName, forKey: "newGroupName")
    }

}
#endif
