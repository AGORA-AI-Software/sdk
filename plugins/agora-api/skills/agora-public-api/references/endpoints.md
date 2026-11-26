# AGORA Public API — Complete Live Endpoint Reference (38 Endpoints)

Verified against `GET https://core.agoraai.tech/openapi.json` and `GET https://core-dev.agoraai.tech/openapi.json`.

Base URLs:
- Production: `https://core.agoraai.tech`
- Development: `https://core-dev.agoraai.tech`

---

## 1. Authentication (1 endpoint)

| Method | Path | `operationId` | Auth | Summary |
|---|---|---|---|---|
| `POST` | `/api/v1/auth/api-key/token` | `exchangeApiKeyForToken` | Public (API key in JSON body) | Exchange `{"api_key":"agora_live_..."}` for a 300s bearer JWT (`access_token`, `token_type`, `expires_in`). |

## 2. Compliance (2 endpoints)

| Method | Path | `operationId` | Auth | Summary |
|---|---|---|---|---|
| `GET` | `/api/v1/legal/documents/lead-upload-compliance` | `getLeadUploadDisclaimer` | Public | Return current DNC/TCPA agreement (`slug`, `version`, `text`, `effective_date`). Echo `version` as `disclaimer_version` on lead upload. |
| `GET` | `/api/v1/legal/documents/lead-upload-compliance/versions` | `listLeadUploadDisclaimerVersions` | Public | List all published versions of the lead upload agreement (`is_current`, `is_deprecated`). |

## 3. Leads (8 endpoints + campaign statuses)

| Method | Path | `operationId` | Auth | Key Parameters / Body |
|---|---|---|---|---|
| `GET` | `/api/v1/leads/` | `list_leads_api_v1_leads__get` | Bearer | Required query `campaign_id`; optional `status_value`, `priority`, `assigned_to`, `search`, `import_id`, `external_id`, `after_id`, `page`, `per_page`, `sort_by`, `sort_dir`, `tab`, `exclude_statuses`, `exclude_queued`, `timezone`, `call_attempts`, `min_call_attempts`, `last_called_timeframe`, `added_today`, `claimed_only`. |
| `POST` | `/api/v1/leads/upload` | `uploadLeads` | Bearer | Body `LeadUploadRequest` (required: `campaign_id`, `leads`, `compliance_acknowledged: true`, `disclaimer_version`). Returns `202 Accepted` with `import_id`. |
| `GET` | `/api/v1/leads/upload/{import_id}` | `get_upload_status_api_v1_leads_upload__import_id__get` | Bearer | Poll async JSON upload job status and row-level results. |
| `GET` | `/api/v1/leads/{lead_id}` | `getLead` | Bearer | Optional query `include`. Returns lead details for campaigns owned by caller (`404` otherwise). |
| `PATCH` | `/api/v1/leads/{lead_id}` | `updateLead` | Bearer | Body `LeadUpdateRequest`: ONLY `priority`, `notes`, `custom_fields` (merged non-destructively; pass `null` to delete a key). |
| `DELETE` | `/api/v1/leads/{lead_id}` | `deleteLead` | Bearer | Soft-deletes the lead (`204 No Content`), preserving the underlying contact. |
| `PATCH` | `/api/v1/leads/{lead_id}/profile` | `updateLeadProfile` | Bearer | Body `ContactUpdate`: update contact profile fields (`first_name`, `last_name`, `email`, `phone`, `company_name`, `job_title`, `external_id`, `tags`, `custom_fields`, etc.). |
| `PATCH` | `/api/v1/leads/{lead_id}/status` | `updateLeadStatus` | Bearer | Body `LeadStatusUpdateRequest`: Public API callers pass `to_status_code` (from `GET /api/v1/campaigns/{campaign_id}/statuses`), plus optional `reason` and `callback_at`. |

## 4. Campaigns (23 endpoints)

| Method | Path | `operationId` | Auth | Summary |
|---|---|---|---|---|
| `GET` | `/api/v1/campaigns/accessible` | `listAccessibleCampaigns` | Bearer | Paginated (`page`, `per_page`) list of campaigns the caller owns or may act on. |
| `POST` | `/api/v1/campaigns/` | `createCampaign` | Bearer | Create a campaign (`company_id`, `name`, `campaign_type`, `pricing_model`, plus optional script/schedule/conversion fields). Returns `201`. |
| `GET` | `/api/v1/campaigns/blueprints` | `listCampaignBlueprints` | Bearer | List curated industry Campaign Blueprint Starter Packs. |
| `POST` | `/api/v1/campaigns/provision` | `provisionCampaign` | Bearer | Atomically provision a full campaign across 10 subsystems (`CampaignBlueprintRequest`, supports `dry_run: true`, `auto_launch`). Returns `201`. |
| `GET` | `/api/v1/campaigns/{campaign_id}/blueprint` | `exportCampaignBlueprint` | Bearer | Export an existing campaign's full configuration as a reusable declarative blueprint. |
| `PUT` | `/api/v1/campaigns/{campaign_id}/blueprint` | `applyCampaignBlueprint` | Bearer | Update an existing campaign with a declarative blueprint (`CampaignBlueprintRequest`). |
| `POST` | `/api/v1/campaigns/{campaign_id}/apply-blueprint` | `applyStarterBlueprintPack` | Bearer | Apply a starter pack (`blueprint_key`, optional `override_service_name`, `calendly_scheduling_url`). |
| `POST` | `/api/v1/campaigns/{campaign_id}/clone` | `cloneCampaign` | Bearer | Clone a campaign (`new_name`, `include_automations`, `include_scoring_rules`, `include_custom_fields`, `attach_shared_company_phones`). |
| `POST` | `/api/v1/campaigns/{campaign_id}/duplicate` | `duplicateCampaign` | Bearer | Duplicate an existing campaign. |
| `GET` | `/api/v1/campaigns/{campaign_id}/readiness` | `getCampaignReadinessAudit` | Bearer | 8-domain setup readiness scorecard (percentage, launch eligibility, quick-fix actions). |
| `GET` | `/api/v1/campaigns/{campaign_id}/launch-readiness` | `getCampaignLaunchReadiness` | Bearer | Validate launch readiness and phone configuration (blocking errors & warnings). |
| `GET` | `/api/v1/campaigns/{campaign_id}/statuses` | `listCampaignStatuses` | Bearer | List pipeline statuses (query: `include_counts`). Use returned `code` values with `PATCH /api/v1/leads/{lead_id}/status`. |
| `POST` | `/api/v1/campaigns/{campaign_id}/statuses` | `createCampaignStatus` | Bearer | Create a pipeline status (`name`, `code`, `outcome_type`, `is_conversion`, etc.). Returns `201`. |
| `GET` | `/api/v1/campaigns/{campaign_id}/scripts` | `listCampaignScripts` | Bearer | List scripts (optional query: `category`, `is_active`, `lead_id`). |
| `POST` | `/api/v1/campaigns/{campaign_id}/scripts` | `createCampaignScript` | Bearer | Create a script (`name`, `category`, `content`, `is_active`, `tags`). Returns `201`. |
| `GET` | `/api/v1/campaigns/{campaign_id}/agent-action-buttons` | `listCampaignActionButtons` | Bearer | List agent toolkit action buttons (optional query: `company_id`). |
| `POST` | `/api/v1/campaigns/{campaign_id}/agent-action-buttons` | `createCampaignActionButton` | Bearer | Create an agent action button (`button_position`, `button_type`, `button_name`, template/booking IDs). |
| `GET` | `/api/v1/campaigns/{campaign_id}/auto-email-rules` | `listCampaignAutoEmailRules` | Bearer* | List call-disposition and status-entry auto-email rules. (*Always pass Bearer token.) |
| `POST` | `/api/v1/campaigns/{campaign_id}/auto-email-rules/disposition` | `createCampaignEmailDispositionRule` | Bearer | Create a call-disposition email rule (`disposition`, `template_id`, `delay_minutes`, caps). Returns `201`. |
| `POST` | `/api/v1/campaigns/{campaign_id}/auto-email-rules/status` | `createCampaignEmailStatusRule` | Bearer | Create a status-entry email rule (`status_id`, `template_id`, `delay_minutes`, caps). Returns `201`. |
| `GET` | `/api/v1/campaigns/{campaign_id}/auto-sms-rules` | `listCampaignAutoSmsRules` | Bearer* | List call-disposition and status-entry auto-SMS rules. (*Always pass Bearer token.) |
| `POST` | `/api/v1/campaigns/{campaign_id}/auto-sms-rules/disposition` | `createCampaignSmsDispositionRule` | Bearer | Create a call-disposition SMS rule (`disposition`, `template_id`, `delay_minutes`, caps). Returns `201`. |
| `POST` | `/api/v1/campaigns/{campaign_id}/auto-sms-rules/status` | `createCampaignSmsStatusRule` | Bearer | Create a status-entry SMS rule (`status_id`, `template_id`, `delay_minutes`, caps). Returns `201`. |

## 5. Calls (1 endpoint)

| Method | Path | `operationId` | Auth | Key Parameters |
|---|---|---|---|---|
| `GET` | `/api/v1/calls/` | `listCalls` | Bearer | Optional query: `campaign_id`, `lead_id`, `since`, `until`, `updated_since`, `disposition`, `status`, `direction`, `after_id`, `page`, `per_page`, `sort_by`, `sort_dir`. Returns `calls[]`, `total`, `page`, `per_page`, `total_pages`, `next_after_id`. |

## 6. Webhooks (3 endpoints, read-only)

| Method | Path | `operationId` | Auth | Summary |
|---|---|---|---|---|
| `GET` | `/api/v1/webhooks/{campaign_id}/events` | `listWebhookEventTypes` | Bearer | List all 8 subscribable event type strings (`lead.created`, `leads.bulk_created`, `lead.status_changed`, `lead.converted`, `call.started`, `call.completed`, `call.outcome_recorded`, `form.submitted`). |
| `GET` | `/api/v1/webhooks/{campaign_id}/endpoints` | `listWebhookEndpoints` | Bearer | List configured endpoints (`WebhookEndpointSummary[]`, no signing secrets). |
| `GET` | `/api/v1/webhooks/{campaign_id}/endpoints/{endpoint_id}/health` | `getWebhookEndpointHealth` | Bearer | Delivery health snapshot (`total_deliveries`, `successful_deliveries`, `failed_deliveries`, `success_rate`, `last_delivery_at`, `avg_duration_ms`). |
