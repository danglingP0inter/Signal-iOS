//
// Copyright 2024 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

// Code generated by Wire protocol buffer compiler, do not edit.
// Source: BackupProto.BackupProtoExpirationTimerChatUpdate in Backup.proto
import Wire

/**
 * For 1:1 chat updates only.
 * For group thread updates use GroupExpirationTimerUpdate.
 */
public struct BackupProtoExpirationTimerChatUpdate {

    /**
     * 0 means the expiration timer was disabled
     */
    public var expiresInMs: UInt32
    public var unknownFields: UnknownFields = .init()

    public init(expiresInMs: UInt32) {
        self.expiresInMs = expiresInMs
    }

}

#if !WIRE_REMOVE_EQUATABLE
extension BackupProtoExpirationTimerChatUpdate : Equatable {
}
#endif

#if !WIRE_REMOVE_HASHABLE
extension BackupProtoExpirationTimerChatUpdate : Hashable {
}
#endif

extension BackupProtoExpirationTimerChatUpdate : Sendable {
}

extension BackupProtoExpirationTimerChatUpdate : ProtoMessage {

    public static func protoMessageTypeURL() -> String {
        return "type.googleapis.com/BackupProto.BackupProtoExpirationTimerChatUpdate"
    }

}

extension BackupProtoExpirationTimerChatUpdate : Proto3Codable {

    public init(from protoReader: ProtoReader) throws {
        var expiresInMs: UInt32 = 0

        let token = try protoReader.beginMessage()
        while let tag = try protoReader.nextTag(token: token) {
            switch tag {
            case 1: expiresInMs = try protoReader.decode(UInt32.self)
            default: try protoReader.readUnknownField(tag: tag)
            }
        }
        self.unknownFields = try protoReader.endMessage(token: token)

        self.expiresInMs = expiresInMs
    }

    public func encode(to protoWriter: ProtoWriter) throws {
        try protoWriter.encode(tag: 1, value: self.expiresInMs)
        try protoWriter.writeUnknownFields(unknownFields)
    }

}

#if !WIRE_REMOVE_CODABLE
extension BackupProtoExpirationTimerChatUpdate : Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringLiteralCodingKeys.self)
        self.expiresInMs = try container.decode(UInt32.self, forKey: "expiresInMs")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringLiteralCodingKeys.self)
        let includeDefaults = encoder.protoDefaultValuesEncodingStrategy == .include

        if includeDefaults || self.expiresInMs != 0 {
            try container.encode(self.expiresInMs, forKey: "expiresInMs")
        }
    }

}
#endif
