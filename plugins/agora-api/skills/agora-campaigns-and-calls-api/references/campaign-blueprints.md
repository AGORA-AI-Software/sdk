# Campaign Blueprints & Sub-Resource Payload Reference

Verified against `https://core.agoraai.tech/openapi.json`.

---

## 1. Declarative Blueprint (`POST /api/v1/campaigns/provision` & `PUT /api/v1/campaigns/{campaign_id}/blueprint`)

Schema: `CampaignBlueprintRequest`

- **Required:** `name` (string)
- **Control flags:** `dry_run` (boolean — validate without saving), `auto_launch` (boolean), `company_id`, `campaign_id`, `clone_from_campaign_id`, `template_preset`
- **Core metadata:** `description`, `campaign_type`, `pricing_model`, `commission_rate`, `flat_fee_monthly`, `cost_per_call`, `cost_per_outcome`, `agent_commission_rate`, `budget`, `max_agents`, `max_leads`, `start_date`, `end_date`, `is_hipaa_compliant`, `sms_enabled`, `allow_email_override`, `conversion_model`, `calendly_url`, `calendly_event_type_uri`, `call_script`
- **10 Subsystems (optional arrays/objects):**
  - `calling_schedule` (`BlueprintCallingSchedule`)
  - `statuses` (`BlueprintStatusItem[]`)
  - `sms_templates` (`BlueprintSmsTemplateItem[]`)
  - `email_templates` (`BlueprintEmailTemplateItem[]`)
  - `action_buttons` (`BlueprintActionButtonItem[]`)
  - `auto_sms_rules` (`BlueprintSmsRuleItem[]`)
  - `auto_email_rules` (`BlueprintEmailRuleItem[]`)
  - `scripts` (`BlueprintScriptItem[]`)
  - `education` (`BlueprintEducationConfig`)
  - `ai_config` (`BlueprintAIConfig`)
  - `phone_config` (`BlueprintPhoneConfig`)

Tip: Call `GET /api/v1/campaigns/{campaign_id}/blueprint` on an existing working campaign to export a complete, valid blueprint template you can edit and re-apply.

---

## 2. Pipeline Status (`POST /api/v1/campaigns/{campaign_id}/statuses`)

Schema: `PipelineStatusCreate`

- **Required:** `name`, `code`
- **Optional:** `description`, `color`, `is_agent_selectable`, `hides_from_agent_queue`, `requires_callback_date`, `sends_to_review`, `notify_company_email`, `notify_company_text`, `company_notification_email`, `company_notification_phone`, `outcome_type`, `is_conversion`, `is_active`, `is_default`, `notification_recipients`

```bash
curl -sS -X POST "https://core.agoraai.tech/api/v1/campaigns/${CAMPAIGN_ID}/statuses" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "Qualified Demo",
    "code": "qualified_demo",
    "outcome_type": "positive",
    "is_conversion": true,
    "is_agent_selectable": true
  }'
```

---

## 3. Campaign Script (`POST /api/v1/campaigns/{campaign_id}/scripts`)

Schema: `ScriptCreateRequest`

- **Required:** `name`, `category`, `content`
- **Optional:** `is_active`, `tags`

```bash
curl -sS -X POST "https://core.agoraai.tech/api/v1/campaigns/${CAMPAIGN_ID}/scripts" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "Opening Pitch v1",
    "category": "opening",
    "content": "Hi {{first_name}}, calling from Example Co...",
    "is_active": true,
    "tags": ["outbound"]
  }'
```

---

## 4. Agent Action Button (`POST /api/v1/campaigns/{campaign_id}/agent-action-buttons`)

Schema: `AgentActionButtonCreate`

- **Required:** `button_position`, `button_type`, `button_name`
- **Optional:** `button_warning_message`, `delivery_method`, `email_template_id`, `sms_template_id`, `landing_page_id`, `agent_form_id`, `calendly_event_type_id`, `custom_booking_url`, `after_status_id`, `commission_cents`, `is_goal_button`, `booking_commission_cents`, `showup_commission_cents`

---

## 5. Auto-Email & Auto-SMS Rules

- **By call disposition:**
  - `POST /api/v1/campaigns/{campaign_id}/auto-email-rules/disposition` (`disposition`, `template_id`, optional `delay_minutes`, `max_emails_per_lead`, `max_total_emails_per_lead`, `attempt_number`)
  - `POST /api/v1/campaigns/{campaign_id}/auto-sms-rules/disposition` (`disposition`, `template_id`, optional `delay_minutes`, `max_sms_per_lead`, `max_total_sms_per_lead`, `attempt_number`)
- **By status entry:**
  - `POST /api/v1/campaigns/{campaign_id}/auto-email-rules/status` (`status_id`, `template_id`, optional `delay_minutes`, `max_emails_per_lead`, `max_total_emails_per_lead`)
  - `POST /api/v1/campaigns/{campaign_id}/auto-sms-rules/status` (`status_id`, `template_id`, optional `delay_minutes`, `max_sms_per_lead`, `max_total_sms_per_lead`)
