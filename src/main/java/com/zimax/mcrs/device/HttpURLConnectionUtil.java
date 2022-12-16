package com.zimax.mcrs.device;

import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

/**
 * @Author 施林丰
 * @Date:2022/12/15 18:53
 * @Description
 */
public class HttpURLConnectionUtil {
    public static String httpGet(String url) {
        RestTemplate restTemplate = new RestTemplate();
        String result = restTemplate.exchange(url, HttpMethod.GET, null, String.class).getBody();
        return result;
    }

    public static String httpPost(String url, String name) {
        RestTemplate restTemplate = new RestTemplate();
        return restTemplate.postForEntity(url, name, String.class).getBody();
    }
    public static void UploadTest01() {
        RestTemplate restTemplate = new RestTemplate();
        //文件地址和请求url
        String filePath = "F:\\collegeCourse\\光接入";
        String fileName = "课件.zip";
        String url = "http://127.0.0.1:8080/mcrs/framework/application/upload";

        //构造请求头
        HttpHeaders headers = new HttpHeaders();
        MediaType type = MediaType.parseMediaType("multipart/form-data");
        headers.setContentType(type);

        //FileSystemResource将文件变成流以发送
        FileSystemResource fileSystemResource = new FileSystemResource(filePath+"/"+fileName);

        //构造请求体，使用LinkedMultiValueMap
        MultiValueMap<String, Object> resultMap = new LinkedMultiValueMap<>();
        resultMap.add("uploadFile", fileSystemResource);
        resultMap.add("picName", fileName);

        //HttpEntity封装整个请求报文
        HttpEntity<MultiValueMap<String, Object>> httpEntity = new HttpEntity<>(resultMap, headers);

        //postForObject发送请求体
        String result = restTemplate.postForObject(url, httpEntity, String.class);
        System.out.println("result = " + result);
    }
    public static void main(String str[]) {
        System.out.println(HttpURLConnectionUtil.httpGet("http://localhost:8080/mcrs/framework/application/download?fileName=mcrs.txt"));
        //System.out.println(HttpURLConnectionUtil.httpGet("http://127.0.0.1:8080/mcrs/framework/application/query"));
        //UploadTest01();

    }
}
