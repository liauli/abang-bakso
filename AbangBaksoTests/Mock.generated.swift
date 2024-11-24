// Generated using Sourcery 1.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.1.0
// Required Sourcery: 1.6.0


import SwiftyMocky
import XCTest
import Combine
import CoreLocation
import FirebaseDatabase
import FirebaseFirestore
import Foundation
@testable import AbangBakso


// MARK: - CreateUser

open class CreateUserMock: CreateUser, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func execute(user: User) -> AnyPublisher<Void, FirestoreError> {
        addInvocation(.m_execute__user_user(Parameter<User>.value(`user`)))
		let perform = methodPerformValue(.m_execute__user_user(Parameter<User>.value(`user`))) as? (User) -> Void
		perform?(`user`)
		var __value: AnyPublisher<Void, FirestoreError>
		do {
		    __value = try methodReturnValue(.m_execute__user_user(Parameter<User>.value(`user`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for execute(user: User). Use given")
			Failure("Stub return value not specified for execute(user: User). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_execute__user_user(Parameter<User>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_execute__user_user(let lhsUser), .m_execute__user_user(let rhsUser)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUser, rhs: rhsUser, with: matcher), lhsUser, rhsUser, "user"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_execute__user_user(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_execute__user_user: return ".execute(user:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func execute(user: Parameter<User>, willReturn: AnyPublisher<Void, FirestoreError>...) -> MethodStub {
            return Given(method: .m_execute__user_user(`user`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func execute(user: Parameter<User>, willProduce: (Stubber<AnyPublisher<Void, FirestoreError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, FirestoreError>] = []
			let given: Given = { return Given(method: .m_execute__user_user(`user`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, FirestoreError>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute(user: Parameter<User>) -> Verify { return Verify(method: .m_execute__user_user(`user`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(user: Parameter<User>, perform: @escaping (User) -> Void) -> Perform {
            return Perform(method: .m_execute__user_user(`user`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - DatabaseQueryCombine

open class DatabaseQueryCombineMock: DatabaseQueryCombine, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func observeValuePublisher() -> AnyPublisher<[[String: Any]], FirestoreError> {
        addInvocation(.m_observeValuePublisher)
		let perform = methodPerformValue(.m_observeValuePublisher) as? () -> Void
		perform?()
		var __value: AnyPublisher<[[String: Any]], FirestoreError>
		do {
		    __value = try methodReturnValue(.m_observeValuePublisher).casted()
		} catch {
			onFatalFailure("Stub return value not specified for observeValuePublisher(). Use given")
			Failure("Stub return value not specified for observeValuePublisher(). Use given")
		}
		return __value
    }

    open func addQueryEqual(toValue value: Any) -> DatabaseQueryCombine {
        addInvocation(.m_addQueryEqual__toValue_value(Parameter<Any>.value(`value`)))
		let perform = methodPerformValue(.m_addQueryEqual__toValue_value(Parameter<Any>.value(`value`))) as? (Any) -> Void
		perform?(`value`)
		var __value: DatabaseQueryCombine
		do {
		    __value = try methodReturnValue(.m_addQueryEqual__toValue_value(Parameter<Any>.value(`value`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for addQueryEqual(toValue value: Any). Use given")
			Failure("Stub return value not specified for addQueryEqual(toValue value: Any). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_observeValuePublisher
        case m_addQueryEqual__toValue_value(Parameter<Any>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_observeValuePublisher, .m_observeValuePublisher): return .match

            case (.m_addQueryEqual__toValue_value(let lhsValue), .m_addQueryEqual__toValue_value(let rhsValue)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsValue, rhs: rhsValue, with: matcher), lhsValue, rhsValue, "toValue value"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_observeValuePublisher: return 0
            case let .m_addQueryEqual__toValue_value(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_observeValuePublisher: return ".observeValuePublisher()"
            case .m_addQueryEqual__toValue_value: return ".addQueryEqual(toValue:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func observeValuePublisher(willReturn: AnyPublisher<[[String: Any]], FirestoreError>...) -> MethodStub {
            return Given(method: .m_observeValuePublisher, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func addQueryEqual(toValue value: Parameter<Any>, willReturn: DatabaseQueryCombine...) -> MethodStub {
            return Given(method: .m_addQueryEqual__toValue_value(`value`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func observeValuePublisher(willProduce: (Stubber<AnyPublisher<[[String: Any]], FirestoreError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<[[String: Any]], FirestoreError>] = []
			let given: Given = { return Given(method: .m_observeValuePublisher, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<[[String: Any]], FirestoreError>).self)
			willProduce(stubber)
			return given
        }
        public static func addQueryEqual(toValue value: Parameter<Any>, willProduce: (Stubber<DatabaseQueryCombine>) -> Void) -> MethodStub {
            let willReturn: [DatabaseQueryCombine] = []
			let given: Given = { return Given(method: .m_addQueryEqual__toValue_value(`value`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseQueryCombine).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func observeValuePublisher() -> Verify { return Verify(method: .m_observeValuePublisher)}
        public static func addQueryEqual(toValue value: Parameter<Any>) -> Verify { return Verify(method: .m_addQueryEqual__toValue_value(`value`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func observeValuePublisher(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_observeValuePublisher, performs: perform)
        }
        public static func addQueryEqual(toValue value: Parameter<Any>, perform: @escaping (Any) -> Void) -> Perform {
            return Perform(method: .m_addQueryEqual__toValue_value(`value`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - DatabaseReferenceCombine

open class DatabaseReferenceCombineMock: DatabaseReferenceCombine, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func addChild(_ path: String) -> DatabaseReferenceCombine {
        addInvocation(.m_addChild__path(Parameter<String>.value(`path`)))
		let perform = methodPerformValue(.m_addChild__path(Parameter<String>.value(`path`))) as? (String) -> Void
		perform?(`path`)
		var __value: DatabaseReferenceCombine
		do {
		    __value = try methodReturnValue(.m_addChild__path(Parameter<String>.value(`path`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for addChild(_ path: String). Use given")
			Failure("Stub return value not specified for addChild(_ path: String). Use given")
		}
		return __value
    }

    open func setValuePublisher(_ data: [String: Any]) -> AnyPublisher<Void, FirestoreError> {
        addInvocation(.m_setValuePublisher__data(Parameter<[String: Any]>.value(`data`)))
		let perform = methodPerformValue(.m_setValuePublisher__data(Parameter<[String: Any]>.value(`data`))) as? ([String: Any]) -> Void
		perform?(`data`)
		var __value: AnyPublisher<Void, FirestoreError>
		do {
		    __value = try methodReturnValue(.m_setValuePublisher__data(Parameter<[String: Any]>.value(`data`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for setValuePublisher(_ data: [String: Any]). Use given")
			Failure("Stub return value not specified for setValuePublisher(_ data: [String: Any]). Use given")
		}
		return __value
    }

    open func updateChildValuesPublisher(_ data: [String: Any]) -> AnyPublisher<Void, FirestoreError> {
        addInvocation(.m_updateChildValuesPublisher__data(Parameter<[String: Any]>.value(`data`)))
		let perform = methodPerformValue(.m_updateChildValuesPublisher__data(Parameter<[String: Any]>.value(`data`))) as? ([String: Any]) -> Void
		perform?(`data`)
		var __value: AnyPublisher<Void, FirestoreError>
		do {
		    __value = try methodReturnValue(.m_updateChildValuesPublisher__data(Parameter<[String: Any]>.value(`data`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for updateChildValuesPublisher(_ data: [String: Any]). Use given")
			Failure("Stub return value not specified for updateChildValuesPublisher(_ data: [String: Any]). Use given")
		}
		return __value
    }

    open func removeValuePublisher() -> AnyPublisher<Void, FirestoreError> {
        addInvocation(.m_removeValuePublisher)
		let perform = methodPerformValue(.m_removeValuePublisher) as? () -> Void
		perform?()
		var __value: AnyPublisher<Void, FirestoreError>
		do {
		    __value = try methodReturnValue(.m_removeValuePublisher).casted()
		} catch {
			onFatalFailure("Stub return value not specified for removeValuePublisher(). Use given")
			Failure("Stub return value not specified for removeValuePublisher(). Use given")
		}
		return __value
    }

    open func setupPresencePublisher(onlineValue: Any, offlineValue: Any) -> AnyPublisher<Void, FirestoreError> {
        addInvocation(.m_setupPresencePublisher__onlineValue_onlineValueofflineValue_offlineValue(Parameter<Any>.value(`onlineValue`), Parameter<Any>.value(`offlineValue`)))
		let perform = methodPerformValue(.m_setupPresencePublisher__onlineValue_onlineValueofflineValue_offlineValue(Parameter<Any>.value(`onlineValue`), Parameter<Any>.value(`offlineValue`))) as? (Any, Any) -> Void
		perform?(`onlineValue`, `offlineValue`)
		var __value: AnyPublisher<Void, FirestoreError>
		do {
		    __value = try methodReturnValue(.m_setupPresencePublisher__onlineValue_onlineValueofflineValue_offlineValue(Parameter<Any>.value(`onlineValue`), Parameter<Any>.value(`offlineValue`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for setupPresencePublisher(onlineValue: Any, offlineValue: Any). Use given")
			Failure("Stub return value not specified for setupPresencePublisher(onlineValue: Any, offlineValue: Any). Use given")
		}
		return __value
    }

    open func addQueryOrderedByKey() -> DatabaseQueryCombine {
        addInvocation(.m_addQueryOrderedByKey)
		let perform = methodPerformValue(.m_addQueryOrderedByKey) as? () -> Void
		perform?()
		var __value: DatabaseQueryCombine
		do {
		    __value = try methodReturnValue(.m_addQueryOrderedByKey).casted()
		} catch {
			onFatalFailure("Stub return value not specified for addQueryOrderedByKey(). Use given")
			Failure("Stub return value not specified for addQueryOrderedByKey(). Use given")
		}
		return __value
    }

    open func addQueryOrdered(byChild key: String) -> DatabaseQueryCombine {
        addInvocation(.m_addQueryOrdered__byChild_key(Parameter<String>.value(`key`)))
		let perform = methodPerformValue(.m_addQueryOrdered__byChild_key(Parameter<String>.value(`key`))) as? (String) -> Void
		perform?(`key`)
		var __value: DatabaseQueryCombine
		do {
		    __value = try methodReturnValue(.m_addQueryOrdered__byChild_key(Parameter<String>.value(`key`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for addQueryOrdered(byChild key: String). Use given")
			Failure("Stub return value not specified for addQueryOrdered(byChild key: String). Use given")
		}
		return __value
    }

    open func addOnDisconnectSetValue(_ value: Any, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        addInvocation(.m_addOnDisconnectSetValue__valuecompletion_completion(Parameter<Any>.value(`value`), Parameter<(Error?, DatabaseReference?) -> Void>.value(`completion`)))
		let perform = methodPerformValue(.m_addOnDisconnectSetValue__valuecompletion_completion(Parameter<Any>.value(`value`), Parameter<(Error?, DatabaseReference?) -> Void>.value(`completion`))) as? (Any, @escaping (Error?, DatabaseReference?) -> Void) -> Void
		perform?(`value`, `completion`)
    }

    open func removeObservers() {
        addInvocation(.m_removeObservers)
		let perform = methodPerformValue(.m_removeObservers) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_addChild__path(Parameter<String>)
        case m_setValuePublisher__data(Parameter<[String: Any]>)
        case m_updateChildValuesPublisher__data(Parameter<[String: Any]>)
        case m_removeValuePublisher
        case m_setupPresencePublisher__onlineValue_onlineValueofflineValue_offlineValue(Parameter<Any>, Parameter<Any>)
        case m_addQueryOrderedByKey
        case m_addQueryOrdered__byChild_key(Parameter<String>)
        case m_addOnDisconnectSetValue__valuecompletion_completion(Parameter<Any>, Parameter<(Error?, DatabaseReference?) -> Void>)
        case m_removeObservers

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_addChild__path(let lhsPath), .m_addChild__path(let rhsPath)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPath, rhs: rhsPath, with: matcher), lhsPath, rhsPath, "_ path"))
				return Matcher.ComparisonResult(results)

            case (.m_setValuePublisher__data(let lhsData), .m_setValuePublisher__data(let rhsData)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsData, rhs: rhsData, with: matcher), lhsData, rhsData, "_ data"))
				return Matcher.ComparisonResult(results)

            case (.m_updateChildValuesPublisher__data(let lhsData), .m_updateChildValuesPublisher__data(let rhsData)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsData, rhs: rhsData, with: matcher), lhsData, rhsData, "_ data"))
				return Matcher.ComparisonResult(results)

            case (.m_removeValuePublisher, .m_removeValuePublisher): return .match

            case (.m_setupPresencePublisher__onlineValue_onlineValueofflineValue_offlineValue(let lhsOnlinevalue, let lhsOfflinevalue), .m_setupPresencePublisher__onlineValue_onlineValueofflineValue_offlineValue(let rhsOnlinevalue, let rhsOfflinevalue)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsOnlinevalue, rhs: rhsOnlinevalue, with: matcher), lhsOnlinevalue, rhsOnlinevalue, "onlineValue"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsOfflinevalue, rhs: rhsOfflinevalue, with: matcher), lhsOfflinevalue, rhsOfflinevalue, "offlineValue"))
				return Matcher.ComparisonResult(results)

            case (.m_addQueryOrderedByKey, .m_addQueryOrderedByKey): return .match

            case (.m_addQueryOrdered__byChild_key(let lhsKey), .m_addQueryOrdered__byChild_key(let rhsKey)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsKey, rhs: rhsKey, with: matcher), lhsKey, rhsKey, "byChild key"))
				return Matcher.ComparisonResult(results)

            case (.m_addOnDisconnectSetValue__valuecompletion_completion(let lhsValue, let lhsCompletion), .m_addOnDisconnectSetValue__valuecompletion_completion(let rhsValue, let rhsCompletion)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsValue, rhs: rhsValue, with: matcher), lhsValue, rhsValue, "_ value"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher), lhsCompletion, rhsCompletion, "completion"))
				return Matcher.ComparisonResult(results)

            case (.m_removeObservers, .m_removeObservers): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_addChild__path(p0): return p0.intValue
            case let .m_setValuePublisher__data(p0): return p0.intValue
            case let .m_updateChildValuesPublisher__data(p0): return p0.intValue
            case .m_removeValuePublisher: return 0
            case let .m_setupPresencePublisher__onlineValue_onlineValueofflineValue_offlineValue(p0, p1): return p0.intValue + p1.intValue
            case .m_addQueryOrderedByKey: return 0
            case let .m_addQueryOrdered__byChild_key(p0): return p0.intValue
            case let .m_addOnDisconnectSetValue__valuecompletion_completion(p0, p1): return p0.intValue + p1.intValue
            case .m_removeObservers: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_addChild__path: return ".addChild(_:)"
            case .m_setValuePublisher__data: return ".setValuePublisher(_:)"
            case .m_updateChildValuesPublisher__data: return ".updateChildValuesPublisher(_:)"
            case .m_removeValuePublisher: return ".removeValuePublisher()"
            case .m_setupPresencePublisher__onlineValue_onlineValueofflineValue_offlineValue: return ".setupPresencePublisher(onlineValue:offlineValue:)"
            case .m_addQueryOrderedByKey: return ".addQueryOrderedByKey()"
            case .m_addQueryOrdered__byChild_key: return ".addQueryOrdered(byChild:)"
            case .m_addOnDisconnectSetValue__valuecompletion_completion: return ".addOnDisconnectSetValue(_:completion:)"
            case .m_removeObservers: return ".removeObservers()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func addChild(_ path: Parameter<String>, willReturn: DatabaseReferenceCombine...) -> MethodStub {
            return Given(method: .m_addChild__path(`path`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func setValuePublisher(_ data: Parameter<[String: Any]>, willReturn: AnyPublisher<Void, FirestoreError>...) -> MethodStub {
            return Given(method: .m_setValuePublisher__data(`data`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func updateChildValuesPublisher(_ data: Parameter<[String: Any]>, willReturn: AnyPublisher<Void, FirestoreError>...) -> MethodStub {
            return Given(method: .m_updateChildValuesPublisher__data(`data`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func removeValuePublisher(willReturn: AnyPublisher<Void, FirestoreError>...) -> MethodStub {
            return Given(method: .m_removeValuePublisher, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func setupPresencePublisher(onlineValue: Parameter<Any>, offlineValue: Parameter<Any>, willReturn: AnyPublisher<Void, FirestoreError>...) -> MethodStub {
            return Given(method: .m_setupPresencePublisher__onlineValue_onlineValueofflineValue_offlineValue(`onlineValue`, `offlineValue`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func addQueryOrderedByKey(willReturn: DatabaseQueryCombine...) -> MethodStub {
            return Given(method: .m_addQueryOrderedByKey, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func addQueryOrdered(byChild key: Parameter<String>, willReturn: DatabaseQueryCombine...) -> MethodStub {
            return Given(method: .m_addQueryOrdered__byChild_key(`key`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func addChild(_ path: Parameter<String>, willProduce: (Stubber<DatabaseReferenceCombine>) -> Void) -> MethodStub {
            let willReturn: [DatabaseReferenceCombine] = []
			let given: Given = { return Given(method: .m_addChild__path(`path`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseReferenceCombine).self)
			willProduce(stubber)
			return given
        }
        public static func setValuePublisher(_ data: Parameter<[String: Any]>, willProduce: (Stubber<AnyPublisher<Void, FirestoreError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, FirestoreError>] = []
			let given: Given = { return Given(method: .m_setValuePublisher__data(`data`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, FirestoreError>).self)
			willProduce(stubber)
			return given
        }
        public static func updateChildValuesPublisher(_ data: Parameter<[String: Any]>, willProduce: (Stubber<AnyPublisher<Void, FirestoreError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, FirestoreError>] = []
			let given: Given = { return Given(method: .m_updateChildValuesPublisher__data(`data`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, FirestoreError>).self)
			willProduce(stubber)
			return given
        }
        public static func removeValuePublisher(willProduce: (Stubber<AnyPublisher<Void, FirestoreError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, FirestoreError>] = []
			let given: Given = { return Given(method: .m_removeValuePublisher, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, FirestoreError>).self)
			willProduce(stubber)
			return given
        }
        public static func setupPresencePublisher(onlineValue: Parameter<Any>, offlineValue: Parameter<Any>, willProduce: (Stubber<AnyPublisher<Void, FirestoreError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, FirestoreError>] = []
			let given: Given = { return Given(method: .m_setupPresencePublisher__onlineValue_onlineValueofflineValue_offlineValue(`onlineValue`, `offlineValue`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, FirestoreError>).self)
			willProduce(stubber)
			return given
        }
        public static func addQueryOrderedByKey(willProduce: (Stubber<DatabaseQueryCombine>) -> Void) -> MethodStub {
            let willReturn: [DatabaseQueryCombine] = []
			let given: Given = { return Given(method: .m_addQueryOrderedByKey, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseQueryCombine).self)
			willProduce(stubber)
			return given
        }
        public static func addQueryOrdered(byChild key: Parameter<String>, willProduce: (Stubber<DatabaseQueryCombine>) -> Void) -> MethodStub {
            let willReturn: [DatabaseQueryCombine] = []
			let given: Given = { return Given(method: .m_addQueryOrdered__byChild_key(`key`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (DatabaseQueryCombine).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func addChild(_ path: Parameter<String>) -> Verify { return Verify(method: .m_addChild__path(`path`))}
        public static func setValuePublisher(_ data: Parameter<[String: Any]>) -> Verify { return Verify(method: .m_setValuePublisher__data(`data`))}
        public static func updateChildValuesPublisher(_ data: Parameter<[String: Any]>) -> Verify { return Verify(method: .m_updateChildValuesPublisher__data(`data`))}
        public static func removeValuePublisher() -> Verify { return Verify(method: .m_removeValuePublisher)}
        public static func setupPresencePublisher(onlineValue: Parameter<Any>, offlineValue: Parameter<Any>) -> Verify { return Verify(method: .m_setupPresencePublisher__onlineValue_onlineValueofflineValue_offlineValue(`onlineValue`, `offlineValue`))}
        public static func addQueryOrderedByKey() -> Verify { return Verify(method: .m_addQueryOrderedByKey)}
        public static func addQueryOrdered(byChild key: Parameter<String>) -> Verify { return Verify(method: .m_addQueryOrdered__byChild_key(`key`))}
        public static func addOnDisconnectSetValue(_ value: Parameter<Any>, completion: Parameter<(Error?, DatabaseReference?) -> Void>) -> Verify { return Verify(method: .m_addOnDisconnectSetValue__valuecompletion_completion(`value`, `completion`))}
        public static func removeObservers() -> Verify { return Verify(method: .m_removeObservers)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func addChild(_ path: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_addChild__path(`path`), performs: perform)
        }
        public static func setValuePublisher(_ data: Parameter<[String: Any]>, perform: @escaping ([String: Any]) -> Void) -> Perform {
            return Perform(method: .m_setValuePublisher__data(`data`), performs: perform)
        }
        public static func updateChildValuesPublisher(_ data: Parameter<[String: Any]>, perform: @escaping ([String: Any]) -> Void) -> Perform {
            return Perform(method: .m_updateChildValuesPublisher__data(`data`), performs: perform)
        }
        public static func removeValuePublisher(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_removeValuePublisher, performs: perform)
        }
        public static func setupPresencePublisher(onlineValue: Parameter<Any>, offlineValue: Parameter<Any>, perform: @escaping (Any, Any) -> Void) -> Perform {
            return Perform(method: .m_setupPresencePublisher__onlineValue_onlineValueofflineValue_offlineValue(`onlineValue`, `offlineValue`), performs: perform)
        }
        public static func addQueryOrderedByKey(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_addQueryOrderedByKey, performs: perform)
        }
        public static func addQueryOrdered(byChild key: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_addQueryOrdered__byChild_key(`key`), performs: perform)
        }
        public static func addOnDisconnectSetValue(_ value: Parameter<Any>, completion: Parameter<(Error?, DatabaseReference?) -> Void>, perform: @escaping (Any, @escaping (Error?, DatabaseReference?) -> Void) -> Void) -> Perform {
            return Perform(method: .m_addOnDisconnectSetValue__valuecompletion_completion(`value`, `completion`), performs: perform)
        }
        public static func removeObservers(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_removeObservers, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - DeleteUser

open class DeleteUserMock: DeleteUser, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func execute(user: User) -> AnyPublisher<Void, FirestoreError> {
        addInvocation(.m_execute__user_user(Parameter<User>.value(`user`)))
		let perform = methodPerformValue(.m_execute__user_user(Parameter<User>.value(`user`))) as? (User) -> Void
		perform?(`user`)
		var __value: AnyPublisher<Void, FirestoreError>
		do {
		    __value = try methodReturnValue(.m_execute__user_user(Parameter<User>.value(`user`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for execute(user: User). Use given")
			Failure("Stub return value not specified for execute(user: User). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_execute__user_user(Parameter<User>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_execute__user_user(let lhsUser), .m_execute__user_user(let rhsUser)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUser, rhs: rhsUser, with: matcher), lhsUser, rhsUser, "user"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_execute__user_user(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_execute__user_user: return ".execute(user:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func execute(user: Parameter<User>, willReturn: AnyPublisher<Void, FirestoreError>...) -> MethodStub {
            return Given(method: .m_execute__user_user(`user`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func execute(user: Parameter<User>, willProduce: (Stubber<AnyPublisher<Void, FirestoreError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, FirestoreError>] = []
			let given: Given = { return Given(method: .m_execute__user_user(`user`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, FirestoreError>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute(user: Parameter<User>) -> Verify { return Verify(method: .m_execute__user_user(`user`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(user: Parameter<User>, perform: @escaping (User) -> Void) -> Perform {
            return Perform(method: .m_execute__user_user(`user`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - FirestoreService

open class FirestoreServiceMock: FirestoreService, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func create(id: String, _ data: [String: Any]) -> AnyPublisher<Void, FirestoreError> {
        addInvocation(.m_create__id_id_data(Parameter<String>.value(`id`), Parameter<[String: Any]>.value(`data`)))
		let perform = methodPerformValue(.m_create__id_id_data(Parameter<String>.value(`id`), Parameter<[String: Any]>.value(`data`))) as? (String, [String: Any]) -> Void
		perform?(`id`, `data`)
		var __value: AnyPublisher<Void, FirestoreError>
		do {
		    __value = try methodReturnValue(.m_create__id_id_data(Parameter<String>.value(`id`), Parameter<[String: Any]>.value(`data`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for create(id: String, _ data: [String: Any]). Use given")
			Failure("Stub return value not specified for create(id: String, _ data: [String: Any]). Use given")
		}
		return __value
    }

    open func update(id: String, _ data: [String: Any]) -> AnyPublisher<Void, FirestoreError> {
        addInvocation(.m_update__id_id_data(Parameter<String>.value(`id`), Parameter<[String: Any]>.value(`data`)))
		let perform = methodPerformValue(.m_update__id_id_data(Parameter<String>.value(`id`), Parameter<[String: Any]>.value(`data`))) as? (String, [String: Any]) -> Void
		perform?(`id`, `data`)
		var __value: AnyPublisher<Void, FirestoreError>
		do {
		    __value = try methodReturnValue(.m_update__id_id_data(Parameter<String>.value(`id`), Parameter<[String: Any]>.value(`data`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for update(id: String, _ data: [String: Any]). Use given")
			Failure("Stub return value not specified for update(id: String, _ data: [String: Any]). Use given")
		}
		return __value
    }

    open func startObserving(query: (String, Any)?, disconnectValue: [String: Any]) -> AnyPublisher<[DocumentSnapshotWrapper], Never> {
        addInvocation(.m_startObserving__query_querydisconnectValue_disconnectValue(Parameter<(String, Any)?>.value(`query`), Parameter<[String: Any]>.value(`disconnectValue`)))
		let perform = methodPerformValue(.m_startObserving__query_querydisconnectValue_disconnectValue(Parameter<(String, Any)?>.value(`query`), Parameter<[String: Any]>.value(`disconnectValue`))) as? ((String, Any)?, [String: Any]) -> Void
		perform?(`query`, `disconnectValue`)
		var __value: AnyPublisher<[DocumentSnapshotWrapper], Never>
		do {
		    __value = try methodReturnValue(.m_startObserving__query_querydisconnectValue_disconnectValue(Parameter<(String, Any)?>.value(`query`), Parameter<[String: Any]>.value(`disconnectValue`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for startObserving(query: (String, Any)?, disconnectValue: [String: Any]). Use given")
			Failure("Stub return value not specified for startObserving(query: (String, Any)?, disconnectValue: [String: Any]). Use given")
		}
		return __value
    }

    open func stopObserving() {
        addInvocation(.m_stopObserving)
		let perform = methodPerformValue(.m_stopObserving) as? () -> Void
		perform?()
    }

    open func delete(id: String) -> AnyPublisher<Void, FirestoreError> {
        addInvocation(.m_delete__id_id(Parameter<String>.value(`id`)))
		let perform = methodPerformValue(.m_delete__id_id(Parameter<String>.value(`id`))) as? (String) -> Void
		perform?(`id`)
		var __value: AnyPublisher<Void, FirestoreError>
		do {
		    __value = try methodReturnValue(.m_delete__id_id(Parameter<String>.value(`id`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for delete(id: String). Use given")
			Failure("Stub return value not specified for delete(id: String). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_create__id_id_data(Parameter<String>, Parameter<[String: Any]>)
        case m_update__id_id_data(Parameter<String>, Parameter<[String: Any]>)
        case m_startObserving__query_querydisconnectValue_disconnectValue(Parameter<(String, Any)?>, Parameter<[String: Any]>)
        case m_stopObserving
        case m_delete__id_id(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_create__id_id_data(let lhsId, let lhsData), .m_create__id_id_data(let rhsId, let rhsData)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher), lhsId, rhsId, "id"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsData, rhs: rhsData, with: matcher), lhsData, rhsData, "_ data"))
				return Matcher.ComparisonResult(results)

            case (.m_update__id_id_data(let lhsId, let lhsData), .m_update__id_id_data(let rhsId, let rhsData)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher), lhsId, rhsId, "id"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsData, rhs: rhsData, with: matcher), lhsData, rhsData, "_ data"))
				return Matcher.ComparisonResult(results)

            case (.m_startObserving__query_querydisconnectValue_disconnectValue(let lhsQuery, let lhsDisconnectvalue), .m_startObserving__query_querydisconnectValue_disconnectValue(let rhsQuery, let rhsDisconnectvalue)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsQuery, rhs: rhsQuery, with: matcher), lhsQuery, rhsQuery, "query"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDisconnectvalue, rhs: rhsDisconnectvalue, with: matcher), lhsDisconnectvalue, rhsDisconnectvalue, "disconnectValue"))
				return Matcher.ComparisonResult(results)

            case (.m_stopObserving, .m_stopObserving): return .match

            case (.m_delete__id_id(let lhsId), .m_delete__id_id(let rhsId)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher), lhsId, rhsId, "id"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_create__id_id_data(p0, p1): return p0.intValue + p1.intValue
            case let .m_update__id_id_data(p0, p1): return p0.intValue + p1.intValue
            case let .m_startObserving__query_querydisconnectValue_disconnectValue(p0, p1): return p0.intValue + p1.intValue
            case .m_stopObserving: return 0
            case let .m_delete__id_id(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_create__id_id_data: return ".create(id:_:)"
            case .m_update__id_id_data: return ".update(id:_:)"
            case .m_startObserving__query_querydisconnectValue_disconnectValue: return ".startObserving(query:disconnectValue:)"
            case .m_stopObserving: return ".stopObserving()"
            case .m_delete__id_id: return ".delete(id:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func create(id: Parameter<String>, _ data: Parameter<[String: Any]>, willReturn: AnyPublisher<Void, FirestoreError>...) -> MethodStub {
            return Given(method: .m_create__id_id_data(`id`, `data`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func update(id: Parameter<String>, _ data: Parameter<[String: Any]>, willReturn: AnyPublisher<Void, FirestoreError>...) -> MethodStub {
            return Given(method: .m_update__id_id_data(`id`, `data`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func startObserving(query: Parameter<(String, Any)?>, disconnectValue: Parameter<[String: Any]>, willReturn: AnyPublisher<[DocumentSnapshotWrapper], Never>...) -> MethodStub {
            return Given(method: .m_startObserving__query_querydisconnectValue_disconnectValue(`query`, `disconnectValue`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func delete(id: Parameter<String>, willReturn: AnyPublisher<Void, FirestoreError>...) -> MethodStub {
            return Given(method: .m_delete__id_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func create(id: Parameter<String>, _ data: Parameter<[String: Any]>, willProduce: (Stubber<AnyPublisher<Void, FirestoreError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, FirestoreError>] = []
			let given: Given = { return Given(method: .m_create__id_id_data(`id`, `data`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, FirestoreError>).self)
			willProduce(stubber)
			return given
        }
        public static func update(id: Parameter<String>, _ data: Parameter<[String: Any]>, willProduce: (Stubber<AnyPublisher<Void, FirestoreError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, FirestoreError>] = []
			let given: Given = { return Given(method: .m_update__id_id_data(`id`, `data`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, FirestoreError>).self)
			willProduce(stubber)
			return given
        }
        public static func startObserving(query: Parameter<(String, Any)?>, disconnectValue: Parameter<[String: Any]>, willProduce: (Stubber<AnyPublisher<[DocumentSnapshotWrapper], Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<[DocumentSnapshotWrapper], Never>] = []
			let given: Given = { return Given(method: .m_startObserving__query_querydisconnectValue_disconnectValue(`query`, `disconnectValue`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<[DocumentSnapshotWrapper], Never>).self)
			willProduce(stubber)
			return given
        }
        public static func delete(id: Parameter<String>, willProduce: (Stubber<AnyPublisher<Void, FirestoreError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, FirestoreError>] = []
			let given: Given = { return Given(method: .m_delete__id_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, FirestoreError>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func create(id: Parameter<String>, _ data: Parameter<[String: Any]>) -> Verify { return Verify(method: .m_create__id_id_data(`id`, `data`))}
        public static func update(id: Parameter<String>, _ data: Parameter<[String: Any]>) -> Verify { return Verify(method: .m_update__id_id_data(`id`, `data`))}
        public static func startObserving(query: Parameter<(String, Any)?>, disconnectValue: Parameter<[String: Any]>) -> Verify { return Verify(method: .m_startObserving__query_querydisconnectValue_disconnectValue(`query`, `disconnectValue`))}
        public static func stopObserving() -> Verify { return Verify(method: .m_stopObserving)}
        public static func delete(id: Parameter<String>) -> Verify { return Verify(method: .m_delete__id_id(`id`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func create(id: Parameter<String>, _ data: Parameter<[String: Any]>, perform: @escaping (String, [String: Any]) -> Void) -> Perform {
            return Perform(method: .m_create__id_id_data(`id`, `data`), performs: perform)
        }
        public static func update(id: Parameter<String>, _ data: Parameter<[String: Any]>, perform: @escaping (String, [String: Any]) -> Void) -> Perform {
            return Perform(method: .m_update__id_id_data(`id`, `data`), performs: perform)
        }
        public static func startObserving(query: Parameter<(String, Any)?>, disconnectValue: Parameter<[String: Any]>, perform: @escaping ((String, Any)?, [String: Any]) -> Void) -> Perform {
            return Perform(method: .m_startObserving__query_querydisconnectValue_disconnectValue(`query`, `disconnectValue`), performs: perform)
        }
        public static func stopObserving(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_stopObserving, performs: perform)
        }
        public static func delete(id: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_delete__id_id(`id`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - GetCurrentUser

open class GetCurrentUserMock: GetCurrentUser, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func execute() -> AnyPublisher<User?, FirestoreError> {
        addInvocation(.m_execute)
		let perform = methodPerformValue(.m_execute) as? () -> Void
		perform?()
		var __value: AnyPublisher<User?, FirestoreError>
		do {
		    __value = try methodReturnValue(.m_execute).casted()
		} catch {
			onFatalFailure("Stub return value not specified for execute(). Use given")
			Failure("Stub return value not specified for execute(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_execute

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_execute, .m_execute): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_execute: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_execute: return ".execute()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func execute(willReturn: AnyPublisher<User?, FirestoreError>...) -> MethodStub {
            return Given(method: .m_execute, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func execute(willProduce: (Stubber<AnyPublisher<User?, FirestoreError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<User?, FirestoreError>] = []
			let given: Given = { return Given(method: .m_execute, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<User?, FirestoreError>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute() -> Verify { return Verify(method: .m_execute)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_execute, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - GetLocationUpdates

open class GetLocationUpdatesMock: GetLocationUpdates, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func execute() -> AnyPublisher<CLLocationCoordinate2D, Never> {
        addInvocation(.m_execute)
		let perform = methodPerformValue(.m_execute) as? () -> Void
		perform?()
		var __value: AnyPublisher<CLLocationCoordinate2D, Never>
		do {
		    __value = try methodReturnValue(.m_execute).casted()
		} catch {
			onFatalFailure("Stub return value not specified for execute(). Use given")
			Failure("Stub return value not specified for execute(). Use given")
		}
		return __value
    }

    open func stop() {
        addInvocation(.m_stop)
		let perform = methodPerformValue(.m_stop) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_execute
        case m_stop

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_execute, .m_execute): return .match

            case (.m_stop, .m_stop): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_execute: return 0
            case .m_stop: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_execute: return ".execute()"
            case .m_stop: return ".stop()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func execute(willReturn: AnyPublisher<CLLocationCoordinate2D, Never>...) -> MethodStub {
            return Given(method: .m_execute, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func execute(willProduce: (Stubber<AnyPublisher<CLLocationCoordinate2D, Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<CLLocationCoordinate2D, Never>] = []
			let given: Given = { return Given(method: .m_execute, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<CLLocationCoordinate2D, Never>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute() -> Verify { return Verify(method: .m_execute)}
        public static func stop() -> Verify { return Verify(method: .m_stop)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_execute, performs: perform)
        }
        public static func stop(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_stop, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - KeychainFacade

open class KeychainFacadeMock: KeychainFacade, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func set(data: Data, forKey key: String) throws {
        addInvocation(.m_set__data_dataforKey_key_1(Parameter<Data>.value(`data`), Parameter<String>.value(`key`)))
		let perform = methodPerformValue(.m_set__data_dataforKey_key_1(Parameter<Data>.value(`data`), Parameter<String>.value(`key`))) as? (Data, String) -> Void
		perform?(`data`, `key`)
		do {
		    _ = try methodReturnValue(.m_set__data_dataforKey_key_1(Parameter<Data>.value(`data`), Parameter<String>.value(`key`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func set(data: Bool, forKey key: String) throws {
        addInvocation(.m_set__data_dataforKey_key_2(Parameter<Bool>.value(`data`), Parameter<String>.value(`key`)))
		let perform = methodPerformValue(.m_set__data_dataforKey_key_2(Parameter<Bool>.value(`data`), Parameter<String>.value(`key`))) as? (Bool, String) -> Void
		perform?(`data`, `key`)
		do {
		    _ = try methodReturnValue(.m_set__data_dataforKey_key_2(Parameter<Bool>.value(`data`), Parameter<String>.value(`key`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func set(data: String, forKey key: String) throws {
        addInvocation(.m_set__data_dataforKey_key_3(Parameter<String>.value(`data`), Parameter<String>.value(`key`)))
		let perform = methodPerformValue(.m_set__data_dataforKey_key_3(Parameter<String>.value(`data`), Parameter<String>.value(`key`))) as? (String, String) -> Void
		perform?(`data`, `key`)
		do {
		    _ = try methodReturnValue(.m_set__data_dataforKey_key_3(Parameter<String>.value(`data`), Parameter<String>.value(`key`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func set(data: Int, forKey key: String) throws {
        addInvocation(.m_set__data_dataforKey_key_4(Parameter<Int>.value(`data`), Parameter<String>.value(`key`)))
		let perform = methodPerformValue(.m_set__data_dataforKey_key_4(Parameter<Int>.value(`data`), Parameter<String>.value(`key`))) as? (Int, String) -> Void
		perform?(`data`, `key`)
		do {
		    _ = try methodReturnValue(.m_set__data_dataforKey_key_4(Parameter<Int>.value(`data`), Parameter<String>.value(`key`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func get(forKey key: String) throws -> Data? {
        addInvocation(.m_get__forKey_key(Parameter<String>.value(`key`)))
		let perform = methodPerformValue(.m_get__forKey_key(Parameter<String>.value(`key`))) as? (String) -> Void
		perform?(`key`)
		var __value: Data? = nil
		do {
		    __value = try methodReturnValue(.m_get__forKey_key(Parameter<String>.value(`key`))).casted()
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
		return __value
    }

    open func string(forKey key: String) throws -> String? {
        addInvocation(.m_string__forKey_key(Parameter<String>.value(`key`)))
		let perform = methodPerformValue(.m_string__forKey_key(Parameter<String>.value(`key`))) as? (String) -> Void
		perform?(`key`)
		var __value: String? = nil
		do {
		    __value = try methodReturnValue(.m_string__forKey_key(Parameter<String>.value(`key`))).casted()
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
		return __value
    }

    open func int(forKey key: String) throws -> Int? {
        addInvocation(.m_int__forKey_key(Parameter<String>.value(`key`)))
		let perform = methodPerformValue(.m_int__forKey_key(Parameter<String>.value(`key`))) as? (String) -> Void
		perform?(`key`)
		var __value: Int? = nil
		do {
		    __value = try methodReturnValue(.m_int__forKey_key(Parameter<String>.value(`key`))).casted()
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
		return __value
    }

    open func remove(forKey key: String) throws {
        addInvocation(.m_remove__forKey_key(Parameter<String>.value(`key`)))
		let perform = methodPerformValue(.m_remove__forKey_key(Parameter<String>.value(`key`))) as? (String) -> Void
		perform?(`key`)
		do {
		    _ = try methodReturnValue(.m_remove__forKey_key(Parameter<String>.value(`key`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }


    fileprivate enum MethodType {
        case m_set__data_dataforKey_key_1(Parameter<Data>, Parameter<String>)
        case m_set__data_dataforKey_key_2(Parameter<Bool>, Parameter<String>)
        case m_set__data_dataforKey_key_3(Parameter<String>, Parameter<String>)
        case m_set__data_dataforKey_key_4(Parameter<Int>, Parameter<String>)
        case m_get__forKey_key(Parameter<String>)
        case m_string__forKey_key(Parameter<String>)
        case m_int__forKey_key(Parameter<String>)
        case m_remove__forKey_key(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_set__data_dataforKey_key_1(let lhsData, let lhsKey), .m_set__data_dataforKey_key_1(let rhsData, let rhsKey)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsData, rhs: rhsData, with: matcher), lhsData, rhsData, "data"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsKey, rhs: rhsKey, with: matcher), lhsKey, rhsKey, "forKey key"))
				return Matcher.ComparisonResult(results)

            case (.m_set__data_dataforKey_key_2(let lhsData, let lhsKey), .m_set__data_dataforKey_key_2(let rhsData, let rhsKey)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsData, rhs: rhsData, with: matcher), lhsData, rhsData, "data"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsKey, rhs: rhsKey, with: matcher), lhsKey, rhsKey, "forKey key"))
				return Matcher.ComparisonResult(results)

            case (.m_set__data_dataforKey_key_3(let lhsData, let lhsKey), .m_set__data_dataforKey_key_3(let rhsData, let rhsKey)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsData, rhs: rhsData, with: matcher), lhsData, rhsData, "data"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsKey, rhs: rhsKey, with: matcher), lhsKey, rhsKey, "forKey key"))
				return Matcher.ComparisonResult(results)

            case (.m_set__data_dataforKey_key_4(let lhsData, let lhsKey), .m_set__data_dataforKey_key_4(let rhsData, let rhsKey)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsData, rhs: rhsData, with: matcher), lhsData, rhsData, "data"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsKey, rhs: rhsKey, with: matcher), lhsKey, rhsKey, "forKey key"))
				return Matcher.ComparisonResult(results)

            case (.m_get__forKey_key(let lhsKey), .m_get__forKey_key(let rhsKey)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsKey, rhs: rhsKey, with: matcher), lhsKey, rhsKey, "forKey key"))
				return Matcher.ComparisonResult(results)

            case (.m_string__forKey_key(let lhsKey), .m_string__forKey_key(let rhsKey)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsKey, rhs: rhsKey, with: matcher), lhsKey, rhsKey, "forKey key"))
				return Matcher.ComparisonResult(results)

            case (.m_int__forKey_key(let lhsKey), .m_int__forKey_key(let rhsKey)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsKey, rhs: rhsKey, with: matcher), lhsKey, rhsKey, "forKey key"))
				return Matcher.ComparisonResult(results)

            case (.m_remove__forKey_key(let lhsKey), .m_remove__forKey_key(let rhsKey)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsKey, rhs: rhsKey, with: matcher), lhsKey, rhsKey, "forKey key"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_set__data_dataforKey_key_1(p0, p1): return p0.intValue + p1.intValue
            case let .m_set__data_dataforKey_key_2(p0, p1): return p0.intValue + p1.intValue
            case let .m_set__data_dataforKey_key_3(p0, p1): return p0.intValue + p1.intValue
            case let .m_set__data_dataforKey_key_4(p0, p1): return p0.intValue + p1.intValue
            case let .m_get__forKey_key(p0): return p0.intValue
            case let .m_string__forKey_key(p0): return p0.intValue
            case let .m_int__forKey_key(p0): return p0.intValue
            case let .m_remove__forKey_key(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_set__data_dataforKey_key_1: return ".set(data:forKey:)"
            case .m_set__data_dataforKey_key_2: return ".set(data:forKey:)"
            case .m_set__data_dataforKey_key_3: return ".set(data:forKey:)"
            case .m_set__data_dataforKey_key_4: return ".set(data:forKey:)"
            case .m_get__forKey_key: return ".get(forKey:)"
            case .m_string__forKey_key: return ".string(forKey:)"
            case .m_int__forKey_key: return ".int(forKey:)"
            case .m_remove__forKey_key: return ".remove(forKey:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func get(forKey key: Parameter<String>, willReturn: Data?...) -> MethodStub {
            return Given(method: .m_get__forKey_key(`key`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func string(forKey key: Parameter<String>, willReturn: String?...) -> MethodStub {
            return Given(method: .m_string__forKey_key(`key`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func int(forKey key: Parameter<String>, willReturn: Int?...) -> MethodStub {
            return Given(method: .m_int__forKey_key(`key`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func set(data: Parameter<Data>, forKey key: Parameter<String>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_set__data_dataforKey_key_1(`data`, `key`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func set(data: Parameter<Data>, forKey key: Parameter<String>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_set__data_dataforKey_key_1(`data`, `key`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func set(data: Parameter<Bool>, forKey key: Parameter<String>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_set__data_dataforKey_key_2(`data`, `key`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func set(data: Parameter<Bool>, forKey key: Parameter<String>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_set__data_dataforKey_key_2(`data`, `key`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func set(data: Parameter<String>, forKey key: Parameter<String>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_set__data_dataforKey_key_3(`data`, `key`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func set(data: Parameter<String>, forKey key: Parameter<String>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_set__data_dataforKey_key_3(`data`, `key`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func set(data: Parameter<Int>, forKey key: Parameter<String>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_set__data_dataforKey_key_4(`data`, `key`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func set(data: Parameter<Int>, forKey key: Parameter<String>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_set__data_dataforKey_key_4(`data`, `key`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func get(forKey key: Parameter<String>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_get__forKey_key(`key`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func get(forKey key: Parameter<String>, willProduce: (StubberThrows<Data?>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_get__forKey_key(`key`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Data?).self)
			willProduce(stubber)
			return given
        }
        public static func string(forKey key: Parameter<String>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_string__forKey_key(`key`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func string(forKey key: Parameter<String>, willProduce: (StubberThrows<String?>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_string__forKey_key(`key`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (String?).self)
			willProduce(stubber)
			return given
        }
        public static func int(forKey key: Parameter<String>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_int__forKey_key(`key`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func int(forKey key: Parameter<String>, willProduce: (StubberThrows<Int?>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_int__forKey_key(`key`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Int?).self)
			willProduce(stubber)
			return given
        }
        public static func remove(forKey key: Parameter<String>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_remove__forKey_key(`key`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func remove(forKey key: Parameter<String>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_remove__forKey_key(`key`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func set(data: Parameter<Data>, forKey key: Parameter<String>) -> Verify { return Verify(method: .m_set__data_dataforKey_key_1(`data`, `key`))}
        public static func set(data: Parameter<Bool>, forKey key: Parameter<String>) -> Verify { return Verify(method: .m_set__data_dataforKey_key_2(`data`, `key`))}
        public static func set(data: Parameter<String>, forKey key: Parameter<String>) -> Verify { return Verify(method: .m_set__data_dataforKey_key_3(`data`, `key`))}
        public static func set(data: Parameter<Int>, forKey key: Parameter<String>) -> Verify { return Verify(method: .m_set__data_dataforKey_key_4(`data`, `key`))}
        public static func get(forKey key: Parameter<String>) -> Verify { return Verify(method: .m_get__forKey_key(`key`))}
        public static func string(forKey key: Parameter<String>) -> Verify { return Verify(method: .m_string__forKey_key(`key`))}
        public static func int(forKey key: Parameter<String>) -> Verify { return Verify(method: .m_int__forKey_key(`key`))}
        public static func remove(forKey key: Parameter<String>) -> Verify { return Verify(method: .m_remove__forKey_key(`key`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func set(data: Parameter<Data>, forKey key: Parameter<String>, perform: @escaping (Data, String) -> Void) -> Perform {
            return Perform(method: .m_set__data_dataforKey_key_1(`data`, `key`), performs: perform)
        }
        public static func set(data: Parameter<Bool>, forKey key: Parameter<String>, perform: @escaping (Bool, String) -> Void) -> Perform {
            return Perform(method: .m_set__data_dataforKey_key_2(`data`, `key`), performs: perform)
        }
        public static func set(data: Parameter<String>, forKey key: Parameter<String>, perform: @escaping (String, String) -> Void) -> Perform {
            return Perform(method: .m_set__data_dataforKey_key_3(`data`, `key`), performs: perform)
        }
        public static func set(data: Parameter<Int>, forKey key: Parameter<String>, perform: @escaping (Int, String) -> Void) -> Perform {
            return Perform(method: .m_set__data_dataforKey_key_4(`data`, `key`), performs: perform)
        }
        public static func get(forKey key: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_get__forKey_key(`key`), performs: perform)
        }
        public static func string(forKey key: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_string__forKey_key(`key`), performs: perform)
        }
        public static func int(forKey key: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_int__forKey_key(`key`), performs: perform)
        }
        public static func remove(forKey key: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_remove__forKey_key(`key`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - LocationRepository

open class LocationRepositoryMock: LocationRepository, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func getLocationUpdates() -> AnyPublisher<CLLocationCoordinate2D, Never> {
        addInvocation(.m_getLocationUpdates)
		let perform = methodPerformValue(.m_getLocationUpdates) as? () -> Void
		perform?()
		var __value: AnyPublisher<CLLocationCoordinate2D, Never>
		do {
		    __value = try methodReturnValue(.m_getLocationUpdates).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getLocationUpdates(). Use given")
			Failure("Stub return value not specified for getLocationUpdates(). Use given")
		}
		return __value
    }

    open func stopUpdate() {
        addInvocation(.m_stopUpdate)
		let perform = methodPerformValue(.m_stopUpdate) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_getLocationUpdates
        case m_stopUpdate

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getLocationUpdates, .m_getLocationUpdates): return .match

            case (.m_stopUpdate, .m_stopUpdate): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_getLocationUpdates: return 0
            case .m_stopUpdate: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getLocationUpdates: return ".getLocationUpdates()"
            case .m_stopUpdate: return ".stopUpdate()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getLocationUpdates(willReturn: AnyPublisher<CLLocationCoordinate2D, Never>...) -> MethodStub {
            return Given(method: .m_getLocationUpdates, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getLocationUpdates(willProduce: (Stubber<AnyPublisher<CLLocationCoordinate2D, Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<CLLocationCoordinate2D, Never>] = []
			let given: Given = { return Given(method: .m_getLocationUpdates, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<CLLocationCoordinate2D, Never>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getLocationUpdates() -> Verify { return Verify(method: .m_getLocationUpdates)}
        public static func stopUpdate() -> Verify { return Verify(method: .m_stopUpdate)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getLocationUpdates(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getLocationUpdates, performs: perform)
        }
        public static func stopUpdate(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_stopUpdate, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - ObserveUser

open class ObserveUserMock: ObserveUser, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func execute() -> AnyPublisher<[User], Never> {
        addInvocation(.m_execute)
		let perform = methodPerformValue(.m_execute) as? () -> Void
		perform?()
		var __value: AnyPublisher<[User], Never>
		do {
		    __value = try methodReturnValue(.m_execute).casted()
		} catch {
			onFatalFailure("Stub return value not specified for execute(). Use given")
			Failure("Stub return value not specified for execute(). Use given")
		}
		return __value
    }

    open func stop() {
        addInvocation(.m_stop)
		let perform = methodPerformValue(.m_stop) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_execute
        case m_stop

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_execute, .m_execute): return .match

            case (.m_stop, .m_stop): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_execute: return 0
            case .m_stop: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_execute: return ".execute()"
            case .m_stop: return ".stop()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func execute(willReturn: AnyPublisher<[User], Never>...) -> MethodStub {
            return Given(method: .m_execute, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func execute(willProduce: (Stubber<AnyPublisher<[User], Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<[User], Never>] = []
			let given: Given = { return Given(method: .m_execute, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<[User], Never>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute() -> Verify { return Verify(method: .m_execute)}
        public static func stop() -> Verify { return Verify(method: .m_stop)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_execute, performs: perform)
        }
        public static func stop(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_stop, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - UpdateUser

open class UpdateUserMock: UpdateUser, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func execute(user: User) -> AnyPublisher<Void, FirestoreError> {
        addInvocation(.m_execute__user_user(Parameter<User>.value(`user`)))
		let perform = methodPerformValue(.m_execute__user_user(Parameter<User>.value(`user`))) as? (User) -> Void
		perform?(`user`)
		var __value: AnyPublisher<Void, FirestoreError>
		do {
		    __value = try methodReturnValue(.m_execute__user_user(Parameter<User>.value(`user`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for execute(user: User). Use given")
			Failure("Stub return value not specified for execute(user: User). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_execute__user_user(Parameter<User>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_execute__user_user(let lhsUser), .m_execute__user_user(let rhsUser)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUser, rhs: rhsUser, with: matcher), lhsUser, rhsUser, "user"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_execute__user_user(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_execute__user_user: return ".execute(user:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func execute(user: Parameter<User>, willReturn: AnyPublisher<Void, FirestoreError>...) -> MethodStub {
            return Given(method: .m_execute__user_user(`user`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func execute(user: Parameter<User>, willProduce: (Stubber<AnyPublisher<Void, FirestoreError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, FirestoreError>] = []
			let given: Given = { return Given(method: .m_execute__user_user(`user`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, FirestoreError>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute(user: Parameter<User>) -> Verify { return Verify(method: .m_execute__user_user(`user`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(user: Parameter<User>, perform: @escaping (User) -> Void) -> Perform {
            return Perform(method: .m_execute__user_user(`user`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - UserRepository

open class UserRepositoryMock: UserRepository, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func create(user: User) -> AnyPublisher<Void, FirestoreError> {
        addInvocation(.m_create__user_user(Parameter<User>.value(`user`)))
		let perform = methodPerformValue(.m_create__user_user(Parameter<User>.value(`user`))) as? (User) -> Void
		perform?(`user`)
		var __value: AnyPublisher<Void, FirestoreError>
		do {
		    __value = try methodReturnValue(.m_create__user_user(Parameter<User>.value(`user`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for create(user: User). Use given")
			Failure("Stub return value not specified for create(user: User). Use given")
		}
		return __value
    }

    open func startObserveUser() -> AnyPublisher<[User], Never> {
        addInvocation(.m_startObserveUser)
		let perform = methodPerformValue(.m_startObserveUser) as? () -> Void
		perform?()
		var __value: AnyPublisher<[User], Never>
		do {
		    __value = try methodReturnValue(.m_startObserveUser).casted()
		} catch {
			onFatalFailure("Stub return value not specified for startObserveUser(). Use given")
			Failure("Stub return value not specified for startObserveUser(). Use given")
		}
		return __value
    }

    open func stopObserving() {
        addInvocation(.m_stopObserving)
		let perform = methodPerformValue(.m_stopObserving) as? () -> Void
		perform?()
    }

    open func update(user: User) -> AnyPublisher<Void, FirestoreError> {
        addInvocation(.m_update__user_user(Parameter<User>.value(`user`)))
		let perform = methodPerformValue(.m_update__user_user(Parameter<User>.value(`user`))) as? (User) -> Void
		perform?(`user`)
		var __value: AnyPublisher<Void, FirestoreError>
		do {
		    __value = try methodReturnValue(.m_update__user_user(Parameter<User>.value(`user`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for update(user: User). Use given")
			Failure("Stub return value not specified for update(user: User). Use given")
		}
		return __value
    }

    open func delete(user: User) -> AnyPublisher<Void, FirestoreError> {
        addInvocation(.m_delete__user_user(Parameter<User>.value(`user`)))
		let perform = methodPerformValue(.m_delete__user_user(Parameter<User>.value(`user`))) as? (User) -> Void
		perform?(`user`)
		var __value: AnyPublisher<Void, FirestoreError>
		do {
		    __value = try methodReturnValue(.m_delete__user_user(Parameter<User>.value(`user`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for delete(user: User). Use given")
			Failure("Stub return value not specified for delete(user: User). Use given")
		}
		return __value
    }

    open func getLocal() -> AnyPublisher<User?, FirestoreError> {
        addInvocation(.m_getLocal)
		let perform = methodPerformValue(.m_getLocal) as? () -> Void
		perform?()
		var __value: AnyPublisher<User?, FirestoreError>
		do {
		    __value = try methodReturnValue(.m_getLocal).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getLocal(). Use given")
			Failure("Stub return value not specified for getLocal(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_create__user_user(Parameter<User>)
        case m_startObserveUser
        case m_stopObserving
        case m_update__user_user(Parameter<User>)
        case m_delete__user_user(Parameter<User>)
        case m_getLocal

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_create__user_user(let lhsUser), .m_create__user_user(let rhsUser)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUser, rhs: rhsUser, with: matcher), lhsUser, rhsUser, "user"))
				return Matcher.ComparisonResult(results)

            case (.m_startObserveUser, .m_startObserveUser): return .match

            case (.m_stopObserving, .m_stopObserving): return .match

            case (.m_update__user_user(let lhsUser), .m_update__user_user(let rhsUser)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUser, rhs: rhsUser, with: matcher), lhsUser, rhsUser, "user"))
				return Matcher.ComparisonResult(results)

            case (.m_delete__user_user(let lhsUser), .m_delete__user_user(let rhsUser)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUser, rhs: rhsUser, with: matcher), lhsUser, rhsUser, "user"))
				return Matcher.ComparisonResult(results)

            case (.m_getLocal, .m_getLocal): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_create__user_user(p0): return p0.intValue
            case .m_startObserveUser: return 0
            case .m_stopObserving: return 0
            case let .m_update__user_user(p0): return p0.intValue
            case let .m_delete__user_user(p0): return p0.intValue
            case .m_getLocal: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_create__user_user: return ".create(user:)"
            case .m_startObserveUser: return ".startObserveUser()"
            case .m_stopObserving: return ".stopObserving()"
            case .m_update__user_user: return ".update(user:)"
            case .m_delete__user_user: return ".delete(user:)"
            case .m_getLocal: return ".getLocal()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func create(user: Parameter<User>, willReturn: AnyPublisher<Void, FirestoreError>...) -> MethodStub {
            return Given(method: .m_create__user_user(`user`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func startObserveUser(willReturn: AnyPublisher<[User], Never>...) -> MethodStub {
            return Given(method: .m_startObserveUser, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func update(user: Parameter<User>, willReturn: AnyPublisher<Void, FirestoreError>...) -> MethodStub {
            return Given(method: .m_update__user_user(`user`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func delete(user: Parameter<User>, willReturn: AnyPublisher<Void, FirestoreError>...) -> MethodStub {
            return Given(method: .m_delete__user_user(`user`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getLocal(willReturn: AnyPublisher<User?, FirestoreError>...) -> MethodStub {
            return Given(method: .m_getLocal, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func create(user: Parameter<User>, willProduce: (Stubber<AnyPublisher<Void, FirestoreError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, FirestoreError>] = []
			let given: Given = { return Given(method: .m_create__user_user(`user`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, FirestoreError>).self)
			willProduce(stubber)
			return given
        }
        public static func startObserveUser(willProduce: (Stubber<AnyPublisher<[User], Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<[User], Never>] = []
			let given: Given = { return Given(method: .m_startObserveUser, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<[User], Never>).self)
			willProduce(stubber)
			return given
        }
        public static func update(user: Parameter<User>, willProduce: (Stubber<AnyPublisher<Void, FirestoreError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, FirestoreError>] = []
			let given: Given = { return Given(method: .m_update__user_user(`user`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, FirestoreError>).self)
			willProduce(stubber)
			return given
        }
        public static func delete(user: Parameter<User>, willProduce: (Stubber<AnyPublisher<Void, FirestoreError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, FirestoreError>] = []
			let given: Given = { return Given(method: .m_delete__user_user(`user`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, FirestoreError>).self)
			willProduce(stubber)
			return given
        }
        public static func getLocal(willProduce: (Stubber<AnyPublisher<User?, FirestoreError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<User?, FirestoreError>] = []
			let given: Given = { return Given(method: .m_getLocal, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<User?, FirestoreError>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func create(user: Parameter<User>) -> Verify { return Verify(method: .m_create__user_user(`user`))}
        public static func startObserveUser() -> Verify { return Verify(method: .m_startObserveUser)}
        public static func stopObserving() -> Verify { return Verify(method: .m_stopObserving)}
        public static func update(user: Parameter<User>) -> Verify { return Verify(method: .m_update__user_user(`user`))}
        public static func delete(user: Parameter<User>) -> Verify { return Verify(method: .m_delete__user_user(`user`))}
        public static func getLocal() -> Verify { return Verify(method: .m_getLocal)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func create(user: Parameter<User>, perform: @escaping (User) -> Void) -> Perform {
            return Perform(method: .m_create__user_user(`user`), performs: perform)
        }
        public static func startObserveUser(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_startObserveUser, performs: perform)
        }
        public static func stopObserving(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_stopObserving, performs: perform)
        }
        public static func update(user: Parameter<User>, perform: @escaping (User) -> Void) -> Perform {
            return Perform(method: .m_update__user_user(`user`), performs: perform)
        }
        public static func delete(user: Parameter<User>, perform: @escaping (User) -> Void) -> Perform {
            return Perform(method: .m_delete__user_user(`user`), performs: perform)
        }
        public static func getLocal(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getLocal, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

