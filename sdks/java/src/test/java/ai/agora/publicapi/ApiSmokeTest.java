package ai.agora.publicapi;

import ai.agora.publicapi.api.AuthenticationApi;
import ai.agora.publicapi.api.LeadsApi;
import ai.agora.publicapi.auth.HttpBearerAuth;
import ai.agora.publicapi.model.ApiKeyTokenRequest;
import ai.agora.publicapi.model.ApiKeyTokenResponse;
import ai.agora.publicapi.model.LeadInput;
import ai.agora.publicapi.model.LeadUploadRequest;
import ai.agora.publicapi.model.LeadUploadResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.concurrent.atomic.AtomicReference;
import okhttp3.Interceptor;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Protocol;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.ResponseBody;
import okio.Buffer;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

class ApiSmokeTest {
  private static ApiClient newApiClient(AtomicReference<Request> requestRef, String responseBody) {
    Interceptor interceptor =
        chain -> {
          Request request = chain.request();
          requestRef.set(request);
          return new Response.Builder()
              .request(request)
              .protocol(Protocol.HTTP_1_1)
              .code(200)
              .message("OK")
              .body(ResponseBody.create(responseBody, MediaType.get("application/json")))
              .build();
        };

    OkHttpClient httpClient = new OkHttpClient.Builder().addInterceptor(interceptor).build();
    ApiClient apiClient = new ApiClient(httpClient);
    apiClient.setBasePath("http://localhost/api/v1");
    ((HttpBearerAuth) apiClient.getAuthentication("bearerAuth")).setBearerToken("token-abc");
    return apiClient;
  }

  private static String requestBody(Request request) throws IOException {
    assertNotNull(request.body(), "request body");
    Buffer buffer = new Buffer();
    request.body().writeTo(buffer);
    return buffer.readUtf8();
  }

  @Test
  void loginWithApiKeySendsOnlyApiKeyBody() throws Exception {
    AtomicReference<Request> requestRef = new AtomicReference<>();
    ApiClient apiClient =
        newApiClient(
            requestRef,
            "{\"access_token\":\"token-123\",\"token_type\":\"Bearer\",\"expires_in\":3600}");

    AuthenticationApi api = new AuthenticationApi(apiClient);
    ApiKeyTokenResponse response = api.loginWithApiKey(new ApiKeyTokenRequest().apiKey("agora_live_test"));

    Request request = requestRef.get();
    assertNotNull(request);
    assertEquals("POST", request.method());
    assertEquals("/api/v1/auth/api-key/token", request.url().encodedPath());
    assertTrue(request.header("Authorization") == null);
    assertEquals("application/json", request.header("Content-Type"));
    assertEquals("application/json", request.header("Accept"));
    assertTrue(requestBody(request).contains("\"api_key\":\"agora_live_test\""));

    assertEquals("token-123", response.getAccessToken());
    assertEquals("Bearer", response.getTokenType());
    assertEquals(3600, response.getExpiresIn());
  }

  @Test
  void uploadLeadsSendsBearerAuthAndLeadBody() throws Exception {
    AtomicReference<Request> requestRef = new AtomicReference<>();
    ApiClient apiClient =
        newApiClient(
            requestRef,
            "{\"status\":\"accepted\",\"import_id\":\"imp_123\",\"received_count\":1,\"valid_count\":1,\"invalid_count\":0,\"errors\":[]}");

    LeadsApi api = new LeadsApi(apiClient);
    LeadUploadRequest body =
        new LeadUploadRequest()
            .campaignId(42)
            .leads(Collections.singletonList(new LeadInput().phone("+15551234567")))
            .skipDuplicates(true);
    LeadUploadResponse response = api.uploadLeads(body);

    Request request = requestRef.get();
    assertNotNull(request);
    assertEquals("POST", request.method());
    assertEquals("/api/v1/leads/upload", request.url().encodedPath());
    assertEquals("Bearer token-abc", request.header("Authorization"));
    assertEquals("application/json", request.header("Content-Type"));
    String requestBody = requestBody(request);
    assertTrue(requestBody.contains("\"campaign_id\":42"));
    assertTrue(requestBody.contains("\"compliance_acknowledged\":true"));
    assertTrue(requestBody.contains("\"source\":\"api\""));
    assertTrue(requestBody.contains("\"skip_duplicates\":true"));
    assertTrue(requestBody.contains("\"disclaimer_version\":\"v1.0\""));
    assertTrue(requestBody.contains("\"phone\":\"+15551234567\""));

    assertEquals("accepted", response.getStatus());
    assertEquals("imp_123", response.getImportId());
    assertEquals(1, response.getReceivedCount());
    assertEquals(1, response.getValidCount());
    assertEquals(0, response.getInvalidCount());
  }
}
