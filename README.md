# Look Outside — Tradução PT-BR

Tradução de fãs do jogo **Look Outside** para o **português do Brasil**: diálogos, escolhas, menus, itens, habilidades, descrições, batalhas, chats, créditos e textos da interface.

> **Versão da tradução:** V1
> **Compatível com:** Look Outside **patch 2.30 (build 12)**, versão Steam. A versão aparece no canto da tela de título.

## ⬇️ Download

Baixe na página da [**Release v1.0**](https://github.com/Subexe/look-outside-ptbr/releases/tag/v1.0):

| Arquivo | Para quem |
|---|---|
| [**Instalador Look Outside PT-BR V1.exe**](https://github.com/Subexe/look-outside-ptbr/releases/download/v1.0/Instalador.Look.Outside.PT-BR.V1.exe) | Recomendado: instala sozinho, acha o jogo na Steam |
| [**Look Outside PT-BR V1 - instalacao manual.zip**](https://github.com/Subexe/look-outside-ptbr/releases/download/v1.0/Look.Outside.PT-BR.V1.-.instalacao.manual.zip) | Para quem prefere só extrair e substituir |

---

## Como funciona

A tradução é **um plugin** (`js/plugins/PTBR_Traducao.js`) que troca os textos do jogo **enquanto ele roda**.

- **Nenhum arquivo original do jogo é alterado:** `data/`, imagens e áudio ficam intactos.
- A única mudança é **uma linha** no `js/plugins.js`, que ativa o plugin.
- Desinstalar deixa o jogo exatamente como era.

## Instalação pelo instalador (.exe)

1. **Feche o jogo.**
2. Abra o `Instalador Look Outside PT-BR V1.exe`.
3. Se o Windows mostrar **"O Windows protegeu o computador"** (SmartScreen), clique em **"Mais informações"** e depois em **"Executar assim mesmo"**. O aviso aparece porque o instalador não tem assinatura digital paga, não porque haja algo errado com ele.
4. O instalador **encontra a pasta do jogo na Steam sozinho**, em qualquer biblioteca e em qualquer disco. Se o jogo estiver em outro lugar, clique em **Procurar…** e escolha a pasta onde está o `Game.exe`.
5. Clique em **Avançar** e depois em **Instalar**.
6. Abra o jogo normalmente pela Steam.

O que o instalador faz:
- copia **só** o arquivo da tradução, `js\plugins\PTBR_Traducao.js`;
- acrescenta **uma linha** no `js\plugins.js` para ativá-la, guardando antes uma cópia de segurança em `js\plugins.js.original_ptbr_backup`;
- não pede permissão de administrador. Se a pasta do jogo estiver protegida, ele avisa para abrir com **botão direito → Executar como administrador**.

> 💡 Se o Windows bloquear o `.exe` por completo (por exemplo, com o **Controle Inteligente de Aplicativos** ligado), use a instalação manual pelo `.zip`. O resultado é o mesmo.

## Instalação manual (.zip)

O `.zip` tem a **mesma estrutura de pastas do jogo**.

1. **Feche o jogo.**
2. Na Steam, clique com o botão direito em **Look Outside → Gerenciar → Navegar pelos arquivos locais**.
   Caminho padrão: `C:\Program Files (x86)\Steam\steamapps\common\Look Outside`
3. Faça uma cópia de segurança do arquivo `js\plugins.js` do jogo.
4. Extraia o `.zip` **dentro dessa pasta** e aceite **substituir** os arquivos. Isso coloca:
   - `js\plugins\PTBR_Traducao.js`: a tradução;
   - `js\plugins.js`: a lista de plugins do jogo, com a tradução ativada.
5. Abra o jogo normalmente.

### Se o jogo receber uma atualização

O `plugins.js` do `.zip` foi feito para o **patch 2.30 (build 12)**. Depois de uma atualização do jogo, **não substitua** o `plugins.js`. Faça assim:
- copie só o `PTBR_Traducao.js` para `js\plugins\`;
- abra o `js\plugins.js` do jogo num editor de texto e, antes do último `]`, acrescente uma vírgula e esta linha:

```
{"name":"PTBR_Traducao","status":true,"description":"[PT-BR] Traducao de Look Outside","parameters":{}}
```

Ou use o instalador, que faz isso sozinho em qualquer versão.

## Desinstalação

- **Se instalou pelo `.exe`:** vá em **Configurações do Windows → Aplicativos → Aplicativos instalados**, procure **"Look Outside - Tradução PT-BR V1"** e clique em **Desinstalar**. Só a linha da tradução sai do `plugins.js`, mesmo que o jogo tenha sido atualizado depois.
- **Se instalou pelo `.zip`:** apague `js\plugins\PTBR_Traducao.js` e volte o `plugins.js` da sua cópia de segurança.
- **Em qualquer caso:** na Steam, **Propriedades → Arquivos instalados → Verificar integridade dos arquivos** devolve o `plugins.js` original. Depois apague o `PTBR_Traducao.js`, se quiser.

## Observações

- Nomes de inimigos, títulos de jogos dentro do jogo (Wizards Hell, Mazes & Wizards…), marcas e nomes de usuário dos chats ficam em inglês, de propósito.
- Textos que fazem parte de **imagens** do jogo, como o "The End" de um dos finais e os logos, ficam no original para não mexer nos arquivos nativos.
- Encontrou um texto em inglês, cortado ou estranho? Abra uma [**Issue**](https://github.com/Subexe/look-outside-ptbr/issues) com um print e, se possível, onde aconteceu.

## Conteúdo deste repositório

```
js/
  plugins.js                  lista de plugins do jogo (patch 2.30 build 12) com a tradução ativada
  plugins/PTBR_Traducao.js    a tradução
instalador/
  LookOutsidePTBR.iss         script do instalador (Inno Setup 6)
  wizard*.bmp, small*.bmp     imagens das telas do instalador
  icon.ico                    ícone
  LEIA-ME - Traducao PT-BR.txt  instruções que vão dentro do .zip
```

### Gerar o instalador

1. Instale o [Inno Setup 6](https://jrsoftware.org/isinfo.php).
2. Rode na pasta `instalador`:

```
ISCC.exe LookOutsidePTBR.iss
```

O `.exe` sai em `instalador\output\`.

## Aviso

Tradução de fãs, sem fins lucrativos e **sem ligação** com os criadores do jogo. **Look Outside** é propriedade de seus respectivos donos (Francis Coulombe / Devolver Digital). Para jogar, compre o jogo original na Steam.
