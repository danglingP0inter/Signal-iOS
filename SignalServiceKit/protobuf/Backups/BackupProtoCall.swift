//
// Copyright 2024 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

// Code generated by Wire protocol buffer compiler, do not edit.
// Source: BackupProto.BackupProtoCall in Backup.proto
import Wire

public struct BackupProtoCall {

    public var callId: UInt64
    public var conversationRecipientId: UInt64
    @ProtoDefaulted
    public var type: BackupProtoCall.BackupProtoType?
    public var outgoing: Bool
    public var timestamp: UInt64
    @ProtoDefaulted
    public var ringerRecipientId: UInt64?
    @ProtoDefaulted
    public var event: BackupProtoCall.BackupProtoEvent?
    public var unknownFields: UnknownFields = .init()

    public init(
        callId: UInt64,
        conversationRecipientId: UInt64,
        outgoing: Bool,
        timestamp: UInt64,
        configure: (inout Self) -> Swift.Void = { _ in }
    ) {
        self.callId = callId
        self.conversationRecipientId = conversationRecipientId
        self.outgoing = outgoing
        self.timestamp = timestamp
        configure(&self)
    }

}

#if !WIRE_REMOVE_EQUATABLE
extension BackupProtoCall : Equatable {
}
#endif

#if !WIRE_REMOVE_HASHABLE
extension BackupProtoCall : Hashable {
}
#endif

extension BackupProtoCall : Sendable {
}

extension BackupProtoCall : ProtoMessage {

    public static func protoMessageTypeURL() -> String {
        return "type.googleapis.com/BackupProto.BackupProtoCall"
    }

}

extension BackupProtoCall : Proto3Codable {

    public init(from protoReader: ProtoReader) throws {
        var callId: UInt64 = 0
        var conversationRecipientId: UInt64 = 0
        var type: BackupProtoCall.BackupProtoType? = nil
        var outgoing: Bool = false
        var timestamp: UInt64 = 0
        var ringerRecipientId: UInt64? = nil
        var event: BackupProtoCall.BackupProtoEvent? = nil

        let token = try protoReader.beginMessage()
        while let tag = try protoReader.nextTag(token: token) {
            switch tag {
            case 1: callId = try protoReader.decode(UInt64.self)
            case 2: conversationRecipientId = try protoReader.decode(UInt64.self)
            case 3: type = try protoReader.decode(BackupProtoCall.BackupProtoType.self)
            case 4: outgoing = try protoReader.decode(Bool.self)
            case 5: timestamp = try protoReader.decode(UInt64.self)
            case 6: ringerRecipientId = try protoReader.decode(UInt64.self)
            case 7: event = try protoReader.decode(BackupProtoCall.BackupProtoEvent.self)
            default: try protoReader.readUnknownField(tag: tag)
            }
        }
        self.unknownFields = try protoReader.endMessage(token: token)

        self.callId = callId
        self.conversationRecipientId = conversationRecipientId
        self._type.wrappedValue = try BackupProtoCall.BackupProtoType.defaultIfMissing(type)
        self.outgoing = outgoing
        self.timestamp = timestamp
        self._ringerRecipientId.wrappedValue = ringerRecipientId
        self._event.wrappedValue = try BackupProtoCall.BackupProtoEvent.defaultIfMissing(event)
    }

    public func encode(to protoWriter: ProtoWriter) throws {
        try protoWriter.encode(tag: 1, value: self.callId)
        try protoWriter.encode(tag: 2, value: self.conversationRecipientId)
        try protoWriter.encode(tag: 3, value: self.type)
        try protoWriter.encode(tag: 4, value: self.outgoing)
        try protoWriter.encode(tag: 5, value: self.timestamp)
        try protoWriter.encode(tag: 6, value: self.ringerRecipientId)
        try protoWriter.encode(tag: 7, value: self.event)
        try protoWriter.writeUnknownFields(unknownFields)
    }

}

#if !WIRE_REMOVE_CODABLE
extension BackupProtoCall : Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringLiteralCodingKeys.self)
        self.callId = try container.decode(stringEncoded: UInt64.self, forKey: "callId")
        self.conversationRecipientId = try container.decode(stringEncoded: UInt64.self, forKey: "conversationRecipientId")
        self._type.wrappedValue = try container.decodeIfPresent(BackupProtoCall.BackupProtoType.self, forKey: "type")
        self.outgoing = try container.decode(Bool.self, forKey: "outgoing")
        self.timestamp = try container.decode(stringEncoded: UInt64.self, forKey: "timestamp")
        self._ringerRecipientId.wrappedValue = try container.decodeIfPresent(stringEncoded: UInt64.self, forKey: "ringerRecipientId")
        self._event.wrappedValue = try container.decodeIfPresent(BackupProtoCall.BackupProtoEvent.self, forKey: "event")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringLiteralCodingKeys.self)
        let includeDefaults = encoder.protoDefaultValuesEncodingStrategy == .include

        if includeDefaults || self.callId != 0 {
            try container.encode(stringEncoded: self.callId, forKey: "callId")
        }
        if includeDefaults || self.conversationRecipientId != 0 {
            try container.encode(stringEncoded: self.conversationRecipientId, forKey: "conversationRecipientId")
        }
        try container.encodeIfPresent(self.type, forKey: "type")
        if includeDefaults || self.outgoing != false {
            try container.encode(self.outgoing, forKey: "outgoing")
        }
        if includeDefaults || self.timestamp != 0 {
            try container.encode(stringEncoded: self.timestamp, forKey: "timestamp")
        }
        try container.encodeIfPresent(stringEncoded: self.ringerRecipientId, forKey: "ringerRecipientId")
        try container.encodeIfPresent(self.event, forKey: "event")
    }

}
#endif

/**
 * Subtypes within BackupProtoCall
 */
extension BackupProtoCall {

    public enum BackupProtoType : Int32, CaseIterable, ProtoEnum, ProtoDefaultedValue {

        case UNKNOWN_TYPE = 0
        case AUDIO_CALL = 1
        case VIDEO_CALL = 2
        case GROUP_CALL = 3
        case AD_HOC_CALL = 4

        public static var defaultedValue: BackupProtoCall.BackupProtoType {
            BackupProtoCall.BackupProtoType.UNKNOWN_TYPE
        }
        public var description: String {
            switch self {
            case .UNKNOWN_TYPE: return "UNKNOWN_TYPE"
            case .AUDIO_CALL: return "AUDIO_CALL"
            case .VIDEO_CALL: return "VIDEO_CALL"
            case .GROUP_CALL: return "GROUP_CALL"
            case .AD_HOC_CALL: return "AD_HOC_CALL"
            }
        }

    }

    public enum BackupProtoEvent : Int32, CaseIterable, ProtoEnum, ProtoDefaultedValue {

        case UNKNOWN_EVENT = 0
        /**
         * 1:1 calls only
         */
        case OUTGOING = 1
        /**
         * 1:1 and group calls. Group calls: You accepted a ring.
         */
        case ACCEPTED = 2
        /**
         * 1:1 calls only,
         */
        case NOT_ACCEPTED = 3
        /**
         * 1:1 and group. Group calls: The remote ring has expired or was cancelled by the ringer.
         */
        case MISSED = 4
        /**
         * 1:1 and Group/Ad-Hoc Calls.
         */
        case DELETE = 5
        /**
         * Group/Ad-Hoc Calls only. Initial state
         */
        case GENERIC_GROUP_CALL = 6
        /**
         * Group Calls: User has joined the group call.
         */
        case JOINED = 7
        /**
         * Group Calls: If you declined a ring.
         */
        case DECLINED = 8
        /**
         * Group Calls: If you are ringing a group.
         */
        case OUTGOING_RING = 9

        public static var defaultedValue: BackupProtoCall.BackupProtoEvent {
            BackupProtoCall.BackupProtoEvent.UNKNOWN_EVENT
        }
        public var description: String {
            switch self {
            case .UNKNOWN_EVENT: return "UNKNOWN_EVENT"
            case .OUTGOING: return "OUTGOING"
            case .ACCEPTED: return "ACCEPTED"
            case .NOT_ACCEPTED: return "NOT_ACCEPTED"
            case .MISSED: return "MISSED"
            case .DELETE: return "DELETE"
            case .GENERIC_GROUP_CALL: return "GENERIC_GROUP_CALL"
            case .JOINED: return "JOINED"
            case .DECLINED: return "DECLINED"
            case .OUTGOING_RING: return "OUTGOING_RING"
            }
        }

    }

}

extension BackupProtoCall.BackupProtoType : Sendable {
}

extension BackupProtoCall.BackupProtoEvent : Sendable {
}
