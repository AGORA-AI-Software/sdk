package agorapublicapi

import (
	"context"
	"encoding/json"
	"io"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
)

func newSmokeClient(t *testing.T, handler http.HandlerFunc) *APIClient {
	t.Helper()

	server := httptest.NewServer(handler)
	t.Cleanup(server.Close)

	cfg := NewConfiguration()
	cfg.Servers = ServerConfigurations{{URL: server.URL + "/api/v1"}}

	return NewAPIClient(cfg)
}

func readJSONMap(t *testing.T, r io.Reader) map[string]any {
	t.Helper()

	var payload map[string]any
	if err := json.NewDecoder(r).Decode(&payload); err != nil {
		t.Fatalf("decode request body: %v", err)
	}

	return payload
}

func TestLoginWithApiKeySmoke(t *testing.T) {
	client := newSmokeClient(t, func(w http.ResponseWriter, r *http.Request) {
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

		body := readJSONMap(t, r.Body)
		if got, want := body["api_key"], "agora_live_test"; got != want {
			t.Fatalf("api_key = %v, want %v", got, want)
		}

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)
		_, _ = w.Write([]byte(`{"access_token":"token-123","token_type":"Bearer","expires_in":3600}`))
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
	client := newSmokeClient(t, func(w http.ResponseWriter, r *http.Request) {
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

		body := readJSONMap(t, r.Body)
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

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusAccepted)
		_, _ = w.Write([]byte(`{"status":"accepted","import_id":"imp_123","received_count":1,"valid_count":1,"invalid_count":0,"errors":[]}`))
	})

	ctx := context.WithValue(context.Background(), ContextAccessToken, "token-abc")
	cfg := client.cfg
	cfg.HTTPClient = http.DefaultClient

	_, _, err := client.LeadsAPI.
		UploadLeads(ctx).
		LeadUploadRequest(*NewLeadUploadRequest(42, []LeadInput{*NewLeadInput("+15551234567")}, true)).
		Execute()
	if err != nil {
		t.Fatalf("UploadLeads returned error: %v", err)
	}
}
