//
//  NetworkUtils.swift
//  TypiCodeImages
//
//  Created by Sanwal, Manish on 3/18/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
import Moya

struct NetworkUtils {
    /**
     Convenience overloaded method to get RxMoyaProvider to make the webservice call.=
     - Parameter: -
     sourceBehaviour: A sourceBehaviour enum value, the method would decide endPoint closure and stub closure .
     Logic -
     case .live:
     stubClosure = MoyaProvider.neverStub
     endpointClosure = token.defaultEndpointMapping
     case .stubbed:
     stubClosure = MoyaProvider.immediatelyStub
     endpointClosure = token.stubEndpoint
     T is TargetType

     - Throws: -
     - Returns: RxMoyaProvider<T>
     */
    public static func imageDataProvider <T: TargetType> (sourceBehaviour: SourceBehavior) -> MoyaProvider<T> {

        let stubClosure: MoyaProvider<T>.StubClosure
        let endpointClosure: MoyaProvider<T>.EndpointClosure
        switch sourceBehaviour {
        case .live:
            stubClosure = MoyaProvider.neverStub
            endpointClosure = endPointWithUserAgent()
        case .stubbed:
            stubClosure = MoyaProvider.immediatelyStub
            endpointClosure = NetworkUtils.stubEndPoint()
        case .stubbedWithDelay(let seconds):
            stubClosure = MoyaProvider.delayedStub(seconds)
            endpointClosure = NetworkUtils.stubEndPoint()
        }

        return self.dataProvider(endpointClosure: endpointClosure, stubClosure: stubClosure)
    }

    /**
     Convenience method to get MoyaProvider to make the webservice call.
     - Parameter: -
     endpointClosure: A custom MoyaProvider.EndpointClosure to be used for the request.
     The parameter has a default value => MoyaProvider.defaultEndpointMapping

     stubClosure: A custom MoyaProvider.StubClosure to be used for the request.
     The parameter has a default value => MoyaProvider.neverStub

     T is TargetType

     - Throws: -
     - Returns: MoyaProvider<T>
     */
    private static func dataProvider <T: TargetType> (endpointClosure: @escaping MoyaProvider<T>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
                                                      stubClosure: @escaping MoyaProvider<T>.StubClosure = MoyaProvider.neverStub) -> MoyaProvider<T> {
        return MoyaProvider<T>(endpointClosure: endpointClosure, stubClosure: stubClosure)
    }

    /**
     Returns a stub end point to be used to create Moya network providers, this method uses EndPoint.sampleData for the stub
     - Parameter: -
     - Throws: -
     - Returns: (_: T) -> Endpoint<T>
     */
    private static func stubEndPoint <T: TargetType> () -> (_: T) -> Endpoint {
        let endpointClosure = { (target: T) -> Endpoint in
            return Endpoint(url: "localhost.com",
                            sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: nil)
        }
        return endpointClosure
    }

    /**
     Returns a stub end point to be used to create Moya network providers, this method uses EndPoint.sampleData for the stub
     - Parameter: -
     - Throws: -
     - Returns: (_: T) -> Endpoint<T>
     */
    private static func endPointWithUserAgent <T: TargetType> () -> (_: T) -> Endpoint {
        let endpointClosure = { (target: T) -> Endpoint in

            let urlString = target.baseURL.appendingPathComponent(target.path).absoluteString
            let endpoint = Endpoint(url: urlString,
                                    sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                                    method: target.method,
                                    task: target.task,
                                    httpHeaderFields: target.headers)
            return endpoint
        }
        return endpointClosure
    }
}
