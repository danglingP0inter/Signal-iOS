//
// Copyright 2024 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

// Code generated by Wire protocol buffer compiler, do not edit.
// Source: BackupProto.BackupProtoGroupInvitationDeclinedUpdate in Backup.proto
import Foundation
import Wire

public struct BackupProtoGroupInvitationDeclinedUpdate {

    @ProtoDefaulted
    public var inviterAci: Foundation.Data?
    /**
     * Note: if invited by pni, just set inviteeAci to nil.
     */
    @ProtoDefaulted
    public var inviteeAci: Foundation.Data?
    public var unknownFields: UnknownFields = .init()

    public init(configure: (inout Self) -> Swift.Void = { _ in }) {
        configure(&self)
    }

}

#if !WIRE_REMOVE_EQUATABLE
extension BackupProtoGroupInvitationDeclinedUpdate : Equatable {
}
#endif

#if !WIRE_REMOVE_HASHABLE
extension BackupProtoGroupInvitationDeclinedUpdate : Hashable {
}
#endif

extension BackupProtoGroupInvitationDeclinedUpdate : Sendable {
}

extension BackupProtoGroupInvitationDeclinedUpdate : ProtoDefaultedValue {

    public static var defaultedValue: BackupProtoGroupInvitationDeclinedUpdate {
        BackupProtoGroupInvitationDeclinedUpdate()
    }
}

extension BackupProtoGroupInvitationDeclinedUpdate : ProtoMessage {

    public static func protoMessageTypeURL() -> String {
        return "type.googleapis.com/BackupProto.BackupProtoGroupInvitationDeclinedUpdate"
    }

}

extension BackupProtoGroupInvitationDeclinedUpdate : Proto3Codable {

    public init(from protoReader: ProtoReader) throws {
        var inviterAci: Foundation.Data? = nil
        var inviteeAci: Foundation.Data? = nil

        let token = try protoReader.beginMessage()
        while let tag = try protoReader.nextTag(token: token) {
            switch tag {
            case 1: inviterAci = try protoReader.decode(Foundation.Data.self)
            case 2: inviteeAci = try protoReader.decode(Foundation.Data.self)
            default: try protoReader.readUnknownField(tag: tag)
            }
        }
        self.unknownFields = try protoReader.endMessage(token: token)

        self._inviterAci.wrappedValue = inviterAci
        self._inviteeAci.wrappedValue = inviteeAci
    }

    public func encode(to protoWriter: ProtoWriter) throws {
        try protoWriter.encode(tag: 1, value: self.inviterAci)
        try protoWriter.encode(tag: 2, value: self.inviteeAci)
        try protoWriter.writeUnknownFields(unknownFields)
    }

}

#if !WIRE_REMOVE_CODABLE
extension BackupProtoGroupInvitationDeclinedUpdate : Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringLiteralCodingKeys.self)
        self._inviterAci.wrappedValue = try container.decodeIfPresent(stringEncoded: Foundation.Data.self, forKey: "inviterAci")
        self._inviteeAci.wrappedValue = try container.decodeIfPresent(stringEncoded: Foundation.Data.self, forKey: "inviteeAci")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringLiteralCodingKeys.self)

        try container.encodeIfPresent(stringEncoded: self.inviterAci, forKey: "inviterAci")
        try container.encodeIfPresent(stringEncoded: self.inviteeAci, forKey: "inviteeAci")
    }

}
#endif
