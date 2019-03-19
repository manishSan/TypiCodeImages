// MARK: - Mocks generated from file: TypiCodeImages/ApiClient/ApiClientProtocol.swift at 2019-03-19 21:19:36 +0000

//
//  ApiClientProtocol.swift
//  TypiCodeImages
//
//  Created by Sanwal, Manish on 3/19/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Cuckoo
@testable import TypiCodeImages

import Foundation
import RxSwift


 class MockApiClientProtocol: ApiClientProtocol, Cuckoo.ProtocolMock {
     typealias MocksType = ApiClientProtocol
     typealias Stubbing = __StubbingProxy_ApiClientProtocol
     typealias Verification = __VerificationProxy_ApiClientProtocol

    private var __defaultImplStub: ApiClientProtocol?

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

     func enableDefaultImplementation(_ stub: ApiClientProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    

    

    
    
    
     func images()  -> Single<Result<[ImageProtocol]>> {
        
            return cuckoo_manager.call("images() -> Single<Result<[ImageProtocol]>>",
                parameters: (),
                escapingParameters: (),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.images())
        
    }
    
    
    
     func image(forUrl: URL)  -> Single<UIImage?> {
        
            return cuckoo_manager.call("image(forUrl: URL) -> Single<UIImage?>",
                parameters: (forUrl),
                escapingParameters: (forUrl),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.image(forUrl: forUrl))
        
    }
    

	 struct __StubbingProxy_ApiClientProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func images() -> Cuckoo.ProtocolStubFunction<(), Single<Result<[ImageProtocol]>>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockApiClientProtocol.self, method: "images() -> Single<Result<[ImageProtocol]>>", parameterMatchers: matchers))
	    }
	    
	    func image<M1: Cuckoo.Matchable>(forUrl: M1) -> Cuckoo.ProtocolStubFunction<(URL), Single<UIImage?>> where M1.MatchedType == URL {
	        let matchers: [Cuckoo.ParameterMatcher<(URL)>] = [wrap(matchable: forUrl) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockApiClientProtocol.self, method: "image(forUrl: URL) -> Single<UIImage?>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ApiClientProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func images() -> Cuckoo.__DoNotUse<Single<Result<[ImageProtocol]>>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("images() -> Single<Result<[ImageProtocol]>>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func image<M1: Cuckoo.Matchable>(forUrl: M1) -> Cuckoo.__DoNotUse<Single<UIImage?>> where M1.MatchedType == URL {
	        let matchers: [Cuckoo.ParameterMatcher<(URL)>] = [wrap(matchable: forUrl) { $0 }]
	        return cuckoo_manager.verify("image(forUrl: URL) -> Single<UIImage?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}

}

 class ApiClientProtocolStub: ApiClientProtocol {
    

    

    
     func images()  -> Single<Result<[ImageProtocol]>> {
        return DefaultValueRegistry.defaultValue(for: Single<Result<[ImageProtocol]>>.self)
    }
    
     func image(forUrl: URL)  -> Single<UIImage?> {
        return DefaultValueRegistry.defaultValue(for: Single<UIImage?>.self)
    }
    
}


// MARK: - Mocks generated from file: TypiCodeImages/Networking/NetworkProtocol.swift at 2019-03-19 21:19:36 +0000

//
//  NetworkProtocol.swift
//  TypiCodeImages
//
//  Created by Sanwal, Manish on 3/18/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Cuckoo
@testable import TypiCodeImages

import Foundation
import Moya
import RxSwift


 class MockNetworkProtocol: NetworkProtocol, Cuckoo.ProtocolMock {
     typealias MocksType = NetworkProtocol
     typealias Stubbing = __StubbingProxy_NetworkProtocol
     typealias Verification = __VerificationProxy_NetworkProtocol

    private var __defaultImplStub: NetworkProtocol?

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

     func enableDefaultImplementation(_ stub: NetworkProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    

    

    
    
    
     func fetchImages()  -> Single<Result<Data>> {
        
            return cuckoo_manager.call("fetchImages() -> Single<Result<Data>>",
                parameters: (),
                escapingParameters: (),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.fetchImages())
        
    }
    
    
    
     func downloadImage(url: URL)  -> Single<Result<Data>> {
        
            return cuckoo_manager.call("downloadImage(url: URL) -> Single<Result<Data>>",
                parameters: (url),
                escapingParameters: (url),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.downloadImage(url: url))
        
    }
    

	 struct __StubbingProxy_NetworkProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func fetchImages() -> Cuckoo.ProtocolStubFunction<(), Single<Result<Data>>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockNetworkProtocol.self, method: "fetchImages() -> Single<Result<Data>>", parameterMatchers: matchers))
	    }
	    
	    func downloadImage<M1: Cuckoo.Matchable>(url: M1) -> Cuckoo.ProtocolStubFunction<(URL), Single<Result<Data>>> where M1.MatchedType == URL {
	        let matchers: [Cuckoo.ParameterMatcher<(URL)>] = [wrap(matchable: url) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockNetworkProtocol.self, method: "downloadImage(url: URL) -> Single<Result<Data>>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_NetworkProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func fetchImages() -> Cuckoo.__DoNotUse<Single<Result<Data>>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("fetchImages() -> Single<Result<Data>>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func downloadImage<M1: Cuckoo.Matchable>(url: M1) -> Cuckoo.__DoNotUse<Single<Result<Data>>> where M1.MatchedType == URL {
	        let matchers: [Cuckoo.ParameterMatcher<(URL)>] = [wrap(matchable: url) { $0 }]
	        return cuckoo_manager.verify("downloadImage(url: URL) -> Single<Result<Data>>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}

}

 class NetworkProtocolStub: NetworkProtocol {
    

    

    
     func fetchImages()  -> Single<Result<Data>> {
        return DefaultValueRegistry.defaultValue(for: Single<Result<Data>>.self)
    }
    
     func downloadImage(url: URL)  -> Single<Result<Data>> {
        return DefaultValueRegistry.defaultValue(for: Single<Result<Data>>.self)
    }
    
}

