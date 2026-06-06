# Task RPG Rails

App pessoal de organizacao, captura rapida e gamificacao leve.

## Rodar local

```powershell
docker compose build
docker compose up
```

Abrir: http://localhost:3001

## Primeiro uso

1. Criar conta na tela inicial.
2. Copiar token em `Perfil / API` quando a tela existir.
3. Para Atalhos do iPhone, usar `POST /api/capture` com header `Authorization: Bearer TOKEN`.

Payload:

```json
{ "text": "Comprar paprica amanha 18h" }
```

## Ideia do produto

- Inbox para despejar tarefa sem pensar.
- Hoje, Semana e Atrasadas para execucao.
- Projetos e tags para organizar depois.
- XP, nivel, streak e badges para dar vontade de limpar pendencias.

## Estado

V1 local. Sem deploy, sem Supabase, sem Vercel.
