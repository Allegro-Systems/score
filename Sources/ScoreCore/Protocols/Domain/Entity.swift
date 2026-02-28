import Foundation

/// A protocol that represents a persistent, identifiable domain model.
///
/// `Entity` is the foundational type for any data model that participates in
/// Score's persistence and serialisation layers. Every conforming type is
/// guaranteed to be uniquely identifiable by a `UUID`, serialisable through
/// `Codable`, and safe to pass across concurrency domains via `Sendable`.
///
/// By fixing `ID` to `UUID`, Score ensures that entity identifiers are
/// globally unique and suitable for use in databases, REST APIs, and
/// in-memory caches without additional coordination.
///
/// Typical uses include:
/// - Modelling database rows fetched, inserted, or updated via `ScoreDB`
/// - Representing API response payloads decoded from JSON
/// - Passing domain objects across async task boundaries safely
///
/// ### Example
///
/// ```swift
/// struct User: Entity {
///     let id: UUID
///     let username: String
///     let email: String
/// }
///
/// struct Post: Entity {
///     let id: UUID
///     let authorID: UUID
///     let title: String
///     let body: String
/// }
/// ```
///
/// ### Protocol Conformance Requirements
///
/// A type conforming to `Entity` must:
/// - Provide a stored or computed `id` property of type `UUID`
///   (inherited from `Identifiable`).
/// - Implement `Codable` synthesis or custom `encode(to:)` / `init(from:)`.
/// - Satisfy `Sendable`, typically by ensuring all stored properties are
///   themselves `Sendable`.
///
/// - Note: Because `ID` is constrained to `UUID`, conforming types must not
///   redeclare `ID` with a different type.
public protocol Entity: Codable, Sendable, Identifiable where ID == UUID {}
