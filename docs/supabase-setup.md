# Supabase setup

Projeto alvo:

```text
https://puqgefbsrknxhpeafsjq.supabase.co
```

## 1. Criar tabela de leads

No dashboard do Supabase, abra SQL Editor e execute:

```text
supabase/migrations/20260709120000_create_quiz_leads.sql
```

A tabela criada sera `public.quiz_leads`, com colunas separadas para:

- data e horario: `created_at`
- nome: `lead_name`
- WhatsApp: `whatsapp`, `whatsapp_digits`
- interesse: `interest`
- entrada: `has_down_payment`, `down_payment_value`
- parcela: `monthly_payment_value`
- prazo: `purchase_timeline`
- rastreamento: `utm_*`, `fbclid`, `fbp`, `fbc`
- Meta CAPI: `meta_event_id`, `meta_conversion_sent`, `meta_conversion_response`, `meta_conversion_error`
- respostas completas: `raw_answers`

## 2. Ativar salvamento pelo site no GitHub Pages

Configurar variavel e secret no GitHub:

```bash
gh variable set SUPABASE_URL --body "https://puqgefbsrknxhpeafsjq.supabase.co" --repo marcosviniiciusfs-png/quiz-hurtzcompany
gh secret set SUPABASE_ANON_KEY --repo marcosviniiciusfs-png/quiz-hurtzcompany
```

Use a chave `anon public` em Project Settings > API.

O workflow de deploy cria `config.js` automaticamente com esses valores.

## 3. Edge Function para Meta Conversions API

Deploy da function:

```bash
supabase functions deploy submit-qualified-lead --project-ref puqgefbsrknxhpeafsjq
```

Secrets necessarios:

```bash
supabase secrets set META_PIXEL_ID="SEU_PIXEL_ID" --project-ref puqgefbsrknxhpeafsjq
supabase secrets set META_ACCESS_TOKEN="SEU_TOKEN_DA_CONVERSIONS_API" --project-ref puqgefbsrknxhpeafsjq
```

Sem esses secrets, o lead ainda pode ser salvo no banco, mas a conversao da Meta nao sera enviada.
