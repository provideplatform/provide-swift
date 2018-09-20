//
//  KTS3Service.swift
//  KTSwiftExtensions
//
//  Created by Kyle Thomas on 7/4/16.
//  Copyright © 2016 Kyle Thomas. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

public class KTS3Service: NSObject {

    public class func presign(_ url: URL,
                              filename: String,
                              metadata: [String: String],
                              headers: [String: String],
                              successHandler: KTApiSuccessHandler?,
                              failureHandler: KTApiFailureHandler?) {
        presign(url, bucket: nil, filename: filename, metadata: metadata, headers: headers, successHandler: successHandler, failureHandler: failureHandler)
    }

    public class func presign(_ url: URL,
                              bucket: String?,
                              filename: String,
                              metadata: [String: String],
                              headers: [String: String],
                              successHandler: KTApiSuccessHandler?,
                              failureHandler: KTApiFailureHandler?) {
        var params = ["filename": filename, "metadata": metadata.toJSONString()]
        params["bucket"] = bucket
        let request: DataRequest = Alamofire.request(url, method: .get, parameters: params, headers: headers)
        KTApiService.shared.execute(request, successHandler: successHandler, failureHandler: failureHandler)
    }

    public class func upload(_ presignedS3Request: KTPresignedS3Request,
                             data: Data,
                             withMimeType mimeType: String,
                             successHandler: KTApiSuccessHandler?,
                             failureHandler: KTApiFailureHandler?) {
        if presignedS3Request.fields != nil {
            let request: DataRequest = Alamofire.request(presignedS3Request.url, method: .post, headers: presignedS3Request.signedHeaders)
            Alamofire.upload(multipartFormData: { multipartFormData in
                for (name, value) in presignedS3Request.fields {
                    let data = value.data(using: .utf8, allowLossyConversion: false)!
                    multipartFormData.append(data as Data, withName: name)
                }
                multipartFormData.append(data, withName: "file", fileName: "filename", mimeType: mimeType)
            }, with: request.request!,
               encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let request, _, _):
                    KTApiService.shared.execute(request as DataRequest, successHandler: successHandler, failureHandler: failureHandler)
                case .failure(let encodingError):
                    logWarn("Multipart upload not attempted due to encoding error; \(encodingError)")
                }
            })
        } else {
            let request: DataRequest = Alamofire.upload(data, to: presignedS3Request.url, method: .put, headers: presignedS3Request.signedHeaders)
            KTApiService.shared.execute(request, successHandler: successHandler, failureHandler: failureHandler)
        }
    }
}
