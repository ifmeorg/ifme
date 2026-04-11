## 🗓️ Semana 0 (05-10 Abril 2026)

### 📅 **Data:** 10/04/2026
### 🎯 **Projeto Atual:** if-me.org - Setup + Primeiro PR
### ⏱️ **Tempo Investido:** ~8h

---

### ✅ **O que foi feito:**
- [x] WSL 2 + Docker configurado (Notebook + Desktop)
- [x] Fork do if-me.org criado
- [x] Clone local
- [x] Dockerfile corrigido (Node 14 → 20)
- [x] Build bem-sucedido
- [x] Banco criado e populado (db:create db:migrate db:seed)
- [x] Projeto rodando em localhost:3000
- [x] **PRIMEIRO PR ABERTO! 🎉**
    - PR #2419: Update Node.js from 14 to 20 in Dockerfile
    - Link: https://github.com/ifmeorg/ifme/pull/2419

### ❌ **O que NÃO foi feito:**
- Ler CONTRIBUTING.md (deixei pra semana 1)
- Explorar código React (foco foi setup)

### 🎓 **Aprendizados da semana:**
- **Docker:** Conceito de containers, images, volumes, compose
- **Git Workflow:** Fork → Clone → Branch → Commit → Push → PR
- **WSL 2:** Configuração no Windows, integração com Docker
- **Troubleshooting:** Hypervisor, Node.js EOL, package.json corrompido
- **OSS Process:** Como abrir PR, code review, CI/CD pipelines

### 🚧 **Bloqueios encontrados:**
1. **Hypervisor desabilitado (Desktop Win 10):**
    - Resolvido com `bcdedit /set hypervisorlaunchtype auto`
2. **Node.js 14 EOL no Dockerfile:**
    - Resolvido atualizando para Node 20
3. **Package.json corrompido:**
    - Resolvido baixando do GitHub raw
4. **DOMPurify incompatibilidade:**
    - Resolvido com Node 20

### 💡 **Insights / Descobertas:**
- Projetos OSS têm comunidades acolhedoras!
- 30min/dia É suficiente para progresso real
- Docker facilita MUITO setup de projetos complexos
- Troubleshooting ensina mais que tutorial

### 📈 **Progresso em relação à meta:**
**Meta geral:** 5-6 PRs em 90 dias  
**Progresso:** 1/6 PRs abertos (16%)  
**Status:** 🎉 ACIMA DA META! (esperado 0 na semana 0)

### 🎯 **Plano para próxima semana:**
1. Aguardar feedback do PR #2419
2. Ler CONTRIBUTING.md do if-me.org
3. Explorar estrutura de código React
4. Entender arquitetura Rails + React
5. Procurar issue `good first issue` para PR #2

### 🌟 **Celebração:**
🎊 **PRIMEIRO PR OPEN SOURCE ABERTO!!!**
🎊 Setup completo em 2 PCs
🎊 Projeto rodando localmente
🎊 Semana 0 = SUCESSO TOTAL!