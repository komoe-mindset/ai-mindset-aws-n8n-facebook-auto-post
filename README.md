# Ai Mindset — AWS + n8n + Facebook Auto-Post (သင်ခန်းစာ)

> **မြန်မာ → English:** ဤ guide သည် ကို (Aung Zaw Moe) ၏ အမှန်တကယ် လုပ်ခဲ့သော project ဖြစ်ပါတယ် — 2026-11-09 မှ 2026-11-10 အတွင်း AWS အကောင့်အသစ်၊ $200 credit၊ Lightsail VPS၊ n8n၊ Meta App နှင့် Facebook Page auto-post ကို အဆင့်ဆင့် တည်ဆောက်ခဲ့သည်။ သင်တန်းသားများ ကိုယ်တိုင် လိုက်လုပ်နိုင်အောင် အမှားများပါ ထည့်ရေးထားပါတယ်။
>
> **English:** This guide documents Ko's real build from 2026-11-09 to 2026-11-10 — a new AWS account, $200 credit, a Lightsail VPS, n8n, a Meta App, and Facebook Page auto-posting — including the mistakes, so students can follow it hands-on.

**Live result / ရလဒ်:** Facebook Page **AI Mindset Academy** မှာ နေ့စဉ် မနက် ၈:၀၀ (Asia/Rangoon) auto-post ၁ ခု တင်နိုင်တဲ့ n8n workflow **FB-Auto-Post** အလုပ်လုပ်နေပါပြီ (လက်ရှိ **inactive** — အကြောင်းအရာအစစ် မထည့်ရသေးလို့)။

**Live links (public, safe to share):**

| Item | Value |
|---|---|
| n8n | https://n8n.komoe.org/ |
| Facebook Page | AI Mindset Academy — https://www.facebook.com/profile.php?id=<YOUR_PAGE_URL_ID> |
| Meta App ID | `<YOUR_APP_ID>` |
| Page API ID | `<YOUR_PAGE_ID>` |
| VPS static IP | `<YOUR_VPS_IP>` |
| Workflow | FB-Auto-Post, id `<YOUR_WORKFLOW_ID>` |

> 🔒 **Security rule / လုံခြုံရေးစည်းမျဉ်း:** ဒီ repo မှာ **token, password, API key, App Secret, .pem, ဖုန်းနံပါတ် လုံးဝမပါပါ**။ လိုအပ်တဲ့နေရာတိုင်းမှာ `<YOUR_TOKEN>`, `<YOUR_APP_SECRET>`, `<YOUR_PAGE_ID>` ဆိုတဲ့ placeholder ပဲ သုံးထားပါတယ်။ Token/secret တွေကို chat မှာရော screenshot မှာပါ ဘယ်တော့မှ မမျှပါနဲ့။
>
> 🔒 **Security rule:** This repo contains **no token, password, API key, App Secret, .pem content, or phone number**. Everywhere a value is needed you will see a placeholder like `<YOUR_TOKEN>`. Never share tokens or secrets in chat or screenshots.

---

## ✅ Requirements checklist / လိုအပ်ချက်များ

- [ ] AWS account (အသစ် — Free plan, credit ရဖို့)
- [ ] Visa/Mastercard (AWS signup verification အတွက်; $1 hold လောက် ဖြစ်နိုင်ပါတယ်)
- [ ] Domain တစ်ခု (Ko: `komoe.org`, Cloudflare DNS)
- [ ] Facebook Page တစ်ခု (Ko: **AI Mindset Academy** — ကိုယ်တိုင် admin ဖြစ်ရမည်)
- [ ] Meta Developer account (https://developers.facebook.com)
- [ ] Email တစ်ခု (Ko: `komoeybs@gmail.com` — Google AI Pro ရှိတဲ့ email ကို သုံးပါ)
- [ ] SSH client (Windows: PowerShell / PuTTY; Mac/Linux: Terminal)
- [ ] ကိုယ်ပိုင် Facebook account (personal profile ကို API နဲ့ auto-post **လို့မရပါ** — Page ပဲ ရပါတယ်)

---

## 💰 Cost table / ကုန်ကျစရိတ်

| Item | Cost | Note |
|---|---|---|
| AWS new account signup credit | **+$100** | အကောင့်အသစ်ဖွင့်တာနဲ့ ရပါတယ် |
| 5 onboarding tasks × $20 | **+$100** | အောက်က Phase 1 ကို ကြည့်ပါ |
| **Total AWS credit** | **$200.00, $0 due** | **182 days, expires May 10, 2027** |
| Lightsail VPS $12/mo plan | $12/mo × 6 mo = **$72** | $200 credit ထဲက ဖြတ်ပါတယ် — ၆ လ လုံလောက်ပါတယ် |
| Lightsail $24/mo (4 GB) plan | ❌ **REJECTED on Free plan** | `"your account can not create an instance using this Lightsail plan size"` — $12 plan ပဲ သုံးပါ |
| Domain (komoe.org) | Ko မှာ ရှိပြီး | Cloudflare DNS |
| n8n | **Free** — Community Edition | License key ကို email ကနေ အခမဲ့ ယူပါတယ် |
| Caddy + Let's Encrypt HTTPS | **Free** | Certificate အလိုအလျောက် |
| Meta App + Facebook Graph API | **Free** | Development mode (Unpublished) နဲ့ ကိုယ့် Page အတွက် လုံလောက်ပါတယ် |
| **After credit ends** | ~$12/mo | VPS ဆက်သုံးချင်ရင် ပေးရပါမယ် |

> ⚠️ **Never upgrade Free → Paid just for a task.** Bedrock Playground က Free plan မှာ block ဖြစ်ပါတယ် (Phase 1, Task 3) — $20 အတွက် Paid ကို upgrade **လုံးဝမလုပ်ပါနဲ့** (ပြန်ပြင်၍မရပါ၊ credit ကုန်ပြီးနောက် ငွေကောက်ခံရနိုင်ပါတယ်)။

---

## 🗺️ The 10 phases at a glance / အဆင့် ၁၀ ဆင့် အကျဉ်း

| # | Phase | Checkpoint ✅ |
|---|---|---|
| 1 | AWS account + $200 credit (5 tasks) | Billing: Credits remaining **$200.00**, Amount due **$0.00** |
| 2 | Region lock — Sydney only | Singapore block ကို လက်ခံပြီး Sydney (`ap-southeast-2`) သုံးပါ |
| 3 | Lightsail VPS n8n-sydney ($12/mo) | Static IP + Running |
| 4 | SSH + Ubuntu update + Docker + n8n | `http://<IP>:5678` → HTTP 200 |
| 5 | Domain + Caddy HTTPS | https://n8n.komoe.org/ → HTTP 200 |
| 6 | Meta App "Ai Mindset n8n" | App ID `<YOUR_APP_ID>`, permissions Ready for testing |
| 7 | Graph Explorer test post | Post ID `<YOUR_POST_ID>` |
| 8 | Long-lived Page token (~60 days) | Debugger: Type **Page**, Valid **True** |
| 9 | n8n workflow FB-Auto-Post | Post ID `<YOUR_POST_ID>` |
| 10 | Schedule daily 08:00 Asia/Rangoon | Workflow **inactive** (အကြောင်းအရာအစစ် မထည့်မချင်း မဖွင့်ပါနဲ့) |

---

## Phase 1 — AWS account + $200 credit / AWS အကောင့်အသစ်နှင့် $200 credit

**မြန်မာ:** AWS အကောင့်အသစ် ဖွင့်ပါ (business email သုံးပါ — Ko: `komoe@komoe.org` ကို AWS အတွက်ပဲ သုံးပါတယ်)။ Signup credit **$100** + onboarding task ၅ ခု × **$20** = **$200** စုစုပေါင်း။ 182 days သက်တမ်း၊ **May 10, 2027** မှာ ကုန်ဆုံးပါတယ်။

**English:** Create a new AWS account (use a business email). Signup credit **$100** + 5 onboarding tasks × **$20** = **$200** total, valid 182 days, expiring **May 10, 2027**.

### Task 1 — AWS Budgets (✅ done 2026-11-10 08:14)
- Budgets → Create budget → **"My Zero-Spend Budget"**, $1.00 budget, $0.00 used, status OK.
- Screenshot ယူပါ။

### Task 2 — EC2 (✅ done 2026-11-10 08:19–08:20)
- Launch instance: name `aws-exploer-test`, **Amazon Linux 2023**, `t3.micro`, key pair `aws-test` (.pem, RSA).
- Running, 2/2 checks passed ဖြစ်ကြောင်း စစ်ပါ → ပြီးရင် **Terminate** လုပ်ပါ (ငွေ မကုန်အောင်)။
- Instance ID (Ko's): `<YOUR_EC2_INSTANCE_ID>`.

### Task 3 — Bedrock Playground (❌ BLOCKED — ဒါက ပုံမှန်ပါ!)
- Playground → Nova Micro / Nova Lite 1.0 → error: `ValidationException: Operation not allowed`.
- **အကြောင်းရင်း:** Free plan က Bedrock ကို block ထားပါတယ်။
- **ဘာလုပ်ရမလဲ:** ဘာမှ မလုပ်ပါနဲ့။ **Paid plan ကို upgrade လုံးဝမလုပ်ပါနဲ့** — $20 အတွက် မတန်ပါ၊ ပြန်ပြင်၍မရပါ။

### Task 4 — Lambda (✅ done 2026-11-10 08:41)
- Function: `aws-exploer-test`, **Python 3.10**, region **Sydney ap-southeast-2**.
- Code: `return "Hello from Lambda!"` → Function URL ဖန်တီးပါ, Auth **NONE** → browser မှာ ဖွင့်ကြည့်ပါ → `Hello from Lambda!` ပေါ်ရမည်။

### Task 5 — RDS (✅ done 2026-11-10 08:51–08:55)
- Database: `database-1`, **PostgreSQL**, `db.t4g.micro`, Sydney။
- Status **Available** ဖြစ်ကြောင်း စစ်ပါ → ပြီးရင် **Delete** (no final snapshot — "delete me" confirm လုပ်ပါ)။

### ✅ Checkpoint
Billing → Credits: **Credits remaining $200.00, Amount due $0.00, Free plan, 182 days remaining**.
> မှတ်ချက်: Budgets + EC2 ပြီးချိန်မှာ $140 ဖြစ်ခဲ့ပြီး၊ Lambda + RDS + Bedrock (error ဖြစ်ပေမဲ့) ပြီးနောက် $200 ပြည့်သွားပါတယ်။ Bedrock invoke အောင်မြင်ခဲ့တယ်လို့ **မပြောပါနဲ့** — error ပဲ ရခဲ့ပါတယ်။

---

## Phase 2 — Region lock: Sydney only / Region ပိတ်ထားခြင်း

**မြန်မာ:** AWS Free plan အကောင့်အသစ်ဟာ region တစ်ခုတည်းကိုသာ သုံးခွင့်ရှိပါတယ် — Ko's account: **Asia Pacific (Sydney) `ap-southeast-2`**။ Singapore (`ap-southeast-1`) ကို ရွေးရင် ဒီ error တက်ပါတယ်:

> `Region Asia Pacific (Singapore) unavailable — Your project is assigned to Asia Pacific (Sydney) ap-southeast-2. To access other commercial AWS Regions, upgrade your plan first, and then activate advanced features.`

**ဘာလုပ်ရမလဲ:** **"Activate advanced features" / upgrade ကို လုံးဝ မနှိပ်ပါနဲ့။** Lambda နဲ့ RDS ကို Sydney မှာ လုပ်ပါ — $20 task တွေက Singapore မလိုအပ်ပါ။ Ko က VPS အတွက် Singapore ကို ပိုကြိုက်ပေမဲ့ ဒီ project မှာ Sydney သုံးခဲ့ပါတယ်။

**English:** The new Free plan account is locked to a single assigned region — Sydney `ap-southeast-2`. Singapore is blocked. Do **not** click "Activate advanced features" or upgrade. Do Lambda and RDS in Sydney instead.

> ℹ️ Region ကို instance ဖန်တီးပြီးမှ ပြောင်းလို့မရပါ — Singapore လိုချင်ရင် အဲဒီမှာ အသစ်ဖန်တီးပြီး migrate လုပ်ရပါမယ်။ Ko's အဟောင်း Tokyo VPS (Ubuntu-IMM, `<YOUR_OLD_VPS_IP>`) ဟာ သီးခြား VPS ဖြစ်ပြီး ဒီ project နဲ့ မဆိုင်ပါ။

---

## Phase 3 — Lightsail VPS n8n-sydney ($12/mo) / VPS ဖန်တီးခြင်း

**မြန်မာ:** Lightsail → Create instance →

| Setting | Value |
|---|---|
| Name | `n8n-sydney` |
| OS | **Ubuntu 24.04 LTS** |
| Region / Zone | Sydney, Zone A (`ap-southeast-2a`) |
| Plan | **$12/mo** — 2 GB RAM, 2 vCPUs, 60 GB SSD |
| Static IP | `StaticIp-1` → **`<YOUR_VPS_IP>`** |

- ❌ **$24/mo (4 GB) plan ကို အရင်ရွေးခဲ့ပေမဲ့ reject ခံခဲ့ရပါတယ်:** `"CreateInstances[ap-southeast-2] Sorry, your account can not create an instance using this Lightsail plan size. Please try a smaller plan size"` — Free plan မှာ $12 plan ပဲ ရပါတယ်။
- Static IP attach လုပ်ပါ — dynamic IP (`<YOUR_VPS_IP>`) ကို အစားထိုးပြီး **အခု `<YOUR_VPS_IP>` ကိုပဲ သုံးပါ**။
- Private IP: `<YOUR_PRIVATE_IP>` (မှတ်ထားရုံပါ)။
- Firewall (Lightsail Networking → Firewall): ports **22, 80, 443, 5678** ဖွင့်ပါ။
- $12 × 6 လ = $72 → $200 credit ထဲမှာ လုံလောက်ပါတယ်။

**English:** Create a Lightsail instance in Sydney Zone A, Ubuntu 24.04 LTS, $12/mo plan (the $24/mo 4 GB plan is rejected on the Free plan). Attach a static IP and use it from then on. Open firewall ports 22, 80, 443, 5678.

### ✅ Checkpoint
Instance status **Running**, static IP `<YOUR_VPS_IP>` attached.

---

## Phase 4 — SSH + Ubuntu update + Docker + n8n / SSH နှင့် n8n တပ်ဆင်ခြင်း

**SSH (မြန်မာ):** Lightsail browser SSH နဲ့ ဝင်ပြီး Muse ရဲ့ SSH public key ကို **ubuntu user** ရဲ့ key ထဲ ထည့်ပါ:

```bash
mkdir -p ~/.ssh && chmod 700 ~/.ssh
# Muse public key ကို အောက်က file ထဲ ထည့်ပါ (public key သာလျှင် — private key လုံးဝ မဟုတ်ပါ)
cat >> ~/.ssh/authorized_keys <<'EOF'
<YOUR_SSH_PUBLIC_KEY>
EOF
chmod 600 ~/.ssh/authorized_keys
```

> ⚠️ **အမှား သတိပြုပါ:** Ko အရင်ဆုံး key ကို **root** အနေနဲ့ ထည့်မိခဲ့ပါတယ် (`/root/.ssh/authorized_keys`) — အဲဒါကြောင့် `Permission denied (publickey)` ဖြစ်ခဲ့ပါတယ်။ **`/home/ubuntu/.ssh/authorized_keys`** မှာ ထည့်ရပါမယ်။ SSH user က `ubuntu` ပါ။
>
> ⚠️ **Common mistake:** Ko first added the key as root (`/root/.ssh/authorized_keys`) and got `Permission denied (publickey)`. It must go in `/home/ubuntu/.ssh/authorized_keys` — the SSH user is `ubuntu`.

**Verify SSH:**

```bash
ssh ubuntu@<YOUR_VPS_IP>
# hostname: ip-<YOUR_PRIVATE_IP>, Ubuntu 24.04.4 LTS
# Mem: 1.9 Gi total / 384 Mi used / 1.3 Gi free
```

**Install — script ကို သုံးပါ (ဒီ repo မှာပါပါတယ်):**

```bash
scp scripts/install-docker-n8n.sh ubuntu@<YOUR_VPS_IP>:~/
ssh ubuntu@<YOUR_VPS_IP> 'bash ~/install-docker-n8n.sh'
```

Script က ဘာလုပ်သလဲ:

1. **Ubuntu update** — 111 packages upgraded, new kernel `7.0.0-1017-aws` (running kernel က `7.0.0-1012-aws` ပဲ ရှိနေသေးတယ် — နောက်မှ `sudo reboot` လုပ်ပါ၊ မလိုအပ်သေးပါ)။ AWS က Linux security update CVE-2026-98432 သတိပေးချက်လည်း ဒီ update နဲ့ ဖြေရှင်းပါတယ်။
2. **2 GB swap** — `/swapfile`, `/etc/fstab` ထဲ ထည့်ထားပါတယ်။
3. **Docker 29.9.3** — official install script (`https://get.docker.com`) နဲ့။
4. **n8n 2.46.7** — Docker container, SQLite, volume `n8n_data`, `--restart unless-stopped`, `127.0.0.1:5678` ပဲ bind လုပ်ထားပါတယ်။ Env: `N8N_HOST=n8n.komoe.org`, `WEBHOOK_URL=https://n8n.komoe.org/`, `N8N_PROTOCOL=https`, `TZ=Asia/Rangoon`။
   - ❌ `N8N_SECURE_COOKIE=false` ကို **လုံးဝ မထည့်ပါနဲ့** — HTTPS ရှိတဲ့အခါ secure cookie က အလုပ်လုပ်ပါတယ်။

> ℹ️ Official full n8n stack (Postgres + runner) က 4 GB RAM လိုပါတယ်။ 2 GB RAM မှာ SQLite + swap နဲ့ testing / light use အတွက် အလုပ်လုပ်ပါတယ်။ Heavy / production သုံးမယ်ဆိုရင် 4 GB plan ကို upgrade လုပ်ဖို့ စဉ်းစားပါ။

### ✅ Checkpoint (VPS အတွင်းကနေ စစ်ပါ — n8n က 127.0.0.1 ပဲ နားထောင်ပါတယ်)
```bash
ssh ubuntu@<YOUR_VPS_IP> 'curl -s -o /dev/null -w "%{http_code}\n" http://127.0.0.1:5678/'
# → 200
```

---

## Phase 5 — Domain + Caddy HTTPS / Domain နှင့် HTTPS

**မြန်မာ:** Ko မှာ `komoe.org` domain ရှိပြီး Cloudflare DNS သုံးပါတယ်။

1. **DNS A record:** `n8n.komoe.org` → `<YOUR_VPS_IP>`, **DNS only (not proxied)** — Cloudflare proxy (orange cloud) ပိတ်ထားပါ။
2. **Caddy 2.11.9 install** — official apt repo ကနေ (အသေးစိတ် command တွေကို ဒီ repo ရဲ့ `Caddyfile` ထဲက comment မှာ ကြည့်ပါ)။
3. **`Caddyfile`:** ဒီ repo မှာပါပါတယ် —
   ```
   n8n.komoe.org {
       reverse_proxy 127.0.0.1:5678
   }
   ```
   `sudo cp Caddyfile /etc/caddy/Caddyfile && sudo systemctl reload caddy`
4. Caddy က Let's Encrypt certificate ကို အလိုအလျောက် ယူပေးပါတယ်။ `http` က `https` ကို 308 redirect ဖြစ်ပါတယ်။
5. n8n container ကို env အပြည့်နဲ့ ပြန် run ပါ (script ထဲမှာ ပါပြီးသား): `N8N_HOST=n8n.komoe.org`, `WEBHOOK_URL=https://n8n.komoe.org/`, `N8N_PROTOCOL=https`။

**Owner account (အရေးကြီးဆုံး):** https://n8n.komoe.org/setup ကို **သင့် browser မှာ ကိုယ်တိုင် ဖွင့်ပြီး** owner account ဖန်တီးပါ။ Password ကို ဘယ်သူ့ကိုမှ မပြောပါနဲ့။ Ko ဖန်တီးပြီးချိန်မှာ Settings → Plan & usage မှာ `You're on the Community Edition Registered`, Version 2.46.7 လို့ ပေါ်ပါတယ်။ n8n က license key ကို email (`komoeybs@gmail.com`) ပို့ပါတယ် — အဲဒီ email ကို စစ်ပြီး `Enter activation key` မှာ ထည့်ပါ (အခမဲ့ Community Edition, ငွေပေးစရာ မလိုပါ)။

### ✅ Checkpoint
```bash
curl -s -o /dev/null -w "%{http_code}\n" https://n8n.komoe.org/
# → 200   (http://n8n.komoe.org:5678 က ဒီနောက်ပိုင်း အလုပ်မလုပ်တော့ပါ — ရည်ရွယ်ချက်ရှိရှိ ပိတ်ထားတာပါ)
```

---

## Phase 6 — Meta App "Ai Mindset n8n" / Meta Developer App ဖန်တီးခြင်း

**မြန်မာ:** https://developers.facebook.com → My Apps → Create App →

| Setting | Value |
|---|---|
| App name | **Ai Mindset n8n** |
| App ID | `<YOUR_APP_ID>` |
| Contact email | `komoeybs@gmail.com` |
| Use case | **"Manage everything on your Page"** (Pages API) |
| Business portfolio | None (မလိုအပ်ပါ) |
| Status | **Unpublished (Development mode)** — ကိုယ့် Page အတွက် လုံလောက်ပါတယ် |

**Permissions (use case ထဲမှာ):** `pages_manage_posts` + `pages_read_engagement` + `pages_show_list` — status: **Ready for testing**.

### ⚠️ Pitfall — `manage_pages` is dead / အမှား သတိပြုပါ
- `manage_pages` scope က **deprecated** ဖြစ်နေပါပြီ။ Graph Explorer မှာ `manage_pages` ထည့်ရင် ဒီ error တက်ပါတယ်:
  > `Invalid Scopes: manage_pages`
- **Fix:** use-case permissions (အထက်ပါ ၃ ခု) + **Facebook Login for Business** ကို configure လုပ်ပြီး **"Opt in to current Pages only"** ကို ရွေးပါ။ `manage_pages` ကို ဘယ်နေရာမှာမှ မသုံးပါနဲ့။

**English:** Create the app with use case "Manage everything on your Page". `manage_pages` is deprecated — using it gives `Invalid Scopes: manage_pages`. Use the three use-case permissions + Facebook Login for Business, opting in to current Pages only.

---

## Phase 7 — Graph Explorer test post / ပထမဆုံး test post

**မြန်မာ:** Meta App → Tools → **Graph Explorer** →

1. Token ရယူပါ: **User Token** ကို `me/accounts` နဲ့ စစ်ပါ —
   `GET /me/accounts` → Page **AI Mindset Academy** ကို ရှာပါ။
2. **Page API ID:** `<YOUR_PAGE_ID>` (tasks ထဲမှာ `CREATE_CONTENT` ပါရမည်)။
   > ⚠️ **သတိပြုပါ:** Page URL ထဲက ID `<YOUR_PAGE_URL_ID>` နဲ့ မတူပါ။ API အတွက် **`<YOUR_PAGE_ID>`** ကိုပဲ သုံးပါ။
3. Test post တင်ပါ: `POST /<YOUR_PAGE_ID>/feed` with `message` = `Hello from Ai Mindset n8n - test post`

**Result (Ko's, 2026-11-10 10:44):** ✅ Success — post ID **`<YOUR_POST_ID>`**, Page မှာ `Published by Ai Mindset n8n` လို့ ပေါ်ပါတယ်။

**English:** In Graph Explorer, `GET /me/accounts` to find the Page, then `POST /<YOUR_PAGE_ID>/feed` with a message. Use the Page API ID `<YOUR_PAGE_ID>`, not the Page URL ID `<YOUR_PAGE_URL_ID>`.

### Common errors / အမှားများ
| Error | Meaning / အဓိပ္ပါယ် | Fix |
|---|---|---|
| `(#200)` | Wrong token — User token နဲ့ Page ကို post လုပ်မိတာ | **Page token** ကို သုံးပါ (`me/accounts` ကနေ ယူပါ) |
| `code 197 "Post is empty"` | `message` parameter မပါတာ | `message` field ထည့်ပါ |

---

## Phase 8 — Long-lived Page token (~60 days) / Token သက်တမ်း ရှည်အောင် လဲခြင်း

**မြန်မာ:** Graph Explorer က short-lived token က နာရီအနည်းငယ်ပဲ ခံပါတယ်။ n8n အတွက် long-lived Page token လိုပါတယ်:

**Step 1 — User token ကို long-lived ဖြစ်အောင် လဲပါ:**
```
GET https://graph.facebook.com/v25.0/oauth/access_token
  ?grant_type=fb_exchange_token
  &client_id=<YOUR_APP_ID>
  &client_secret=<YOUR_APP_SECRET>
  &fb_exchange_token=<YOUR_SHORT_LIVED_USER_TOKEN>
```
→ Response မှာ `access_token` အသစ် + `expires_in: 5181713` (≈ 60 days) ပါလာပါမယ်။

**Step 2 — Long-lived User token နဲ့ `GET /me/accounts` ကို ပြန်ခေါ်ပြီး Page token ကို ယူပါ** — အဲဒီ Page token ကပဲ n8n မှာ သုံးရမယ့် token ပါ။

**Step 3 — စစ်ပါ:** https://developers.facebook.com/tools/debug/accesstoken/ → **Type: Page, Valid: True, Expires: in about 2 months**, scopes: `pages_show_list`, `pages_read_engagement`, `pages_manage_posts`။

> ℹ️ `/me/accounts` ကို **Page token** နဲ့ ခေါ်ရင် `error #100` တက်ပါတယ် — ဒါက **ပုံမှန်ပါ**။ `/me/accounts` က User token ပဲ လိုပါတယ်။ n8n အတွက်က Page token ပဲ လိုပါတယ် — ရောထွေးမလုပ်ပါနဲ့။
>
> ℹ️ Calling `/me/accounts` with a Page token gives error #100 — that is **expected**. It needs a User token; n8n needs the Page token.

> 🔒 App Secret (`<YOUR_APP_SECRET>`) ကို App Dashboard → Settings → Basic → App Secret မှာ ရှာပါ။ ဘယ်တော့မှ screenshot/chat/repo ထဲ မထည့်ပါနဲ့။

---

## Phase 9 — n8n workflow FB-Auto-Post / n8n workflow တည်ဆောက်ခြင်း

**မြန်မာ:** n8n → Workflows → Create →

| Node | Settings |
|---|---|
| **Schedule Trigger** (အရင်ဆုံး Manual Trigger နဲ့ စမ်းပါ) | — |
| **Facebook Graph API** | HTTP Method **POST**, Graph API Version **v25.0** (n8n မှာ အမြင့်ဆုံး), Node **`<YOUR_PAGE_ID>`**, Edge **`feed`**, Query Parameter: `message` = `Test post from n8n workflow` |

**Credential:** n8n → Credentials → Facebook Graph API → name **`Facebook Graph account`** → Access Token: `<YOUR_LONG_LIVED_PAGE_TOKEN>` → Save → **Test နှိပ်ပြီး အောင်မြင်ကြောင်း စစ်ပါ**။

**Import (အလွယ်နည်း):** ဒီ repo ရဲ့ `n8n-workflow-fb-auto-post.json` ကို n8n → Workflows → `⋯` → **Import from File** နဲ့ သွင်းပါ — ဒါက Ko's အမှန်တကယ် workflow (id `<YOUR_WORKFLOW_ID>`) ကို credential တွေ ဖယ်ရှားထားတဲ့ version ဖြစ်ပါတယ်။ ပြီးရင် ကိုယ့် `Facebook Graph account` credential ကို node မှာ ပြန်ချိတ်ပါ။

**Test run (Ko's, 2026-11-10 11:12):** ✅ `Execute workflow` → Node executed successfully → post ID **`<YOUR_POST_ID>`** (Page မှာ မြင်ရပါတယ်)။

**English:** Build the workflow with a Manual Trigger first, then a Facebook Graph API node (POST, v25.0, Node `<YOUR_PAGE_ID>`, Edge `feed`, `message` parameter). Create the `Facebook Graph account` credential with your long-lived Page token and test it. Or import `n8n-workflow-fb-auto-post.json` from this repo and re-attach your own credential.

---

## Phase 10 — Schedule: daily 08:00 Asia/Rangoon / နေ့စဉ် အချိန်ဇယား

**မြန်မာ:**

1. Manual Trigger ကို **Schedule Trigger** နဲ့ အစားထိုးပါ — n8n-nodes-base.scheduleTrigger v1.2, cron expression **`0 8 * * *`**, workflow timezone **Asia/Rangoon**။
2. Facebook node ကို မပြောင်းပါနဲ့။
3. Workflow ကို **Save** လုပ်ပါ — Ko's workflow: **FB-Auto-Post**, id `<YOUR_WORKFLOW_ID>`။
4. ⛔ **Active မလုပ်ရသေးပါ!** `message` ထဲမှာ `Test post from n8n workflow` ပဲ ရှိနေသေးလို့ **inactive** ပဲ ထားပါ။ အကြောင်းအရာအစစ် (real content) ထည့်ပြီးမှ Activate လုပ်ပါ။
5. Schedule: **နေ့စဉ် မနက် ၈:၀၀ (Asia/Rangoon), ၁ ရက် ၁ post**။ Content source ကို Ko က နောက်မှ ဆုံးဖြတ်ပါမယ်။

**Muse + n8n API (optional, advanced):** Ko က n8n API key တစ်ခု ဖန်တီးထားပါတယ် — label `Muse`, expiration **Never**, scopes **All (109/109)**, VPS ပေါ်က `~/n8n_api_key.txt` မှာ `chmod 600` နဲ့ သိမ်းထားပါတယ်။ Key ကို **chat မှာ ဘယ်တော့မှ မရေးပါနဲ့**။ Verified: `GET https://n8n.komoe.org/api/v1/workflows` → HTTP 200။ API key ကို shell variable ထဲပဲ ထည့်သုံးပါ:
```bash
KEY=$(cat ~/n8n_api_key.txt)
curl -s -H "X-N8N-API-KEY: $KEY" https://n8n.komoe.org/api/v1/workflows
# ⚠️ $KEY ကို echo / print လုံးဝ မလုပ်ပါနဲ့
```

**English:** Replace the Manual Trigger with a Schedule Trigger (cron `0 8 * * *`, timezone Asia/Rangoon). Save as FB-Auto-Post. Keep the workflow **inactive** until real content replaces the test message. Schedule: daily 08:00 Asia/Rangoon, 1 post per day.

---

## 🐛 Common errors + fixes / အမှားများနှင့် ဖြေရှင်းနည်းများ

| # | Error / Symptom | Fix |
|---|---|---|
| 1 | `Permission denied (publickey)` (SSH) | Key ကို `/home/ubuntu/.ssh/authorized_keys` ထဲ ထည့်ပါ — `/root/.ssh/` ထဲ မဟုတ်ပါ။ SSH user: `ubuntu` |
| 2 | `CreateInstances ... can not create an instance using this Lightsail plan size` | $24/mo plan ကို စွန့်ပြီး **$12/mo plan** သုံးပါ |
| 3 | `Region ... (Singapore) unavailable` | **Upgrade / Activate advanced features မနှိပ်ပါနဲ့** — Sydney (`ap-southeast-2`) သုံးပါ |
| 4 | `ValidationException: Operation not allowed` (Bedrock) | Free plan block ဖြစ်ပါတယ် — Paid upgrade **မလုပ်ပါနဲ့**, ဒီ task ကို ကျော်ပါ |
| 5 | `Invalid Scopes: manage_pages` | `manage_pages` မသုံးပါနဲ့ — use-case permissions + Facebook Login for Business, "Opt in to current Pages only" |
| 6 | Graph API `(#200)` | User token အစား **Page token** သုံးပါ |
| 7 | Graph API `code 197 "Post is empty"` | `message` parameter ထည့်ပါ |
| 8 | `/me/accounts` → `error #100` (Page token နဲ့) | **ပုံမှန်ပါ** — `/me/accounts` က User token လိုပါတယ် |
| 9 | n8n setup page "secure cookie" error | Caddy HTTPS သုံးပါ — `N8N_SECURE_COOKIE=false` **မထည့်ပါနဲ့** |
| 10 | `http://n8n.komoe.org:5678` အလုပ်မလုပ်တော့တာ | ရည်ရွယ်ချက်ရှိရှိ ပိတ်ထားတာပါ — `https://n8n.komoe.org/` ပဲ သုံးပါ |
| 11 | n8n container ရပ်သွားတာ / RAM ပြည့်တာ | 2 GB swap ရှိကြောင်း စစ်ပါ (`free -h`)၊ `docker ps` + `docker logs n8n` ကြည့်ပါ |
| 12 | Token expired (~60 days) | Phase 8 ကို ပြန်လုပ်ပြီး Page token အသစ် လဲပါ၊ n8n credential ကို update လုပ်ပါ |

---

## 🎓 Better way to teach — 4 lessons, not one long session / သင်ကြားနည်း (၄ ချိန်ခွဲ သင်ပါ)

တစ်ထိုင်တည်း အရှည်ကြီး မသင်ပါနဲ့ — ၄ ချိန်ခွဲပါ။ ချိန်တိုင်းမှာ **checkpoint** တစ်ခုစီ ရှိပါတယ်။ Checkpoint မအောင်ရင် နောက်ချိန် မသွားပါနဲ့။ ချိန်တိုင်းအဆုံးမှာ **"တမင်ဖျက်ကြည့်ပါ" (break it on purpose)** လေ့ကျင့်ခန်း တစ်ခုစီ ပါပါတယ် — အမှားကို ကိုယ်တိုင်မြင်ဖူးမှ တကယ် မှတ်မိပါတယ်။

### Lesson 1 — AWS + $200 credit (30 min) / သင်ခန်း ၁
- **သင်တာ:** AWS အကောင့်ဖွင့်နည်း, Budgets, EC2, Lambda, RDS (Bedrock block အကြောင်း အပါအဝင်)။
- **Hands-on:** ကျောင်းသားတစ်ယောက်ချင်း 5 tasks ကို ကိုယ်တိုင်လုပ်ပြီး task တိုင်း **screenshot** ယူပါ။
- **✅ Checkpoint:** Billing screenshot — Credits remaining **$200.00**, Amount due **$0.00**။
- **🔧 Break it on purpose:** EC2 instance ကို terminate **မလုပ်ဘဲ** ထားကြည့်ပါ — Billing မှာ ငွေကုန်နေတာကို သတိထားမိလား? ပြီးမှ terminate လုပ်ပြီး $0 ပြန်ဖြစ်အောင် လုပ်ပါ။
- **သတိပေးချက်:** Free → Paid upgrade လုံးဝ မလုပ်ရ။ EC2/RDS လုပ်ပြီးရင် ဖျက်ဖို့ မမေ့ရ။

### Lesson 2 — VPS + n8n + HTTPS (45 min) / သင်ခန်း ၂
- **သင်တာ:** Lightsail VPS ဖန်တီးနည်း, SSH key (ubuntu vs root အမှား), `install-docker-n8n.sh` script, Caddy + Let's Encrypt။
- **Hands-on:** ကျောင်းသားတစ်ယောက်ချင်း ကိုယ့် Lightsail VPS မှာ n8n run ပါ။
- **✅ Checkpoint:** `https://n8n.komoe.org` (ကိုယ့် domain) ဖွင့်ရင် HTTP **200** + owner account ဖန်တီးပြီး။
- **🔧 Break it on purpose:** SSH public key ကို `/root/.ssh/authorized_keys` ထဲ **တမင်ထည့်ကြည့်ပါ** — `Permission denied (publickey)` error ကို မြင်ရပါမယ်။ ပြီးမှ `/home/ubuntu/.ssh/authorized_keys` ထဲ ပြောင်းထည့်ပြီး ပြန်ဝင်ကြည့်ပါ။
- **သတိပေးချက်:** Password/token တွေကို chat/screenshot မှာ မမျှရ။ `N8N_SECURE_COOKIE=false` မထည့်ရ။

### Lesson 3 — Meta App + token + n8n workflow (45 min) / သင်ခန်း ၃
- **သင်တာ:** Meta App, use-case permissions, Graph Explorer test post, long-lived Page token, n8n workflow + Schedule Trigger။
- **Hands-on:** Test post ၁ ခု တင်ပြီး post ID ကို ချရေးပါ၊ ပြီးမှ schedule ပြောင်းပါ။
- **✅ Checkpoint:** ကိုယ့် Page မှာ test post ID ပေါ်နေခြင်း + workflow saved (inactive)။
- **🔧 Break it on purpose:** n8n Facebook credential ကို **တမင်ဖြုတ်ကြည့်ပါ** (credential ကို disconnect လုပ်ပါ) — workflow run လုပ်ရင် ဘယ် error တက်လဲ? Error message ကို ဖတ်ပြီး credential ပြန်ချိတ်ပါ။
- **သတိပေးချက်:** Personal profile ကို API နဲ့ auto-post **လို့မရပါ** — Page ပဲ ရပါတယ်။ Test message အစား အကြောင်းအရာအစစ် မထည့်မချင်း workflow ကို **activate မလုပ်ရ**။

### Lesson 4 — Phase 1 Central Service (45 min) / သင်ခန်း ၄
- **သင်တာ:** Google Form → Google Sheet queue → Ko approve → central n8n က နေ့စဉ် 08:00 auto-post (အသေးစိတ်ကို အောက်က **Lesson 4: Phase 1 Central Service** section နဲ့ `docs/phase1-central-service.md` မှာ ကြည့်ပါ)။
- **Hands-on:** ကျောင်းသားတစ်ယောက်ချင်း Form ဖြည့်ပြီး၊ Ko က approve လုပ်တာကို စောင့်ပြီး၊ 08:00 run မှာ ကိုယ့် post တက်လာတာ စစ်ပါ။
- **✅ Checkpoint:** Test row တစ်ခု Telegram **နဲ့** Facebook နှစ်ခုလုံးမှာ တက်ပြီး၊ Sheet မှာ Status = **posted** + Post ID ပေါ်နေခြင်း (ပြီးမှ test post များကို ဖျက်ပါ)။
- **🔧 Break it on purpose:** Test row ရဲ့ Status ကို `pending` လို့ **တမင်ပြောင်းကြည့်ပါ** — workflow run လုပ်ရင် အဲဒီ row ကို ကျော်သွားတာ (skip) ကို မြင်ရပါမယ်။ ပြီးမှ `approved` ပြန်ပြောင်းပါ။
- **သတိပေးချက်:** သင်တန်းသားများသည် Ko ရဲ့ n8n ကို တိုက်ရိုက် သုံးခွင့် မရပါ — Form ကနေပဲ တင်ရပါတယ်။

## Lesson 4: Phase 1 Central Service / သင်ခန်း ၄ — Phase 1 Central Service

**မြန်မာ:** သင်တန်းသားတိုင်း ကိုယ့် n8n ထားစရာ မလိုဘဲ၊ Ko ရဲ့ central n8n ကို သုံးပြီး content တင်နိုင်တဲ့ စနစ်ပါ။ သင်တန်းသားက Form ဖြည့်တယ် → Ko က စစ်ပြီး approve လုပ်တယ် → n8n က နေ့စဉ် မနက် ၈:၀၀ မှာ တင်ပေးတယ်။ အသေးစိတ်ကို `docs/phase1-central-service.md` မှာလည်း ဖတ်နိုင်ပါတယ်။

**English:** Students don't need their own n8n — they submit through a Google Form, Ko approves, and Ko's central n8n posts daily at 08:00. Full detail is also in `docs/phase1-central-service.md`.

### Flow / အဆင့်ဆင့်

```
Google Form → Google Sheet "Form Responses 1" → Ko approves (Status=approved)
  → n8n Student-Auto-Post-Central (daily 08:00 Asia/Rangoon)
  → Facebook / Telegram → Status=posted + Post ID
```

![Phase 1 workflow diagram](docs/images/phase1-workflow-diagram.png)

![Ai Mindset automation mindmap](docs/images/automation-mindmap.png)

### 1. Google Form — သင်တန်းသား ဖြည့်ရမယ့်အရာ

Form: **"Ai Mindset - Student Auto-Post Request (Phase 1)"** — link ကို Ko က သင်တန်းသားများထံ တိုက်ရိုက် ပေးပါမယ် (ဒီ repo မှာ Form URL မထည့်ထားပါ)။

| Field | ဖော်ပြချက် |
|---|---|
| Student Name | သင်တန်းသား အမည် |
| Platform | Facebook / Telegram / Both |
| Destination | Page API ID သို့မဟုတ် Telegram Chat ID (`<YOUR_PAGE_ID>` / `<YOUR_CHAT_ID>` ပုံစံ) |
| Message | တင်ချင်တဲ့ စာသား |
| Image URL | ပုံ link (ရှိရင်) |

### 2. Google Sheet — "Form Responses 1" tab

Form တင်ပြီးတာနဲ့ အဖြေများက queue Sheet ရဲ့ **"Form Responses 1"** tab ထဲကို အလိုအလျောက် ရောက်ပါတယ် (Timestamp က အလိုအလျောက် ဖြည့်ပေးပါတယ်)။

| Column | ဖော်ပြချက် |
|---|---|
| Timestamp | Form တင်တဲ့ အချိန် (အလိုအလျောက်) — Update Queue ရဲ့ matching column |
| Student Name | သင်တန်းသား အမည် |
| Platform | Facebook / Telegram / Both |
| Destination | Page API ID သို့မဟုတ် Telegram Chat ID |
| Message | တင်ချင်တဲ့ စာသား |
| Image URL | ပုံ link (ရှိရင်) |
| Status | Ko က သတ်မှတ်တယ် — `approved` မှ post တင်ပါတယ် (H column) |
| Post ID / Link | တင်ပြီးမှ ဖြည့်ပါတယ် (I column) |

> ⚠️ **"Sheet1"** tab ထဲကို row ကူးထည့်စရာ မလိုတော့ပါ — workflow က "Form Responses 1" tab ကနေ တိုက်ရိုက် ဖတ်ပါတယ်။

### 3. Ko approves — Ko ဘာလုပ်မလဲ

1. **"Form Responses 1"** tab ကို စစ်တယ်။
2. ကောင်းတဲ့ အတန်းကို **Status = approved** လို့ သတ်မှတ်တယ်။
3. မကောင်းတဲ့ အတန်းကို `approved` **မလုပ်ပါနဲ့** — `pending` ပဲ ထားရင် workflow က ကျော်သွားပါတယ်။

### 4. n8n workflow — Student-Auto-Post-Central

- **Schedule Trigger:** နေ့စဉ် 08:00, cron `0 8 * * *`, timezone **Asia/Rangoon**။
- **Read Queue:** "Form Responses 1" tab ကို ဖတ်တယ် (tab ကို **gid** နဲ့ ညွှန်းပါတယ် — tab နာမည်နဲ့ မဟုတ်ပါ၊ အမှားအကြောင်း အောက်က troubleshooting ကို ကြည့်ပါ)။
- **Filter Approved:** Status = `approved` ဖြစ်တဲ့ row ပဲ ဆက်သွားတယ်။
- **Platform routing:** **Is Facebook?** (Platform မှာ Facebook ပါရင်) → Facebook Graph API; **Is Telegram?** (Platform မှာ Telegram ပါရင်) → Telegram Send။ **Both** ဆိုရင် နှစ်ခုလုံး တင်ပါတယ်။
- **Update Queue:** တင်ပြီးတာနဲ့ Status = **posted** + Post ID / Link ကို Timestamp နဲ့ တိုက်ပြီး ပြန်ရေးပါတယ်။
- **Import:** `docs/student-auto-post-central-workflow.json` ကို n8n → Workflows → `⋯` → **Import from File** နဲ့ သွင်းပါ — credential တွေ လုံးဝ မပါတဲ့ template ဖြစ်ပါတယ်။ ကိုယ့် credential တွေကို node တိုင်းမှာ ပြန်ချိတ်ရပါမယ်။

**Credentials needed / လိုအပ်တဲ့ credential များ:**
- **Google Sheets OAuth2** — Google Cloud project မှာ Sheets API + Drive API ဖွင့်ပြီး၊ OAuth consent (External) + test user ထည့်ပြီး n8n မှာ "Google Sheets account" အဖြစ် ချိတ်ပါ။
- **Telegram API** — Telegram bot credential ("Telegram Academy Bot") ကို Telegram Send node မှာ ချိတ်ပါ။
- **Facebook Graph API** — Lesson 3 က "Facebook Graph account" credential ကို Facebook node မှာ ချိတ်ပါ (ကိုယ့် Page token နဲ့)။

### ✅ Checkpoint (Lesson 4)
Test row တစ်ခု (Platform = **Both**) ကို approve လုပ်ပြီး workflow ကို manual run လုပ်ပါ — Telegram **နဲ့** Facebook နှစ်ခုလုံးမှာ post တက်ရပါမယ်၊ Sheet မှာ Status = **posted** + Post ID ပေါ်ရပါမယ်။ ပြီးရင် test post နှစ်ခုလုံးကို **ဖျက်ပါ** (Facebook post ကို Graph API DELETE နဲ့၊ Telegram message ကို Bot API deleteMessage နဲ့)။

---

## 🐛 What went wrong & how we fixed it / ဘာမှားခဲ့လဲ၊ ဘယ်လိုပြင်ခဲ့လဲ

Ko က 2026-11-10 မှာ Phase 1 workflow ကို တကယ် စမ်းသပ်ရင်း ကြုံခဲ့ရတဲ့ အမှားအစစ်တွေပါ။ Error message အတိုင်း လိုက်ဖတ်ပြီး ပြင်တတ်အောင် လေ့ကျင့်ပါ။ (ID / token အစစ်တွေ လုံးဝ မပါပါ — placeholder ပဲ သုံးထားပါတယ်။)

| # | What went wrong / ဘာမှားခဲ့လဲ | How we fixed it / ဘယ်လိုပြင်ခဲ့လဲ |
|---|---|---|
| (a) | **Read Queue:** `Sheet with ID Form Responses 1 not found` — tab နာမည်ကို Sheet ID လို့ n8n က ထင်သွားတာ | **Fix:** sheetName ကို tab **နာမည်** နဲ့ မဟုတ်ဘဲ tab **gid** (tab ရဲ့ နံပါတ် — Sheet URL ရဲ့ `gid=` ကနေ ယူပါ) နဲ့ ညွှန်းပါ။ n8n မှာ mode ကို `id` လို့ သတ်မှတ်ပြီး value မှာ `<YOUR_TAB_ID>` ထည့်ပါ။ |
| (b) | **Filter Approved:** condition က အလွတ် placeholder ပဲ ဖြစ်နေတယ် — approved row တွေတောင် မစစ်နိုင်ဘူး | **Fix:** condition ကို **Status equals `approved`** လို့ အတိအကျ သတ်မှတ်ပါ (`leftValue` = `{{ $json.Status }}`, `rightValue` = `approved`)။ |
| (c) | **Split In Batches:** loop node ရဲ့ output ကို ဘယ်နေရာမှ မချိတ်မိလို့ Telegram node က ဘယ်တော့မှ မ run ဘူး | **Fix:** **Split In Batches node ကို ဖြုတ်ပစ်ပါ** — n8n က item တစ်ခုချင်းစီကို အလိုအလျောက် တစ်ကြိမ်စီ run ပေးပါတယ်၊ loop node မလိုအပ်ပါ။ |
| (d) | **Update Queue:** `Column to Match On required` — ဘယ် column နဲ့ တိုက်ရမလဲ မသိလို့ update လုပ်မရဘူး | **Fix:** matching column ကို **Timestamp** လို့ ပေးပါ၊ matching value ကို Read Queue row က Timestamp (`{{ $('Read Queue').item.json.Timestamp }}`) ကနေ ယူပါ။ ပြီးတော့ Update Queue ကို **Telegram Send ပြီးမှ** run အောင် ပြန်ချိတ်ပါ — disabled ဖြစ်နေတဲ့ Facebook node နောက်မှာ မဟုတ်ပါ။ |
| (e) | **Post ID empty:** post တင်ပြီးပေမဲ့ Sheet ရဲ့ Post ID / Link cell က အလွတ်ပဲ ဖြစ်နေတယ် | **Fix:** Telegram က post ID ကို `result.message_id` ထဲမှာ ထည့်ပေးတယ်၊ Facebook က `id` ထဲမှာ ထည့်ပေးတယ် — `$json` တစ်ခုတည်းနဲ့ မရပါ။ Update Queue ထဲက `$json` မှာ posting node ရဲ့ output မရှိဘူး (paired-item ပြဿနာ) — ဒါကြောင့် **posting node ကနေပဲ တိုက်ရိုက်ဖတ်ပါ** (`$('Telegram Send').item.json.result.message_id` / `$('Facebook Graph API').item.json.id`)၊ ပြီးတော့ တခြား branch မ run ခဲ့ရင် error မတက်အောင် **`isExecuted` guard** နဲ့ ကာပါ (`$('Facebook Graph API').isExecuted ? ... : ...`)။ |

**သင်ခန်းစာ / Lesson:** Error message ကို အရင် **ဖတ်ပါ** — error က ဘယ် node မှာ၊ ဘာပျောက်နေလဲ ပြောပြပါတယ်။ ပြီးမှ တစ်ဆင့်ချင်း ပြင်ပါ၊ တစ်ခါတည်း အများကြီး မပြင်ပါနဲ့။

---

## 📝 Final quiz / နောက်ဆုံးမေးခွန်း (၆ ခု)

1. AWS အကောင့်အသစ်ကနေ ရတဲ့ credit စုစုပေါင်း ဘယ်လောက်လဲ? ဘယ်ကနေ ရတာလဲ? / How much total AWS credit does a new account get, and from where?
2. Singapore region ကို ရွေးရင် ဘာဖြစ်လဲ? ဘာလုပ်သင့်လဲ? / What happens if you pick the Singapore region, and what should you do instead?
3. SSH key ကို root ရဲ့ `authorized_keys` ထဲ ထည့်မိရင် ဘာဖြစ်လဲ? ဘယ်နေရာမှာ ထည့်ရမလဲ? / What happens if the SSH key goes into root's `authorized_keys`, and where should it go?
4. `manage_pages` scope ကို Graph Explorer မှာ သုံးရင် ဘာဖြစ်လဲ? အစား ဘာသုံးရမလဲ? / What happens if you use the `manage_pages` scope in Graph Explorer, and what should you use instead?
5. Long-lived Page token က ဘယ်လောက် ကြာခံလဲ? သက်တမ်းကုန်ရင် ဘာလုပ်ရမလဲ? / How long does a long-lived Page token last, and what do you do when it expires?
6. Phase 1 မှာ Status = `pending` ဖြစ်တဲ့ row ကို workflow က ဘာလုပ်လဲ? Post ID ကို Sheet မှာ ဘာကြောင့် အလွတ်ဖြစ်ခဲ့ရတာလဲ? / In Phase 1, what does the workflow do with a row whose Status is `pending`? Why was the Post ID cell left empty in Sheet?

<details>
<summary>✅ Answers / အဖြေများ</summary>

1. **$200** — signup credit $100 + 5 onboarding tasks × $20 = $100။
2. `Region ... (Singapore) unavailable` error တက်ပါတယ် — **upgrade / Activate advanced features မနှိပ်ပါနဲ့**၊ Sydney (`ap-southeast-2`) မှာ လုပ်ပါ။
3. `Permission denied (publickey)` ဖြစ်ပါတယ် — `/home/ubuntu/.ssh/authorized_keys` ထဲ ထည့်ရပါမယ် (SSH user: `ubuntu`)။
4. `Invalid Scopes: manage_pages` error တက်ပါတယ် — `manage_pages` က deprecated ပါ။ Use-case permissions (`pages_manage_posts` + `pages_read_engagement` + `pages_show_list`) + Facebook Login for Business ("Opt in to current Pages only") သုံးပါ။
5. **≈ 60 days** (≈ 2 လ) — သက်တမ်းကုန်ရင် Phase 8 ကို ပြန်လုပ်ပြီး Page token အသစ် လဲပါ။
6. **Skip (ကျော်သွားပါတယ်)** — Filter Approved က Status = `approved` ပဲ ဖြတ်သန်းခွင့်ပေးပါတယ်။ Post ID အလွတ်ဖြစ်ခဲ့တာက Telegram က `result.message_id` ထဲမှာ၊ Facebook က `id` ထဲမှာ ထည့်ပေးလို့ `$json` တစ်ခုတည်းနဲ့ မရခဲ့လို့ပါ — posting node ကနေ `isExecuted` guard နဲ့ တိုက်ရိုက်ဖတ်ရပါတယ်။

</details>

---

## 📁 Files in this repo / Repo ထဲက ဖိုင်များ

| File | What it is |
|---|---|
| `README.md` | ဒီ guide (မြန်မာ + English) |
| `docs/phase1-central-service.md` | Phase 1 Central Service guide (Form → Sheet → approve → auto-post) |
| `docs/student-auto-post-central-workflow.json` | Student-Auto-Post-Central workflow — credentials လုံးဝ မပါတဲ့ template (import လုပ်လို့ရပါတယ်) |
| `docs/images/phase1-workflow-diagram.png` | Phase 1 workflow diagram (Form → Sheet → n8n → Facebook / Telegram) |
| `docs/images/automation-mindmap.png` | Ai Mindset automation mindmap |
| `scripts/install-docker-n8n.sh` | Ubuntu update + 2 GB swap + Docker 29.9.3 + n8n 2.46.7 |
| `Caddyfile` | `n8n.komoe.org` → `reverse_proxy 127.0.0.1:5678` (auto HTTPS) |
| `n8n-workflow-fb-auto-post.json` | Ko's အမှန်တကယ် FB-Auto-Post workflow — credentials ဖယ်ရှားပြီး (import လုပ်လို့ရပါတယ်) |
| `.gitignore` | Secrets (`.pem`, `.env`, `*token*` …) ကို GitHub မတင်မိအောင် ကာကွယ်ထားပါတယ် |
| `LICENSE` | MIT |

---

## ⚠️ Safety reminders / လုံခြုံရေး သတိပေးချက်များ

1. **Token/secret တွေကို ဘယ်တော့မှ မမျှပါနဲ့** — chat, screenshot, GitHub, မည်သည့်နေရာမှာမှ မထည့်ပါနဲ့။
2. **Free plan ကို Paid အဖြစ် upgrade မလုပ်ပါနဲ့** — Bedrock အတွက်ရော၊ region အတွက်ရော။
3. **Personal Facebook profile ကို auto-post လို့မရပါ** — API က Page ပဲခွင့်ပြုပါတယ်။
4. **Test message နဲ့ workflow ကို activate မလုပ်ပါနဲ့** — အကြောင်းအရာအစစ် ထည့်ပြီးမှ ဖွင့်ပါ။
5. **Page token က ~60 days ပဲ ခံပါတယ်** — သက်တမ်းကုန်ရင် Phase 8 ပြန်လုပ်ပါ။

---

*Built from Ko's real journey, 2026-11-09 → 2026-11-10. Ai Mindset — Building a smarter future for Myanmar through AI and technology.*

*Commit history note: previous commit message typo fixed (AWS 200 USD).*
