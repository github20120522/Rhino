import okhttp3.*;
import xyz.hearthfire.utils.BaseUtil;
import xyz.hearthfire.xml.dss.response.Dss;

import java.io.File;
import java.util.Date;
import java.util.concurrent.TimeUnit;

/**
 * Created by fz on 2016/4/18.
 */
public class OkHttpClientTest {

    public static void main(String[] args) throws Exception {

        File file = new File("README.md");
        OkHttpClient client = new OkHttpClient
                .Builder()
                .connectTimeout(5, TimeUnit.SECONDS)
                .readTimeout(5, TimeUnit.SECONDS)
                .writeTimeout(5, TimeUnit.SECONDS)
                .build();
        RequestBody requestBody = RequestBody.create(MediaType.parse("application/octet-stream;charset=utf-8"), file);
        Request request = new Request
                .Builder()
                .url("http://middleware.cloud.cainiao.com/dss/putObject.do")
                .header("Content-Type", "application/octet-stream;charset=utf-8")
                .addHeader("Date", SignGenTest.parseGMT(new Date()))
                .addHeader("Auth", SignGenTest.genSign("yichun", "yichun", "POST", "application/octet-stream;charset=utf-8", null, null, null))
                .addHeader("OrderType", "OrderType")
                .addHeader("OrderNo", "OrderNo")
                .addHeader("ObjectName", "ObjectName")
                .post(requestBody)
                .build();
        Response response = client.newCall(request).execute();
        String content = response.body().string();
        Dss dss = BaseUtil.JAXBUnMarshal(content, Dss.class);
        System.out.println("requestId: " + dss.getRequestId());
        System.out.println("code: " + dss.getCode());
        System.out.println("message: " + dss.getMessage());
        System.out.println("url: " + dss.getUrl());
        System.out.println("objectName: " + dss.getObjectName());
    }

}
