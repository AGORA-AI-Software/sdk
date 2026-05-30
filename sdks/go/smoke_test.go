package agorapublicapi

import (
	"bytes"
	"context"
	"encoding/json"
	"io"
	"net/http"
	"strings"
	"testing"
)

type smokeRoundTripper struct {
	t       *testing.T
	handler func(*http.Request) *http.Response
}

func (s smokeRoundTripper) RoundTrip(req *http.Request) (*http.Response, error) {
	return s.handler(req), nil
}

func newSmokeClient(t *testing.T, handler func(*http.Request) *http.Response) *APIClient {
	t.Helper()

	cfg := NewConfiguration()
	cfg.Servers = ServerConfigurations{{URL: "http://example.invalid/api/v1"}}
	cfg.HTTPClient = &http.Client{Transport: smokeRoundTripper{t: t, handler: handler}}

	return NewAPIClient(cfg)
}

func readJSONMap(t *testing.T, r *http.Request) map[string]any {
	t.Helper()

	var payload map[string]any
	if err := json.NewDecoder(r.Body).Decode(&payload); err != nil {
		t.Fatalf("decode request body: %v", err)
	}

	return payload
}

func readJSONMapFromReader(t *testing.T, reader io.Reader) map[string]any {
	t.Helper()

	var payload map[string]any
	if err := json.NewDecoder(reader).Decode(&payload); err != nil {
		t.Fatalf("decode request body: %v", err)
	}

	return payload
}

func TestLoginWithApiKeySmoke(t *testing.T) {
	client := newSmokeClient(t, func(r *http.Request) *http.Response {
		if got, want := r.Method, http.MethodPost; got != want {
			t.Fatalf("method = %s, want %s", got, want)
		}
		if got, want := r.URL.Path, "/api/v1/auth/api-key/token"; got != want {
			t.Fatalf("path = %s, want %s", got, want)
		}
		if got := r.Header.Get("Authorization"); got != "" {
			t.Fatalf("authorization header = %q, want empty", got)
		}
		if got, want := r.Header.Get("Content-Type"), "application/json"; got != want {
			t.Fatalf("content-type = %s, want %s", got, want)
		}
		if got, want := r.Header.Get("Accept"), "application/json"; got != want {
			t.Fatalf("accept = %s, want %s", got, want)
		}

		body := readJSONMapFromReader(t, r.Body)
		if got, want := body["api_key"], "agora_live_test"; got != want {
			t.Fatalf("api_key = %v, want %v", got, want)
		}

		return &http.Response{
			StatusCode: http.StatusOK,
			Header:     http.Header{"Content-Type": []string{"application/json"}},
			Body:       ioNopCloser(bytes.NewBufferString(`{"access_token":"token-123","token_type":"Bearer","expires_in":3600}`)),
		}
	})

	resp, _, err := client.AuthenticationAPI.
		LoginWithApiKey(context.Background()).
		ApiKeyTokenRequest(*NewApiKeyTokenRequest("agora_live_test")).
		Execute()
	if err != nil {
		t.Fatalf("LoginWithApiKey returned error: %v", err)
	}

	if got, want := resp.GetAccessToken(), "token-123"; got != want {
		t.Fatalf("access token = %s, want %s", got, want)
	}
	if got, want := resp.GetTokenType(), "Bearer"; got != want {
		t.Fatalf("token type = %s, want %s", got, want)
	}
	if got, want := resp.GetExpiresIn(), int32(3600); got != want {
		t.Fatalf("expires in = %d, want %d", got, want)
	}
}

func TestUploadLeadsSmoke(t *testing.T) {
	client := newSmokeClient(t, func(r *http.Request) *http.Response {
		if got, want := r.Method, http.MethodPost; got != want {
			t.Fatalf("method = %s, want %s", got, want)
		}
		if got, want := r.URL.Path, "/api/v1/leads/upload"; got != want {
			t.Fatalf("path = %s, want %s", got, want)
		}
		if got, want := r.Header.Get("Authorization"), "Bearer token-abc"; got != want {
			t.Fatalf("authorization header = %q, want %q", got, want)
		}
		if got, want := r.Header.Get("Content-Type"), "application/json"; got != want {
			t.Fatalf("content-type = %s, want %s", got, want)
		}

		body := readJSONMap(t, r)
		if got, want := body["campaign_id"], float64(42); got != want {
			t.Fatalf("campaign_id = %v, want %v", got, want)
		}
		if got, want := body["compliance_acknowledged"], true; got != want {
			t.Fatalf("compliance_acknowledged = %v, want %v", got, want)
		}
		if got, want := body["source"], "api"; got != want {
			t.Fatalf("source = %v, want %v", got, want)
		}
		if got, want := body["skip_duplicates"], true; got != want {
			t.Fatalf("skip_duplicates = %v, want %v", got, want)
		}
		if got, want := body["disclaimer_version"], "v1.0"; got != want {
			t.Fatalf("disclaimer_version = %v, want %v", got, want)
		}

		leads, ok := body["leads"].([]any)
		if !ok || len(leads) != 1 {
			t.Fatalf("leads = %#v, want one element", body["leads"])
		}
		lead, ok := leads[0].(map[string]any)
		if !ok {
			t.Fatalf("lead = %#v, want map", leads[0])
		}
		if got, want := lead["phone"], "+15551234567"; got != want {
			t.Fatalf("lead.phone = %v, want %v", got, want)
		}
		if len(strings.TrimSpace(r.Header.Get("Accept"))) == 0 {
			t.Fatal("accept header is empty")
		}

		return &http.Response{
			StatusCode: http.StatusAccepted,
			Header:     http.Header{"Content-Type": []string{"application/json"}},
			Body:       ioNopCloser(bytes.NewBufferString(`{"status":"accepted","import_id":"imp_123","received_count":1,"valid_count":1,"invalid_count":0,"errors":[]}`)),
		}
	})

	ctx := context.WithValue(context.Background(), ContextAccessToken, "token-abc")

	_, _, err := client.LeadsAPI.
		UploadLeads(ctx).
		LeadUploadRequest(*NewLeadUploadRequest(42, []LeadInput{*NewLeadInput("+15551234567")}, true)).
		Execute()
	if err != nil {
		t.Fatalf("UploadLeads returned error: %v", err)
	}
}

type nopCloser struct {
	*bytes.Buffer
}

func (n nopCloser) Close() error { return nil }

func ioNopCloser(buf *bytes.Buffer) io.ReadCloser {
	return nopCloser{Buffer: buf}
}
