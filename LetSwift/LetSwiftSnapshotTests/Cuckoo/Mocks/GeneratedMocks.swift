// MARK: - Mocks generated from file: LetSwift/Networking/F1/Services/EargastAPIService.swift at 2022-11-15 12:10:37 +0000

//
//  EargastAPIService.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import Cuckoo
@testable import LetSwift

import Combine
import Networking
import Resolver


 class MockEargastAPIServiceProtocol: EargastAPIServiceProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = EargastAPIServiceProtocol
    
     typealias Stubbing = __StubbingProxy_EargastAPIServiceProtocol
     typealias Verification = __VerificationProxy_EargastAPIServiceProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: EargastAPIServiceProtocol?

     func enableDefaultImplementation(_ stub: EargastAPIServiceProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getCurrentDriverStandings() -> AnyPublisher<[DriverStandings], Error> {
        
    return cuckoo_manager.call("getCurrentDriverStandings() -> AnyPublisher<[DriverStandings], Error>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getCurrentDriverStandings())
        
    }
    
    
    
     func getCurrentSchedule() -> AnyPublisher<[Race], Error> {
        
    return cuckoo_manager.call("getCurrentSchedule() -> AnyPublisher<[Race], Error>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getCurrentSchedule())
        
    }
    
    
    
     func getDriverStatus(driverId: String) -> AnyPublisher<DriverStatus, Error> {
        
    return cuckoo_manager.call("getDriverStatus(driverId: String) -> AnyPublisher<DriverStatus, Error>",
            parameters: (driverId),
            escapingParameters: (driverId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getDriverStatus(driverId: driverId))
        
    }
    

	 struct __StubbingProxy_EargastAPIServiceProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getCurrentDriverStandings() -> Cuckoo.ProtocolStubFunction<(), AnyPublisher<[DriverStandings], Error>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockEargastAPIServiceProtocol.self, method: "getCurrentDriverStandings() -> AnyPublisher<[DriverStandings], Error>", parameterMatchers: matchers))
	    }
	    
	    func getCurrentSchedule() -> Cuckoo.ProtocolStubFunction<(), AnyPublisher<[Race], Error>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockEargastAPIServiceProtocol.self, method: "getCurrentSchedule() -> AnyPublisher<[Race], Error>", parameterMatchers: matchers))
	    }
	    
	    func getDriverStatus<M1: Cuckoo.Matchable>(driverId: M1) -> Cuckoo.ProtocolStubFunction<(String), AnyPublisher<DriverStatus, Error>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: driverId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockEargastAPIServiceProtocol.self, method: "getDriverStatus(driverId: String) -> AnyPublisher<DriverStatus, Error>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_EargastAPIServiceProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getCurrentDriverStandings() -> Cuckoo.__DoNotUse<(), AnyPublisher<[DriverStandings], Error>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getCurrentDriverStandings() -> AnyPublisher<[DriverStandings], Error>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getCurrentSchedule() -> Cuckoo.__DoNotUse<(), AnyPublisher<[Race], Error>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getCurrentSchedule() -> AnyPublisher<[Race], Error>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getDriverStatus<M1: Cuckoo.Matchable>(driverId: M1) -> Cuckoo.__DoNotUse<(String), AnyPublisher<DriverStatus, Error>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: driverId) { $0 }]
	        return cuckoo_manager.verify("getDriverStatus(driverId: String) -> AnyPublisher<DriverStatus, Error>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class EargastAPIServiceProtocolStub: EargastAPIServiceProtocol {
    

    

    
    
    
     func getCurrentDriverStandings() -> AnyPublisher<[DriverStandings], Error>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<[DriverStandings], Error>).self)
    }
    
    
    
     func getCurrentSchedule() -> AnyPublisher<[Race], Error>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<[Race], Error>).self)
    }
    
    
    
     func getDriverStatus(driverId: String) -> AnyPublisher<DriverStatus, Error>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<DriverStatus, Error>).self)
    }
    
}


// MARK: - Mocks generated from file: Networking/Networking/Sources/Public/Core/APIClient.swift at 2022-11-15 12:10:37 +0000


import Cuckoo
@testable import LetSwift

import Combine
import Foundation


public class MockAPIClient: APIClient, Cuckoo.ProtocolMock {
    
    public typealias MocksType = APIClient
    
    public typealias Stubbing = __StubbingProxy_APIClient
    public typealias Verification = __VerificationProxy_APIClient

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: APIClient?

    public func enableDefaultImplementation(_ stub: APIClient) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func perform<T: APIRequest>(request: T, _ decoder: JSONDecoder) -> AnyPublisher<T.ReturnType, Error> {
        
    return cuckoo_manager.call("perform(request: T, _: JSONDecoder) -> AnyPublisher<T.ReturnType, Error>",
            parameters: (request, decoder),
            escapingParameters: (request, decoder),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.perform(request: request, decoder))
        
    }
    

	public struct __StubbingProxy_APIClient: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func perform<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, T: APIRequest>(request: M1, _ decoder: M2) -> Cuckoo.ProtocolStubFunction<(T, JSONDecoder), AnyPublisher<T.ReturnType, Error>> where M1.MatchedType == T, M2.MatchedType == JSONDecoder {
	        let matchers: [Cuckoo.ParameterMatcher<(T, JSONDecoder)>] = [wrap(matchable: request) { $0.0 }, wrap(matchable: decoder) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAPIClient.self, method: "perform(request: T, _: JSONDecoder) -> AnyPublisher<T.ReturnType, Error>", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_APIClient: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func perform<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, T: APIRequest>(request: M1, _ decoder: M2) -> Cuckoo.__DoNotUse<(T, JSONDecoder), AnyPublisher<T.ReturnType, Error>> where M1.MatchedType == T, M2.MatchedType == JSONDecoder {
	        let matchers: [Cuckoo.ParameterMatcher<(T, JSONDecoder)>] = [wrap(matchable: request) { $0.0 }, wrap(matchable: decoder) { $0.1 }]
	        return cuckoo_manager.verify("perform(request: T, _: JSONDecoder) -> AnyPublisher<T.ReturnType, Error>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class APIClientStub: APIClient {
    

    

    
    
    
    public func perform<T: APIRequest>(request: T, _ decoder: JSONDecoder) -> AnyPublisher<T.ReturnType, Error>  {
        return DefaultValueRegistry.defaultValue(for: (AnyPublisher<T.ReturnType, Error>).self)
    }
    
}


// MARK: - Mocks generated from file: Networking/Networking/Sources/Public/Core/URLRequestSending.swift at 2022-11-15 12:10:37 +0000

//
//  URLRequestSending.swift
//  Networking
//
//  Created by Piotr Torczynski on 05/11/2022.
//

import Cuckoo
@testable import LetSwift

import Combine


public class MockURLRequestSending: URLRequestSending, Cuckoo.ProtocolMock {
    
    public typealias MocksType = URLRequestSending
    
    public typealias Stubbing = __StubbingProxy_URLRequestSending
    public typealias Verification = __VerificationProxy_URLRequestSending

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: URLRequestSending?

    public func enableDefaultImplementation(_ stub: URLRequestSending) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    public var configuration: URLSessionConfiguration {
        get {
            return cuckoo_manager.getter("configuration",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.configuration)
        }
        
    }
    

    

    
    
    
    public func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher {
        
    return cuckoo_manager.call("dataTaskPublisher(for: URLRequest) -> URLSession.DataTaskPublisher",
            parameters: (request),
            escapingParameters: (request),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.dataTaskPublisher(for: request))
        
    }
    

	public struct __StubbingProxy_URLRequestSending: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var configuration: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockURLRequestSending, URLSessionConfiguration> {
	        return .init(manager: cuckoo_manager, name: "configuration")
	    }
	    
	    
	    func dataTaskPublisher<M1: Cuckoo.Matchable>(for request: M1) -> Cuckoo.ProtocolStubFunction<(URLRequest), URLSession.DataTaskPublisher> where M1.MatchedType == URLRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(URLRequest)>] = [wrap(matchable: request) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockURLRequestSending.self, method: "dataTaskPublisher(for: URLRequest) -> URLSession.DataTaskPublisher", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_URLRequestSending: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var configuration: Cuckoo.VerifyReadOnlyProperty<URLSessionConfiguration> {
	        return .init(manager: cuckoo_manager, name: "configuration", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func dataTaskPublisher<M1: Cuckoo.Matchable>(for request: M1) -> Cuckoo.__DoNotUse<(URLRequest), URLSession.DataTaskPublisher> where M1.MatchedType == URLRequest {
	        let matchers: [Cuckoo.ParameterMatcher<(URLRequest)>] = [wrap(matchable: request) { $0 }]
	        return cuckoo_manager.verify("dataTaskPublisher(for: URLRequest) -> URLSession.DataTaskPublisher", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class URLRequestSendingStub: URLRequestSending {
        
    
    
    public var configuration: URLSessionConfiguration {
        get {
            return DefaultValueRegistry.defaultValue(for: (URLSessionConfiguration).self)
        }
        
    }
    

    

    
    
    
    public func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher  {
        return DefaultValueRegistry.defaultValue(for: (URLSession.DataTaskPublisher).self)
    }
    
}

