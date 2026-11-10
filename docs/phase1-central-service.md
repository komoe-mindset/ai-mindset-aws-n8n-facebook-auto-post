# Phase 1 — Central Service (ဗဟိုဝန်ဆောင်မှု)

> **မြန်မာ → English:** ဒီ guide သည် Phase 1 Central Service အတွက် ဖြစ်ပါတယ် — သင်တန်းသားများ content တင်ပေးပြီး၊ Ko က အတည်ပြု (approve) လုပ်ပြီး၊ Ko ရဲ့ central n8n က နေ့စဉ် မနက် ၈:၀၀ (Asia/Rangoon) မှာ auto-post တင်ပေးပါတယ်။
>
> **English:** This guide covers the Phase 1 Central Service — students submit content, Ko approves it, and Ko's central n8n posts it automatically every day at 08:00 Asia/Rangoon.

## Phase 1 Central Service ဆိုတာ ဘာလဲ? / What is it?

- သင်တန်းသားက content (စာသား + ပုံ) တင်ပေးတယ်။
- Ko က စစ်ဆေးပြီး ကောင်းတဲ့ content ကို approve လုပ်တယ်။
- Ko ရဲ့ central n8n workflow **Student-Auto-Post-Central** က နေ့စဉ် မနက် ၈:၀၀ (Asia/Rangoon) မှာ approve ထားတဲ့ post ကို Facebook / Telegram မှာ တင်ပေးတယ်။
- **သင်တန်းသားများသည် Ko ရဲ့ n8n ကို တိုက်ရိုက် သုံးခွင့် မရပါ။** Students do **NOT** get direct access to Ko's n8n.

## သင်တန်းသား ဘယ်လို တင်မလဲ? / How a student submits

Google Form **"Ai Mindset - Student Auto-Post Request (Phase 1)"** ကို ဖြည့်ပါ။

> ℹ️ Form link ကို Ko က သင်တန်းသားများထံ ပေးပါမယ်။ ဒီဖိုင်ထဲမှာ Form URL မထည့်ထားပါ — Ko က link ကို တိုက်ရိုက် မျှဝေပါမယ်။
>
> Ko shares the Form link with students directly; no Form URL is included in this file.

Form fields (ဖြည့်ရမယ့် အချက်များ):

| Field | ဖော်ပြချက် |
|---|---|
| Student Name | သင်တန်းသား အမည် |
| Platform | Facebook / Telegram / Both |
| Destination | Page API ID သို့မဟုတ် Telegram Chat ID — ကိုယ့် Page / group ရဲ့ ID (`<YOUR_PAGE_ID>` / `<YOUR_CHAT_ID>` ပုံစံ) |
| Message | တင်ချင်တဲ့ စာသား |
| Image URL | ပုံ link (ရှိရင်) |

Form တင်ပြီးတာနဲ့ အဖြေများက Google Sheet queue ထဲက **"Form Responses 1"** tab ထဲကို အလိုအလျောက် ရောက်ပါတယ် (Timestamp က အလိုအလျောက် ဖြည့်ပေးပါတယ်)။

## Flow — Form → Sheet → n8n / How it flows

1. သင်တန်းသားက **Google Form** ဖြည့်တယ်။
2. အဖြေက **"Form Responses 1"** tab ထဲ ရောက်တယ်။
3. Ko က အဲဒီ tab ထဲမှာ ကောင်းတဲ့ အတန်းကို **Status = approved** လို့ သတ်မှတ်တယ် (Status column သည် H ဖြစ်သည်)။
4. Workflow **Student-Auto-Post-Central** က **"Form Responses 1"** tab ကို တိုက်ရိုက် ဖတ်ပြီး၊ နေ့စဉ် 08:00 (Asia/Rangoon) မှာ approved post များကို Facebook / Telegram မှာ တင်ပေးတယ်။
5. တင်ပြီးတာနဲ့ Status က **posted** ဖြစ်သွားပြီး Post ID / Link ကို အတန်းထဲမှာ မှတ်ထားတယ် (Post ID / Link column သည် I ဖြစ်သည်)။

> ⚠️ **"Sheet1"** tab ထဲကို row ကူးထည့်စရာ မလိုတော့ပါ — workflow က "Form Responses 1" tab ကနေ တိုက်ရိုက် ဖတ်ပါတယ်။ No need to copy rows to "Sheet1" — the workflow reads "Form Responses 1" directly.

![Phase 1 workflow diagram](images/phase1-workflow-diagram.png)

## Ko ဘာလုပ်မလဲ? / What Ko does

1. **"Form Responses 1"** tab ကို စစ်တယ်။
2. ကောင်းတဲ့ အတန်းကို **Status = approved** လို့ သတ်မှတ်တယ်။
3. Workflow **Student-Auto-Post-Central** (Schedule Trigger — နေ့စဉ် 08:00 Asia/Rangoon) က "Form Responses 1" tab ကို တိုက်ရိုက် ဖတ်ပြီး approved post များကို Facebook / Telegram မှာ တင်ပေးတယ်။
4. တင်ပြီးတာနဲ့ Status က **posted** ဖြစ်သွားပြီး Post ID / Link ကို Sheet ထဲမှာ မှတ်ထားတယ် (matching column: Timestamp)။

## သင်တန်းသား ကိုယ်တိုင် ဖန်တီးရမယ့်အရာများ / What each student must create themselves

- ကိုယ့်ရဲ့ **Meta App + Facebook Page** ကို ကိုယ်တိုင် ဖန်တီးပါ။
- ကိုယ့်ရဲ့ **Telegram bot + channel/group** ကို ကိုယ်တိုင် ဖန်တီးပါ။
- ကိုယ့်ရဲ့ **token များ** ကို ကိုယ်တိုင် ဖန်တီးပါ။
- **Ko သည် သင်တန်းသားရဲ့ Page အတွက် သူ့ရဲ့ ကိုယ်ပိုင် Page token ကို ဘယ်တော့မှ မသုံးပါ။** Ko never uses his own Page token for a student's Page.
- ဒီ workflow သည် **TEMPLATE** ဖြစ်ပါတယ် — Ko က သင်တန်းသားတစ်ဦးစီအတွက် duplicate လုပ်ပြီး၊ အဲဒီ သင်တန်းသားရဲ့ ကိုယ်ပိုင် Facebook / Telegram credential နဲ့ အစားထိုးသုံးပါတယ်။

## ✅ Done and tested / ပြီးစီးပြီး စမ်းသပ်ပြီးသား

- ✅ **Google Form ဖန်တီးပြီးပါပြီ** — "Ai Mindset - Student Auto-Post Request (Phase 1)"၊ Form link ကို Ko က သင်တန်းသားများထံ တိုက်ရိုက် ပေးပါတယ်။
- ✅ **Google Sheet queue ချိတ်ပြီးပါပြီ** — Form အဖြေများက "Form Responses 1" tab ထဲ တိုက်ရိုက် ရောက်ပါတယ်။ Workflow ရဲ့ Read Queue / Update Queue node များက Sheet ID placeholder အစား queue Sheet ကို တိုက်ရိုက် ဖတ်ပါတယ် (tab ကို gid နဲ့ ညွှန်းပါတယ် — `<YOUR_TAB_ID>`)။
- ✅ **Google Sheets OAuth credential ချိတ်ပြီးပါပြီ** — Google Cloud project မှာ Sheets API + Drive API ဖွင့်ပြီး၊ OAuth consent (External) + test user ထည့်ပြီး n8n မှာ "Google Sheets account" အဖြစ် ချိတ်ထားပါတယ်။
- ✅ **Telegram credential ချိတ်ပြီးပါပြီ** — Telegram Send node က Telegram bot credential ကို သုံးပါတယ် (HTTP placeholder node မဟုတ်တော့ပါ)။
- ✅ **Platform routing ပြီးပါပြီ** — **Is Facebook?** / **Is Telegram?** IF node များ ပါပြီး၊ **Both** ဆိုရင် နှစ်ခုလုံး တင်ပါတယ်။
- ✅ **Tested (2026-11-10):** test row တစ်ခု Telegram မှာ တက်ပြီး၊ နောက် test row တစ်ခု Facebook မှာ တက်ပါတယ် — နှစ်ခုလုံး Status = **posted** ဖြစ်ပြီး၊ test post များကို ပြီးမှ ဖျက်ထားပါတယ်။
- ⛔ Workflow က **လက်ရှိ INACTIVE** ပါ — activate မလုပ်ခင် image branch ကို အရင် ဆုံးဖြတ်ပါ။

**ဆက်လုပ်စရာများ / Still to do:**
- **Image branch** ထည့်ပါ — Image URL ရှိရင် `sendPhoto` / photo post သုံးပြီး ပုံနဲ့တကွ တင်ပါ (လက်ရှိ text-only သာ)။
- Workflow ကို activate လုပ်မလား၊ image branch အရင် ထည့်မလား ဆုံးဖြတ်ပါ။

## 🐛 What went wrong & how we fixed it / ဘာမှားခဲ့လဲ၊ ဘယ်လိုပြင်ခဲ့လဲ

2026-11-10 မှာ workflow ကို တကယ် စမ်းသပ်ရင်း ကြုံခဲ့ရတဲ့ အမှားအစစ်တွေပါ။ အသေးစိတ်ကို README ရဲ့ troubleshooting section မှာ ကြည့်ပါ။

| # | What went wrong | How we fixed it |
|---|---|---|
| (a) | Read Queue: `Sheet with ID Form Responses 1 not found` | sheetName ကို tab **နာမည်** နဲ့ မဟုတ်ဘဲ tab **gid** (`<YOUR_TAB_ID>`, mode `id`) နဲ့ ညွှန်းပါ။ |
| (b) | Filter Approved condition က အလွတ် placeholder ပဲ ဖြစ်နေတယ် | Condition ကို **Status equals `approved`** လို့ အတိအကျ သတ်မှတ်ပါ။ |
| (c) | Split In Batches loop output မချိတ်မိလို့ Telegram ဘယ်တော့မှ မ run ဘူး | **Split In Batches node ကို ဖြုတ်ပါ** — n8n က item တစ်ခုချင်းစီကို အလိုအလျောက် run ပေးပါတယ်။ |
| (d) | Update Queue: `Column to Match On required` | Matching column ကို **Timestamp** လို့ ပေးပါ (Read Queue row က Timestamp ကနေ ယူပါ)၊ Update Queue ကို **Telegram Send ပြီးမှ** run အောင် ပြန်ချိတ်ပါ။ |
| (e) | Post ID empty after posting | Telegram က `result.message_id` ထဲမှာ၊ Facebook က `id` ထဲမှာ ထည့်ပေးပါတယ် — posting node ကနေ **`isExecuted` guard** နဲ့ တိုက်ရိုက်ဖတ်ပါ။ |

## ✅ Lesson 4 checkpoint / သင်ခန်း ၄ checkpoint

Test row တစ်ခု (Platform = **Both**) ကို approve လုပ်ပြီး workflow ကို manual run လုပ်ပါ — Telegram **နဲ့** Facebook နှစ်ခုလုံးမှာ post တက်ရပါမယ်၊ Sheet မှာ Status = **posted** + Post ID ပေါ်ရပါမယ်။ ပြီးရင် test post နှစ်ခုလုံးကို **ဖျက်ပါ**။

**🔧 Break it on purpose:** Test row ရဲ့ Status ကို `pending` လို့ တမင်ပြောင်းကြည့်ပါ — workflow run လုပ်ရင် အဲဒီ row ကို ကျော်သွားတာ (skip) ကို မြင်ရပါမယ်။ ပြီးမှ `approved` ပြန်ပြောင်းပါ။

## လုံခြုံရေး စည်းမျဉ်းများ / Security rules

- Token, password, API key, App Secret များကို chat ထဲမှာဖြစ်စေ၊ screenshot ထဲမှာဖြစ်စေ **ဘယ်တော့မှ မမျှဝေပါနဲ့**။
- သင်တန်းသားတစ်ဦးစီ ကိုယ့်ရဲ့ token များကို ကိုယ်တိုင် ထိန်းသိမ်းပါ။
- Ko ရဲ့ token များသည် n8n credentials ထဲမှာသာ ရှိရမယ် — တခြားနေရာမှာ မထားပါနဲ့။
- ဒီ repo မှာ **ID / token အစစ်တွေ လုံးဝ မပါပါ** — လိုအပ်တဲ့နေရာတိုင်းမှာ `<YOUR_SHEET_ID>`, `<YOUR_TAB_ID>`, `<YOUR_PAGE_ID>`, `<YOUR_CHAT_ID>` ဆိုတဲ့ placeholder ပဲ သုံးထားပါတယ်။
