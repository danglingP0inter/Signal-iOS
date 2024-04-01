//
// Copyright 2024 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

// Code generated by Wire protocol buffer compiler, do not edit.
// Source: BackupProto.BackupProtoRemoteDeletedMessage in Backup.proto
import Wire

/**
 * Tombstone for remote delete
 */
public struct BackupProtoRemoteDeletedMessage {

    public var unknownFields: UnknownFields = .init()

    public init() {
    }

}

#if !WIRE_REMOVE_EQUATABLE
extension BackupProtoRemoteDeletedMessage : Equatable {
}
#endif

#if !WIRE_REMOVE_HASHABLE
extension BackupProtoRemoteDeletedMessage : Hashable {
}
#endif

extension BackupProtoRemoteDeletedMessage : Sendable {
}

extension BackupProtoRemoteDeletedMessage : ProtoDefaultedValue {

    public static var defaultedValue: BackupProtoRemoteDeletedMessage {
        BackupProtoRemoteDeletedMessage()
    }
}

extension BackupProtoRemoteDeletedMessage : ProtoMessage {

    public static func protoMessageTypeURL() -> String {
        return "type.googleapis.com/BackupProto.BackupProtoRemoteDeletedMessage"
    }

}

extension BackupProtoRemoteDeletedMessage : Proto3Codable {

    public init(from protoReader: ProtoReader) throws {
        let token = try protoReader.beginMessage()
        while let tag = try protoReader.nextTag(token: token) {
            switch tag {
            default: try protoReader.readUnknownField(tag: tag)
            }
        }
        self.unknownFields = try protoReader.endMessage(token: token)

    }

    public func encode(to protoWriter: ProtoWriter) throws {
        try protoWriter.writeUnknownFields(unknownFields)
    }

}

#if !WIRE_REMOVE_CODABLE
extension BackupProtoRemoteDeletedMessage : Codable {

    public enum CodingKeys : CodingKey {
    }

}
#endif
